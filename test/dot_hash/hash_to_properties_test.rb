require_relative "../test_helper"

describe Hash do
  attr_reader :properties

  describe "#to_properties" do
    before do
      @properties = {
        "price" => 10,
        info: {name: "eagle"},
        :foo => [{name: :bar},{name: :baz}],
        tax: nil
      }.to_properties
    end

    it "returns a DotHash object" do
      properties.must_be_instance_of DotHash::Properties
    end

    it "gets nested properties" do
      properties.info.name.must_equal "eagle"
    end

    it "gets simple properties" do
      properties.price.must_equal 10
    end

    it "gets properties of hashes in an array" do
      properties.foo.first.name.must_equal :bar
      properties.foo[1].name.must_equal :baz
    end

    it "allows hash values to be nil" do
      properties.tax.must_equal nil
    end
  end
end
