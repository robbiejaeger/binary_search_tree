require "minitest/autorun"
require "minitest/pride"
require "../lib/tree"
require "../lib/node"

class BinarySearchTreeTest < Minitest::Test

  def test_tree_can_exist
    tree = Tree.new

    assert_equal Tree, tree.class
  end

  def test_node_can_exist
    key = 0
    data = ""

    node = Node.new(key,data)

    assert_equal Node, node.class
  end

  def test_insert_node_into_empty_tree_is_a_node_class
    key = 10
    data = "Ghostbusters"

    tree = Tree.new
    tree.insert(key, data)
    root = tree.root

    assert_equal Node, root.class
  end

  def test_insert_node_into_empty_tree_has_key_and_data
    key = 5
    data = "Star Wars"

    tree = Tree.new
    tree.insert(key, data)
    root = tree.root

    assert_equal 5, root.key
    assert_equal "Star Wars", root.data
  end

  def test_node_after_root_is_left
    key1 = 5
    data1 = "My Fair Lady"
    key2 = 2
    data2 = "Harry Potter"

    tree = Tree.new
    tree.insert(key1, data1)
    tree.insert(key2, data2)

    assert_equal 2, tree.root.left.key
  end

  def test_node_after_root_is_right
    key1 = 5
    data1 = "My Fair Lady"
    key2 = 10
    data2 = "Harry Potter"

    tree = Tree.new
    tree.insert(key1, data1)
    tree.insert(key2, data2)

    assert_equal 10, tree.root.right.key
  end

  def test_tree_can_have_nodes_beyond_root_nodes
    key1 = 30
    data1 = "Ghostbusters"
    key2 = 15
    data2 = "Mean Girls"
    key3 = 35
    data3 = "Grumpy Old Men"
    key4 = 10
    data4 = "Dances With Wolves"

    tree = Tree.new
    depth1 = tree.insert(key1, data1)
    depth2 = tree.insert(key2, data2)
    depth3 = tree.insert(key3, data3)
    depth4 = tree.insert(key4, data4)

    assert_equal 0, depth1
    assert_equal 1, depth2
    assert_equal 1, depth3
    assert_equal 2, depth4

    assert_equal "Ghostbusters", tree.root.data
    assert_equal "Grumpy Old Men", tree.root.right.data
    assert_equal "Mean Girls", tree.root.left.data
    assert_equal "Dances With Wolves", tree.root.left.left.data
  end

  def test_if_no_root_include_is_false
    tree = Tree.new

    includes = tree.include?(10)

    assert_equal false, includes
  end

  def test_if_tree_includes_node
    tree = Tree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert tree.include?(61)
    assert tree.include?(16)
    assert tree.include?(92)
    assert tree.include?(50)

    refute tree.include?(100)
    refute tree.include?(51)
  end

  def test_if_no_node_depth_is_nil
    tree = Tree.new

    depth = tree.depth_of(10)

    assert_equal nil, depth
  end

  def test_depth_of_root_is_zero
    tree = Tree.new
    tree.insert(10, "Apollo 13")

    depth = tree.depth_of(10)

    assert_equal 0, depth
  end

  def test_depth_of_more_nodes
    tree = Tree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    depth1 = tree.depth_of(92)
    depth2 = tree.depth_of(50)

    assert_equal 1, depth1
    assert_equal 2, depth2
  end

  def test_max_of_empty_tree_is_nil
    tree = Tree.new

    max = tree.max

    assert_equal nil, max
  end

  def test_max_of_tree_with_only_root_is_root
    tree = Tree.new
    tree.insert(10, "My Little Pony")
    hash = {"My Little Pony" => 10}

    max = tree.max

    assert_equal hash, max
  end

  def test_max_of_multiple_nodes
    tree = Tree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    hash = {"Sharknado 3" => 92}

    max = tree.max

    assert_equal hash, max
  end

  def test_min_of_empty_tree_is_nil
    tree = Tree.new

    min = tree.min

    assert_equal nil, min
  end

  def test_min_of_tree_with_only_root_is_root
    tree = Tree.new
    tree.insert(10, "My Little Pony")

    min = tree.min

    assert_equal ({"My Little Pony" => 10}), min
  end

  def test_min_of_multiple_nodes
    tree = Tree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    min = tree.min

    assert_equal ({"Johnny English" => 16}), min
  end

  def test_read_can_load_a_file
    tree = Tree.new
    file = "../lib/movies_short_list.txt"

    output = tree.read_text_file(file)

    array = [["13","9 Muses of Star Empire"], ["39","A Place on Earth"]]
    assert_equal array, output
  end

  def test_can_insert_couple_movies_from_text_file
    tree = Tree.new
    file = "../lib/movies_short_list.txt"

    num = tree.load(file)

    assert_equal 2, num
  end

  def test_load_file_with_same_values_inserts_correct_num
    tree = Tree.new
    file = "../lib/movies_repeats.txt"

    num = tree.load(file)

    assert_equal 2, num
  end

  def test_load_file_with_same_values_already_in_tree_inserts_correct_num
    tree = Tree.new
    tree.insert(13, "Superman")
    file = "../lib/movies_repeats.txt"

    num = tree.load(file)

    assert_equal 1, num
  end

  def test_can_load_many_movies_from_text_file
    tree = Tree.new
    file = "../lib/movies.txt"

    num = tree.load(file)

    assert_equal 99, num
  end

  def test_can_sort_three_nodes
    tree = Tree.new
    tree.insert(50, "Forest Gump")
    tree.insert(40, "Lincoln")
    tree.insert(60, "The Goonies")

    sorted = tree.sort

    array = [{"Lincoln" => 40}, {"Forest Gump" => 50}, {"The Goonies" => 60}]
    assert_equal array, sorted
  end

  def test_can_sort_many_nodes
    tree = Tree.new
    tree.insert(50, "Forest Gump")
    tree.insert(40, "Lincoln")
    tree.insert(60, "The Goonies")
    tree.insert(75, "Remember the Titans")
    tree.insert(45, "The Wedding Singer")
    tree.insert(1, "Mars Attacks")
    tree.insert(99, "Gremlins")

    sorted = tree.sort

    array = [{"Mars Attacks"=>1}, {"Lincoln"=>40}, {"The Wedding Singer"=>45}, {"Forest Gump"=>50}, {"The Goonies"=>60}, {"Remember the Titans"=>75}, {"Gremlins"=>99}]
    assert_equal array, sorted
  end

  def test_can_covert_node_to_hash
    tree = Tree.new
    tree.insert(50, "Patch Adams")

    converted = tree.root.convert_node_to_hash(tree.root)

    key = tree.root.key
    data = tree.root.data
    hash = {"Patch Adams" => 50}
    assert_equal hash, converted
  end

  def test_health_of_empty_tree
    tree = Tree.new

    health = tree.health(0)

    assert_equal nil, health
  end

  def test_health_of_tree_for_root_node_only
    # skip
    tree = Tree.new
    tree.insert(60, "Lion King")

    health = tree.health(0)

    assert_equal [[60, 1, 100]], health
  end

  def test_health_of_tree_at_depth_zero_with_one_child
    # skip
    tree = Tree.new
    tree.insert(60, "Lion King")
    tree.insert(50, "Alien")

    health = tree.health(0)

    assert_equal [[60, 2, 100]], health
  end

  def test_can_get_health_of_many_nodes
    # skip
    tree = Tree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    health1 = tree.health(0)
    health2 = tree.health(1)
    health3 = tree.health(2)

    assert_equal [[98, 7, 100]], health1
    assert_equal [[58, 6, 85]], health2
    assert_equal [[36, 2, 28], [93, 3, 42]], health3
  end

  def test_gets_total_number_of_nodes
    tree = Tree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    num = tree.total_nodes

    assert_equal 7, num
  end

  def test_can_get_array_of_nodes_at_depth
    tree = Tree.new
    tree.insert(50, "Animals United")
    tree.insert(90, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    depth = 1

    node_array = tree.root.in_order_traverse(tree.root)

    depth_array = node_array.reject{|node| node.depth != depth}

    assert_equal [tree.root.left, tree.root.right], depth_array
  end

  def test_can_convert_nodes_to_keys
    tree = Tree.new
    tree.insert(50, "Animals United")
    tree.insert(90, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    depth = 1

    node_array = tree.root.in_order_traverse(tree.root)

    depth_array = node_array.reject{|node| node.depth != depth}

    key_array = tree.nodes_to_key(depth_array)

    assert_equal [36, 90], key_array
  end

  def test_can_get_number_of_children_for_each_node
    tree = Tree.new
    tree.insert(50, "Animals United")
    tree.insert(90, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    depth = 1

    node_array = tree.root.in_order_traverse(tree.root)

    depth_array = node_array.reject{|node| node.depth != depth}

    num_children_plus_array = tree.get_num_children(depth_array)

    assert_equal [1, 1], num_children_plus_array
  end

  def test_can_convert_to_percentages
    tree = Tree.new
    tree.insert(50, "Animals United")
    tree.insert(90, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    depth = 1

    node_array = tree.root.in_order_traverse(tree.root)

    depth_array = node_array.reject{|node| node.depth != depth}

    num_children_plus_array = tree.get_num_children(depth_array)

    percentages = tree.get_health_percentages(num_children_plus_array)

    assert_equal [33, 33], percentages
  end

end
