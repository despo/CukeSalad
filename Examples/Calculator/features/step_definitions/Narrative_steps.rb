$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__) + '/../tasks')

require 'calculating_individual' #TODO: remove the need for require so that the Narrative_steps can come from a gem

class Actor
  def initialize role
    @character = role.new
  end
  
  def perform task
    task.perform_as @character
  end
  alias :answer :perform
end

class Librarian
  def class_for this_thing
    Kernel.const_get( class_name_from this_thing) ##TODO: Do we need a better solution? Maybe ActiveSupport constantize
  end

  def class_name_from this_sentence
    class_name = ""
    this_sentence.downcase.split(" ").each do |word|
      class_name = class_name + word.capitalize
    end
    class_name
  end
end

class SubjectMatterExpert
  
  def how_do_i_perform this_task, with_information =nil #TODO: must get rid of nil
    task = Librarian.new.class_for( this_task )
    if with_information == nil
      task.new
    else
      task.new arguments_from( with_information )
    end
  end
  alias :how_do_i_answer :how_do_i_perform
    
  def method_for something
    something.downcase.gsub(" ","_").to_sym 
  end
  
  def arguments_from this_information
    this_information.gsub("'","").gsub("and","").split(" ") unless this_information == nil
  end
end

Before do
    @sme = @sme ||= SubjectMatterExpert.new
end

Given /^I am a ([a-zA-Z ]+)$/ do |role|
  @actor = Actor.new(Librarian.new.class_for role)
end

When /^I (?:attempt to|was able to)? ([^']*)$/ do |this_task|
  task = @sme.how_do_i_perform this_task
  @actor.perform task
end

When /^I (?:attempt to|was able to)? ([^']*) '(.*)'$/ do |this_task, with_information|
  task = @sme.how_do_i_perform this_task, with_information
  @actor.perform task
end

Then /^I should ([^']*) '([^']*)'$/ do |this_question, expect_value|
  question = @sme.how_do_i_answer this_question
  @actor.answer( question ).to_s.should == expect_value
end