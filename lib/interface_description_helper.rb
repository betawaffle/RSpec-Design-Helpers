#Offers helper methods for all model classes

module InterfaceDescriptionSpecHelper
  # *methods - subject#send-able method names
  def implements(*methods)
    methods.each do |method|
      it("implements ##{method}") {subject.should respond_to(method)}
    end
  end

  # *methods - described_class#send-able method names
  def class_implements(*methods)
    methods.each do |method|
      it("implements .#{method}") {described_class.should respond_to(method)}
    end
  end

  # fields - a Hash of sample assignment values that should be persisted after a #save and #reload. The
  #     key is an attribute name, and the value is both the assigned value and the expected value of 
  #     the attribute after a save and reload. 
  def persists(fields={})
    it("saves") { subject.should respond_to(:save) }
    fields.each_pair do |field, valid_value|
      it("persists #{field}") do
        subject.send(field.to_s + '=', valid_value)
        subject.save
        subject.reload.send(field).should == valid_value
      end
    end
  end

  #Verifies that the subject receives :<field>= for each field when calling subject.<using>(<with>)
  def sets(*args)
    params = args.extract_options!
    m = params[:method]
    p = params[:params].is_a?(Enumerable) ? params[:params] : [params[:params]]

    args.each do |field|
      it "sets the #{field}" do
        subject.should_receive(:"#{field}=")
        subject.send(:"#{m}", *p)
      end

      it "assigns the #{field}" do
        subject.send(:"#{m}", *p)
        subject.send(:"#{field}").should_not be_nil
      end
    end
  end
end

describe User do
  extend InterfaceDescriptionSpecHelper

  implements :name, :birthdate
  class_implements :find, :where, :order, :limit

  SAMPLE_VALUES = {
    :name      => "Bobby Tables",
    :birthdate => 20.years.ago
  }

  persists SAMPLE_VALUES
end