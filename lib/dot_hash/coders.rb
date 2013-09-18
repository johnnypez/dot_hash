module DotHash
  module Coders

    class Hstore
      def self.dump(obj)
        obj.hash
      end

      def self.load(hash)
        hash.nil? ? {}.to_properties : hash.to_properties
      end
    end


    class JSON
      def self.dump(obj)
        obj.hash
      end

      def self.load(hash)
        hash.nil? ? {}.to_properties : hash.to_properties
      end
    end

  end
end