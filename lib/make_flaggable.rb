require 'make_flaggable/flagging'
require 'make_flaggable/flaggable'
require 'make_flaggable/flagger'
require 'make_flaggable/exceptions'

module MakeFlaggable
  def flaggable?
    false
  end

  def flagger?
    false
  end

  # Specify a model as flaggable.
  # Required options flag names to allow flagging of with those flag types
  #
  # Example:
  # class Article < ActiveRecord::Base
  #   make_flaggable :inappropriate, :spam, :favorite
  # end
  def make_flaggable(*flags)
    raise MakeFlaggable::Exceptions::MissingFlagsError.new if flags.empty?
    define_method(:available_flags) { flags.map(&:to_sym) }
    include Flaggable
  end

  # Specify a model as flagger.
  #
  # Example:
  # class User < ActiveRecord::Base
  #   make_flagger
  # end
  def make_flagger
    include Flagger
  end
end

ActiveRecord::Base.extend MakeFlaggable
