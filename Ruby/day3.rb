=begin

Modify the CSV application to support an each method to return a
CsvRow object. Use method_missing on that CsvRow to return the value
for the column for a given heading.
For example, for the file:
one, two
lions, tigers
allow an API that works like this:
csv = RubyCsv.new
csv.each {|row| puts row.one}
This should print "lions".

=end

module ActsAsCsv

    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_csv
            include InstanceMethods
            # filter, map, etc
            include Enumerable
        end
    end

    module InstanceMethods

        class CsvRow
            attr_accessor :row, :headers

            def initialize(row=[], headers=[])
                @row = row
                @headers = headers
            end

            def method_missing name, *args, &block
                pos = @headers.index(name.to_s)
                # if method doesn't exist on CsvRow try searching it on the `Object` class to call with the arguments and block reference
                pos ? @row[pos] : super
            end

            # if the method doesn't exist on CsvRow try searching it on the `Object` class to verify if it exist
            # better practice to change `respond_to_missing?` instead of `respont_to?`
            def respond_to_missing?(name, include_private = false)
                @headers.index(name.to_s) || super
            end
        end

        def parse_line(row)
            row.chomp.split(', ')
        end

        def read
            @csv_contents = []
            filename = self.class.to_s.downcase + '.txt'
            file = File.open(filename)
            @headers = parse_line file.gets

            file.each do |row|
                csv_row = CsvRow.new(parse_line(row), @headers)
                @csv_contents << csv_row
            end
        end

        attr_accessor :headers, :csv_contents

        def initialize
            read
        end

        def each
            @csv_contents.each do |row|
                yield row
            end
        end

    end

end

class RubyCsv
    include ActsAsCsv
    acts_as_csv
end

#test

csv = RubyCsv.new
puts csv.headers.inspect
puts csv.csv_contents.inspect
csv.each {|row| puts row.two}
csv.each {|row| puts row.one}
