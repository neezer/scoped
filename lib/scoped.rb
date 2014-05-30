require 'active_record'

module Scoped
  autoload :ScopeCollection, 'scoped/scope_collection'

  extend ActiveSupport::Concern

  module ClassMethods
    def scopes(&block)
      ScopeCollection.new(&block).all.each do |name, source|
        scope(name, eval(source))
      end
    end
  end
end
