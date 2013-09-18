module DotHash
  class Properties
    attr_reader :hash
    alias_method :to_hash, :hash

    def initialize(hash)
      @hash = hash
    end

    def method_missing(key, *args, &block)
      if has_key?(key)
        get_value(key)
      elsif hash.respond_to?(key)
        hash.public_send(key, *args, &block)
      else
        super
      end
    end

    def respond_to?(key)
      has_key?(key) or hash.respond_to?(key) or super
    end

    def to_s
      hash.to_s
    end

    def to_json
      hash.to_json
    end

    def [](key)
      get_value(key)
    end

    private

    def has_key?(key)
      hash.has_key?(key.to_sym) or hash.has_key?(key.to_s) 
    end

    def get_value(key)
      key = hash.has_key?(key.to_s) ? key.to_s : key.to_sym
      cast_value(hash[key])
    end

    def cast_value(value)
      case value
      when Hash then self.class.new value
      when Array then value.first.is_a?(Hash) ? value.map {|v| cast_value(v) }  : value
      else
        value
      end
    end
  end
end
