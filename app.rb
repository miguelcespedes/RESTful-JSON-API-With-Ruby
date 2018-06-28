#!/usr/bin/ruby
require "sinatra"
require "json"
require "launchy"

class Response
  attr_accessor :header, :body

  def initialize(header, body)
    @header = header
    @body = body
  end

  def as_json(options = {})
    return {header: @header, body: @body}
  end

  def to_json(*options)
    return as_json(*options).to_json(*options)
  end
end

def rest
  get "/" do
    arr = (-8..4).to_a
    return JSON.pretty_generate(Response.new("success", {:total => arr.size, :data => arr}))
  end
end

def main
  thread_1 = Thread.new { rest() }
  thread_1.join
  thread_2 = Thread.new { Launchy.open("http://localhost:4567") }
  thread_2.join
end

main()
