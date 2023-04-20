## Find out how to access files with and without code blocks. What is the benefit of the code block?

# Without code blocks
file = File.open("file.txt", "r")
# Manually close
file.close

# With code blocks
File.open("file.txt", "r") do |file|
  file.each_line do |line|
    # Acess to individual lines
    # Close automatically
  end
end
#OR
IO.foreach("file.txt") { |line|  }

## How would you translate a hash to an array? Can you translate arrays to hashes?

hash = {"a" => 1, "b" => 2}
array = hash.to_a
# => [["a", 1], ["b", 2]]

array = [["a", 1], ["b", 2]]
hash = array.to_h
# => {"a" => 1, "b" => 2}

## Can you iterate through a hash?
hash = {"a" => 1, "b" => 2, "c" => 3}
# 3 Ways
hash.each do |key, value|
  # Acess to key and value
end
hash.each_key do |key|
  # Acess to key
end
hash.each_value do |val|
  # Acess to value
end

## You can use Ruby arrays as stacks. What other common data structures do arrays support?
# Queues, Hash tables, Heaps, children nodes in Trees

## Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now, do the same with each_slice in Enumerable
# List comprehension
array = (0..15).to_a
# OR
array = (0..15).map{ |x| x}
# each
count = 0
array.each do |num|
  p num
  count += 1
  p "\n" if count % 4 == 0
end
# each_slice
array.each_slice(4) { |slice| p slice}

## The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {’grandpa’ => { ’dad’ => {’child 1’ => {}, ’child 2’ => {} }, ’uncle’ => {’child 3’ => {}, ’child 4’ => {} } } }
class Tree
    attr_accessor :children, :node_name

    def initialize(tree_hash)
        # keys = parents
        # vals = children
        # First key of the hash is the first node
        @node_name = tree_hash.keys.first
        # Transforming each key-val pair into a tree branch
        @children = tree_hash[@node_name].map{ |key, val| Tree.new(key => val) }
    end

    def visit_all(&block)
        visit(&block)
        children.each{ |c| c.visit_all(&block) }
    end

    def visit
        yield self
    end
end
mytree = Tree.new({'grandpa' => {'dad' => {'child1' => {}, 'child2' => {}, 'uncle' => {'child3' => {}, 'parent' => {'child5' => {}, 'child6' => {}}}}}})
mytree.visit_all{ |node| puts node.node_name }

## Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression match and read lines from a file. (This is surprisingly simple in Ruby.) If you want, include line numbers.

File.open("file2.txt", "r") do |file|
    file.each_line do |line|
        p line if line.include?("community")
    end
end
