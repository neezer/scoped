module Scoped
  class ScopeCollection
    def initialize(&block)
      @scopes = {}
      instance_eval &block
    end

    def all
      @scopes
    end

    def method_missing(name, *args, &block)
      return super unless block_given?

      arg_list, block_contents = parse(block.source.split("\n"))

      @scopes[name] = <<-RUBY
        lambda do #{"|#{arg_list}|" if arg_list}
          #{block_contents.join("\n")}
        end
      RUBY
    end

    private

    def parse(block_source)
      if block_source.size > 1
        parse_multiline(block_source)
      else
        parse_single_line(block_source.first)
      end
    end

    def parse_single_line(block_source)
      block_source.strip.match(%r(^.+\{\s*(\|.*\|)?(.+?)\}.*$)).tap do |matchdata|
        arg_list = (matchdata.captures[0] || '')[1..-2]
        block_contents = matchdata.captures[1].strip
        break [arg_list, [block_contents]]
      end
    end

    def parse_multiline(block_source)
      arg_list = block_source[0].match(%r(\|(.+?)\|)).tap do |match|
        break (match && match.captures.any?) ? match.captures.first : nil
      end
      block_contents = block_source[1..-2]
      [arg_list, block_contents]
    end
  end
end
