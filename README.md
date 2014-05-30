A rigid, readable alternative for defining AR scopes.

## Installation

`gem install scoped`

## Usage

```ruby
require 'scoped'
```

Then in your `ActiveRecord` models:

```ruby
class Meme < ActiveRecord::Base
  include Scoped

  scopes do
    sad_keanu { where(name: 'Keanu Reaves') }
  end
end
```

```ruby
Meme.sad_keanu #=> an ActiveRecord::Relation of Memes!
```

## Requirements

Requires ActiveRecord >= 3.1.0, <= 4.1.0, tested with Ruby 1.9.3, 2.0.0, and 2.1.0.

## Running Tests

`bundle exec rspec`

## Authors

* Evan Sherwood: http://github.com/neezer
