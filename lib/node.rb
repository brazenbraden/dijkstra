# frozen_string_literal: true
require "set"
require_relative "edge"

class Node
  attr_reader :name, :edges

  def initialize(name)
    @name = name
    @edges = Set.new
  end

  def add_edge(node, effort)
    edges << Edge.new(node, effort)
  end

  def delete!(node)
    edges.reject! { |e| e.node == node }
  end
end
