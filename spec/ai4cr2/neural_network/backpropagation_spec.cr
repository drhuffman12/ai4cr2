require "./../../spec_helper"
require "./../../../src/ai4cr2/neural_network/backpropagation"

describe Ai4cr2::NeuralNetwork::Backpropagation do
  describe "#init_network" do
    describe "when given a net with structure of [4, 2]" do
      structure = [4, 2]
      inputs = [1, 2, 3, 4]
      outputs = [5, 6]
      expected_activation_nodes = [[1.0, 1.0, 1.0, 1.0, 1.0], [1.0, 1.0]]
      expected_weights_size = 1
      expected_weights_first_size = 5
      expected_weights_first_sub_size = 2
      net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure).init_network

      it "sets @activation_nodes to expected nested array" do
        net.activation_nodes.should eq(expected_activation_nodes)
      end

      it "sets @weights to expected size" do
        net.weights.size.should eq(expected_weights_size)
      end

      it "sets @weights.first to expected size" do
        net.weights.first.size.should eq(expected_weights_first_size)
      end

      it "sets each sub-array w/in @weights.first to expected size" do
        net.weights.first.each do |weights_n|
          weights_n.size.should eq(expected_weights_first_sub_size)
        end
      end

      # TODO: uncomment and fix
      # describe "#train" do
      #   it "returns a Float64" do
      #     net.train(inputs, outputs).should be_a(Float64)
      #   end

      #  it "updates the net" do
      #     net.train(inputs, outputs)
      #     net.activation_nodes.should_not eq(expected_activation_nodes)
      #   end
      # end
    end

    describe "when given a net with structure of [2, 2, 1]" do
      structure = [2, 2, 1]
      inputs = [1, 2]
      outputs = [3]
      expected_activation_nodes = [[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0]]
      expected_weights_size = 2
      expected_weights_first_size = 3
      expected_weights_first_sub_size = 2
      net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure).init_network

      it "sets @activation_nodes to expected nested array" do
        net.activation_nodes.should eq(expected_activation_nodes)
      end

      it "sets @weights to expected size" do
        net.weights.size.should eq(expected_weights_size)
      end

      it "sets @weights.first to expected size" do
        net.weights.first.size.should eq(expected_weights_first_size)
      end

      it "sets each sub-array w/in @weights.first to expected size" do
        net.weights.first.each do |weights_n|
          weights_n.size.should eq(expected_weights_first_sub_size)
        end
      end

      # TODO: uncomment and fix
      # describe "#train" do
      #   it "returns a Float64" do
      #     net.train(inputs, outputs).should be_a(Float64)
      #   end

      #   it "updates the net" do
      #     net.train(inputs, outputs)
      #     net.activation_nodes.should_not eq(expected_activation_nodes)
      #   end
      # end
    end

    describe "when given a net with structure of [2, 2, 1] with bias disabled" do
      structure = [2, 2, 1]
      inputs = [1, 2]
      outputs = [3]
      expected_activation_nodes = [[1.0, 1.0], [1.0, 1.0], [1.0]]
      expected_weights_size = 2
      expected_weights_first_size = 2 # one less than prev example since bias is disabled here
      expected_weights_first_sub_size = 2
      net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure).init_network
      net.bias_disabled = true
      net.init_network

      it "sets @activation_nodes to expected nested array" do
        net.activation_nodes.should eq(expected_activation_nodes)
      end

      it "sets @weights to expected size" do
        net.weights.size.should eq(expected_weights_size)
      end

      it "sets @weights.first to expected size" do
        net.weights.first.size.should eq(expected_weights_first_size)
      end

      it "sets each sub-array w/in @weights.first to expected size" do
        net.weights.first.each do |weights_n|
          weights_n.size.should eq(expected_weights_first_sub_size)
        end
      end

      describe "#train" do
        # TODO: uncomment and fix
        # it "returns a Float64" do
        #   net.train(inputs, outputs).should be_a(Float64)
        # end

        it "updates the net" do
          net.train(inputs, outputs)
          net.activation_nodes.should_not eq(expected_activation_nodes)
        end
      end
    end
  end

  describe "#eval" do
    describe "when given a net with structure of [3, 2]" do
      it "weights do not change" do
        in_size = 3
        out_size = 2
        inputs = [3, 2, 3]
        structure = [in_size, out_size]
        net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure)

        weights_before = net.weights.clone
        net.eval(inputs)
        weights_after = net.weights.clone

        assert_equality_of_nested_list weights_before, weights_after
      end

      it "returns output nodes of expected size" do
        in_size = 3
        out_size = 2
        inputs = [3, 2, 3]
        structure = [in_size, out_size]
        net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure)
        y = net.eval(inputs)
        y.size.should eq(out_size)
      end
    end

    describe "when given a net with structure of [2, 4, 8, 10, 7]" do
      it "returns output nodes of expected size" do
        in_size = 2
        layer_sizes = [4, 8, 10]
        out_size = 7
        structure = [in_size] + layer_sizes + [out_size]
        inputs = [2, 3]
        net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure)
        y = net.eval(inputs)
        y.size.should eq(out_size)
      end
    end
  end

  describe "#dump" do
    describe "when given a net with structure of [3, 2]" do
      structure = [3, 2]
      net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure).init_network
      json = net.to_json
      net2 = Ai4cr2::NeuralNetwork::Backpropagation.from_json(json)

      it "@structure of the dumped net matches @structure of the loaded net" do
        assert_equality_of_nested_list net.structure, net2.structure
      end

      it "@bias_disabled on the dumped net matches @bias_disabled of the loaded net" do
        net.bias_disabled.should eq(net2.bias_disabled)
      end

      it "@learning_rate of the dumped net approximately matches @learning_rate of the loaded net" do
        assert_approximate_equality net.learning_rate, net2.learning_rate
      end

      it "@momentum of the dumped net approximately matches @momentum of the loaded net" do
        assert_approximate_equality net.momentum, net2.momentum
      end

      it "@weights of the dumped net approximately matches @weights of the loaded net" do
        assert_approximate_equality_of_nested_list net.weights, net2.weights
      end

      it "@last_changes of the dumped net approximately matches @last_changes of the loaded net" do
        assert_approximate_equality_of_nested_list net.last_changes, net2.last_changes
      end

      it "@activation_nodes of the dumped net approximately matches @activation_nodes of the loaded net" do
        assert_approximate_equality_of_nested_list net.activation_nodes, net2.activation_nodes
      end

      # it "@error_stats.distance of the dumped net approximately matches @error_stats.distance of the loaded net" do
      #   assert_approximate_equality_of_nested_list net.error_stats.distance, net2.error_stats.distance
      # end
    end
  end

  describe "#train" do
    describe "when given a net with structure of [3, 2]" do
      # before_each do
      structure = [3, 2]
      net = Ai4cr2::NeuralNetwork::Backpropagation.new(structure)
      hard_coded_weights = [
        [
          [-0.9, 0.7],
          [-0.9, 0.6],
          [0.1, 0.2],
          [0.6, -0.3],
        ],
      ]
      expected_deltas_before = [[0.0, 0.0]]
      expected_after_deltas = [[-0.045761358353806764, 0.0031223972161964547]]
      expected_after_weights = [
        [
          [-0.9011440339588452, 0.7000780599304048],
          [-0.9022880679176903, 0.6001561198608099],
          [0.0965678981234645, 0.20023417979121474],
          [0.5885596604115483, -0.2992194006959509],
        ],
      ]
      expected_error = 0.017946235313986033

      inputs = [0.1, 0.2, 0.3]
      outputs = [0.4, 0.5]
      # end

      it "deltas start as zeros" do
        net.init_network
        net.learning_rate = 0.25
        net.momentum = 0.1
        net.weights = hard_coded_weights.clone

        deltas_before = net.deltas.clone

        assert_equality_of_nested_list deltas_before, expected_deltas_before
      end

      it "correctly updates the deltas" do
        net.init_network
        net.learning_rate = 0.25
        net.momentum = 0.1
        net.weights = hard_coded_weights.clone

        deltas_before = net.deltas.clone
        net.train(inputs, outputs)
        deltas_after = net.deltas.clone

        assert_equality_of_nested_list deltas_before, expected_deltas_before
        assert_approximate_equality_of_nested_list deltas_after, expected_after_deltas, 0.0000001
      end

      it "weights do change" do
        net.init_network
        net.learning_rate = 0.25
        net.momentum = 0.1
        net.weights = hard_coded_weights.clone

        weights_before = net.weights.clone
        net.train(inputs, outputs)
        weights_after = net.weights.clone
        assert_inequality_of_nested_list weights_before, weights_after
      end

      it "correctly updates the weights" do
        net.init_network
        net.learning_rate = 0.25
        net.momentum = 0.1
        net.weights = hard_coded_weights.clone

        weights_before = net.weights.clone

        net.train(inputs, outputs)

        weights_after = net.weights.clone

        weights_before.should eq(hard_coded_weights)

        weights_after.should eq(expected_after_weights)
      end

      # TODO: uncomment and fix
      # it "returns an error of type Float64" do
      #   net.init_network
      #   net.learning_rate = 0.25
      #   net.momentum = 0.1
      #   net.weights = hard_coded_weights.clone

      #   error_value = net.train(inputs, outputs)
      #   error_value.should be_a(Float64)
      # end

      # TODO: uncomment and fix
      # it "returns the expected error" do
      #   net.init_network
      #   net.learning_rate = 0.25
      #   net.momentum = 0.1
      #   net.weights = hard_coded_weights.clone

      #   error_value = net.train(inputs, outputs)
      #   error_value.should eq(expected_error)
      # end
    end
  end
end
