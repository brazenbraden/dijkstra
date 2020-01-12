require_relative "../../lib/graph"

RSpec.describe Graph do
  subject { described_class.new }

  describe "#add_edge" do
    before do
      subject
        .add_edge("A", "B", effort: 1)
        .add_edge("A", "C", effort: 5)
        .add_edge("B", "D", effort: 3)
        .add_edge("B", "E", effort: 6)
        .add_edge("C", "E", effort: 9)
        .add_edge("D", "E", effort: 2)
        .add_edge("E", "A", effort: 5, one_way: true)
    end

    let(:edges) do
      lambda do |label|
        subject.nodes[label].edges
      end
    end

    it "finds A's edges" do
      expect(edges.call("A").count).to eq(2)
      expect(edges.call("A").map{|e| e.node.name }).to include("B", "C")
    end

    it "finds E's edges" do
      expect(edges.call("E").count).to eq(4)
      expect(edges.call("E").map{|e| e.node.name }).to include("A", "B", "C", "D")
    end
  end
end
