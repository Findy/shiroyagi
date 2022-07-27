# Shiroyagi

Shiroyagi is a thin Rails plugin which manages Read/Unread status of a Model.

## Usage

Add a column name `read_at` to your model. This column is used by status management.

```
bin/rails g migration AddColumnToYourModels read_at:datetime
```

Include the `Shiroyagi::ActsAsShiroyagi` module in your class.

```ruby
class Message < ApplicationRecord
  include Shiroyagi::ActsAsShiroyagi
end
```

If you want to use a different column, you can specify it with `acts_as_shiroyagi`

```ruby
class Message < ApplicationRecord
  include Shiroyagi::ActsAsShiroyagi

  acts_as_shiroyagi column: 'user_read_at'
end
```

That's it! Then you can use the following methods.

```ruby
# Class methods

Message.reads
=> [#<Message id: 1, read_at: Tue, 28 Nov 2017 07:59:47 UTC +00:00>]

Message.unreads
=> [#<Message id: 2, read_at: nil>]

Message.reads_count
=> 1

Message.unreads_count
=> 1

Message.mark_all_as_read
=> [#<Message id: 2, read_at: Tue, 28 Nov 2017 08:04:44 UTC +00:00>]

Message.mark_all_as_unread
=> [#<Message id: 1, read_at: nil>,
#<Message id: 2, read_at: nil>]


# Instance methods

message.mark_as_read
=> true
message
=> #<Message id: 1, read_at: Tue, 28 Nov 2017 08:10:20 UTC +00:00>
message.read?
=> true
message.unread?
=> false

message.mark_as_unread
=> true
message
=> #<Message id: 1, read_at: nil>
message.read?
=> false
message.unread?
=> true
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shiroyagi'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install shiroyagi
```

## Contributing
Fork this repository and throw your contributing pull requests to this repository.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
