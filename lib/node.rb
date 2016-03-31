require 'pry'

class Node

  attr_accessor :left, :right, :depth
  attr_reader :key, :data

  def initialize(key, data)
    @key = key
    @data = data
    @left = nil
    @right = nil
    @depth = 0
  end

  def insert(root_node, new_node)
    @depth += 1
    if new_node.key < root_node.key
      if root_node.left == nil
        root_node.left = new_node
      else
        insert(root_node.left, new_node)
      end
    else
      if root_node.right == nil
        root_node.right = new_node
      else
        insert(root_node.right, new_node)
      end
    end
    @depth
  end

  def find_node_by_key(key_to_find, start_node)
    # Test for equivalence
    if start_node.key == key_to_find
      start_node
    else
      # If not equal, test left and right and recurse
      if key_to_find < start_node.key
        return false if start_node.left == nil
        find_node_by_key(key_to_find, start_node.left)
      else
        return false if start_node.right == nil
        find_node_by_key(key_to_find, start_node.right)
      end
    end
  end

  def max(start_node)
    if start_node.right == nil
      start_node
    else
      max(start_node.right)
    end
  end

  def min(start_node)
    if start_node.left == nil
      start_node
    else
      min(start_node.left)
    end
  end

  def in_order_traverse(start_node, array = [])
    if start_node != nil
      in_order_traverse(start_node.left, array)
      array << start_node
      in_order_traverse(start_node.right, array)
    end
    array
  end

  def convert_node_to_hash(node)
    {node.data => node.key}
  end

end
