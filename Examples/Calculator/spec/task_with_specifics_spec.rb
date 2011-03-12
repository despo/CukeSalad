$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'bundler'
require 'task_with_specifics'
Bundler.setup

class MyTask < TaskWithSpecifics
  attr_reader :specifics
end

describe TaskWithSpecifics do

  it "has an item of specific information" do
    task = MyTask.new "specific 'information'"
    task.specifics.first.specific.should == "information"
  end

  it "has items of specific information" do
    task = MyTask.new "first 'item' second 'another'"
    task.specifics.first.first.should == "item"
    task.specifics.first.second.should == "another"
  end

  it "should cope with names having more than one word" do
    task = MyTask.new "first thing 'item' second thing 'another'"
    task.specifics.first.first_thing.should == "item"
    task.specifics.first.second_thing.should == "another"
  end
end
