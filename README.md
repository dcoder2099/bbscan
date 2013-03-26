# BBScan

This is a utility demonstrating the use of the ContexIO API to examine
emails in an inbox and parse out friend notifications from a
hypothetical BitBuddy.com coder friends website. Emails of note have a
subject line of `New Friends On BitBiddy.com!` (sic).

Inside those messages there are HTML-formatted sections enumerating the 
friends that have been added.

This gem installs a command-line tool called `bbscan` that will check
the mailbox and print out a list of friends.

## Installation

Add this line to your application's Gemfile:

    gem 'bbscan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bbscan

## Usage

Before you begin, you need to create add the following variables to 
your environment: `CIO_KEY`, `CIO_SECRETE`, `BBS_MAIL`. The first two
are self-explanatory; the third is the email address that BitBuddy.com
is delivering the friend notifications to.

The easiest way to do this is to add a `.env` file to your 
project/home directory with the following:

```bash
CIO_KEY=<YOUR_CONTEXTIO_KEY>
CIO_SECRET=<YOUR_CONTEXTIO_SECRET>
BBS_MAIL=<YOUR_EMAIL_ACCT>
```

Then you can use the `bbscan` command like so:

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

The application will cache results between runs so that you don't keep
seeing the same friends in the list over and over. If you want to bust
the cache, delete the file `~/.bbscan_cache`.

## TODO

1. Tests. Tests. More tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
