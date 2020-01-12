require_relative "../../lib/dijkstra"
require_relative "../../lib/graph"

RSpec.describe Dijkstra do
  subject { described_class.new(graph) }

  context "2" do
    let(:graph) do
      Graph.new
        .add_edge("A", "B", effort: 2)
        .add_edge("A", "C", effort: 13)
        .add_edge("A", "E", effort: 4)
        .add_edge("B", "D", effort: 3)
        .add_edge("D", "G", effort: 5)
        .add_edge("C", "F", effort: 17)
        .add_edge("G", "I", effort: 1)
        .add_edge("G", "F", effort: 11)
        .add_edge("F", "H", effort: 6)
        .add_edge("F", "E", effort: 7, one_way: true)
    end

    it "finds the shortest path between A and F" do
      result = subject.shortest_path(start: "A", finish: "F")

      expect(result.cumulative_effort).to eq(21)
      expect(result.to_s).to eq("ABDGF")
      expect(result.pretty).to eq("A(0) -2-> B(2) -3-> D(5) -5-> G(10) -11-> F(21)")
    end

    it "finds the shortest path between I and C" do
      result = subject.shortest_path(start: "I", finish: "C")

      expect(result.cumulative_effort).to eq(24)
      expect(result.to_s).to eq("IGDBAC")
    end

    it "finds the shortest path between H and A" do
      result = subject.shortest_path(start: "H", finish: "A")

      expect(result.cumulative_effort).to eq(17)
      expect(result.to_s).to eq("HFEA")
    end
  end
end
