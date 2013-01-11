require File.expand_path("../test_helper", __FILE__)

module DotHash
  describe Properties do
    attr_reader :settings

    describe "with a simple hash" do
      before do
        @settings = Properties.new speed: "15", "power" => 100
      end

      it "gets a hash property using the dot notation" do
        settings.speed.must_equal "15"
      end

      it "raises an error if the method is not on the hash" do
        -> {settings.name}.must_raise NoMethodError
      end

      it "gets a property from a stringed key" do
        settings.power.must_equal 100
      end
    end

    describe "with a nested hash" do
      before do
        @settings = Properties.new user: {
          "info" => {name: "dude", is_admin: false}
        }
      end

      it "returns a DotHash instence for property with a nested hash" do
        settings.user.must_be_instance_of DotHash::Properties
      end

      it "gets chained properties" do
        settings.user.info.name.must_equal "dude"
        settings.user.info.is_admin.must_equal false
      end

    end

  end
end
