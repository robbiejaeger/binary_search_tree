require_relative "./node"
require 'pry'

class Tree

  attr_reader :root, :total_nodes

  def initialize
    @root = nil
    @total_nodes = 0
  end

  def insert(key, data)
    if @root == nil
      node = Node.new(key, data)
      @root = node
      @total_nodes += 1
      return 0
    else
      # Go down the tree and insert the node
      node = Node.new(key, data)
      node.insert(@root, node)
      @total_nodes += 1
      node.depth
    end
  end

  def include?(key_to_find)
    if @root == nil
      return false
    else
      node = @root.find_node_by_key(key_to_find, @root)
    end
    if node.class == Node
      return node.data
    else
      return false
    end
  end

  def depth_of(key_to_find)
    if @root != nil
      node = @root.find_node_by_key(key_to_find, @root)
    end
    if node.class == Node
      return node.depth
    end
  end

  def max
    if @root != nil
      node = @root.max(@root)
      node.convert_node_to_hash(node)
    end
  end

  def min
    if @root != nil
      node = @root.min(@root)
      node.convert_node_to_hash(node)
    end
  end

  def load(filepath)
    movie_array = read_text_file(filepath)
    inserted_counter = 0
    movie_array.each do |array|
      if include?(array[0].to_i)
        next
      else
        insert(array[0].to_i, array[1])
        inserted_counter += 1
      end
    end
    inserted_counter
  end

  def read_text_file(filepath)
    lines_array = File.readlines(filepath)
    movie_array = lines_array.map {|line| line.chomp.split(", ")}
  end

  def sort
    # Start at the root node
    node_array = @root.in_order_traverse(@root)
    node_array.map {|node| node.convert_node_to_hash(node)}
  end

  def health(depth)
    if @root != nil
      # Get list of all nodes
      node_array = @root.in_order_traverse(@root)
      # Prune the array for a specific depth
      depth_array = node_array.reject{|node| node.depth != depth}
      # Convert nodes to keys
      key_array = nodes_to_key(depth_array)
      # Get number of children for each node
      num_children_plus_array = get_num_children(depth_array)
      # Find percentage for each node
      percentages = get_health_percentages(num_children_plus_array)
      # Combine arrays into one array
      key_array.zip(num_children_plus_array, percentages)
    end
  end

  def nodes_to_key(array)
    array.map do |node|
      node.key
    end
  end

  def get_num_children(array)
    array.map do |node|
      node.in_order_traverse(node).count
    end
  end

  def get_health_percentages(array)
    array.map do |num|
      ((num.to_f/@total_nodes)*100).floor
    end
  end

end
