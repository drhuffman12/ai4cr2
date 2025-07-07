require "../spec_helper"
require "../../src/ai4cr2/about"

describe Ai4cr2 do
  it "version in shard.yml matches version in Ai4cr2::About::VERSION" do
    (`shards version .`).strip.should eq(Ai4cr2::About::VERSION)
  end
end

