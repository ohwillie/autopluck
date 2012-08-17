# Autopluck

An extension to ActiveRecord::Relation that converts calls of the form

relation.map(&:id)

into

relation.pluck('id')

...automatically! It's kinda scary.

## Installation

Add this line to your application's Gemfile:

    gem 'autopluck'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autopluck

## Usage

To activate, call

Autopluck.activate!

to soft-deactivate, call

Autopluck.activate!

Everything else will be handled for you.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
