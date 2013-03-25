# BBScan

This is a utility demonstrating the use of the ContexIO API to examine
emails in an inbox and parse out friend notifications from a
hypothetical BitBuddy.com coder friends website. Emails of note have a
subject line of `New Friends On BitBiddy.com!` (sic) and are from
`no-reply@bitbuddy.com`. Inside those messages there are HTML-formatted 
sections enumerating the friends that have been added.

This gem installs a command-line tool called `bbparse` that will check
the mailbox and print out a list of friends.

## Installation

Add this line to your application's Gemfile:

    gem 'bbscan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bbscan

## Usage

```bash
$ bbscan
  +---------------+-------------------------------------+
  | name          | profile                             |
  +---------------+-------------------------------------+
  | Terrance Lee  | http://bitbuddy.com/users/hone02    |
  | Josh Williams | http://bitbuddy.com/users/jw        |
  | Ben Hamill    | http://bitbuddy.com/users/benhamill |
  | Brad Fults    | http://bitbuddy.com/users/h3h       |
  +---------------+-------------------------------------+

$
```

## TODO

1. Caching
2. Tests. Tests. More tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
