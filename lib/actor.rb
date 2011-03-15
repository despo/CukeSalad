$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'bundler'
require 'director'
Bundler.setup

class Actor

  def initialize role, director=Director.new
    @director = director
    @character = @director.how_do_i_perform role
  end
  
  def perform task_description, *with_these_details
    task = @director.how_do_i_perform task_description, *with_these_details
    task.perform_as @character
  end
  alias :answer :perform
end
