# Snap::Ci::Artefact::Grabber

A simple gem that lets you get artefacts of [Snap CI](https://snap-ci.com). It handles most circumstances. PR's welcome to let it handle more exotic scenarios.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snap-ci-artefact-grabber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snap-ci-artefact-grabber

## Usage

Two environment variables, `SNAP_USER` and `SNAP_APIKEY` store the credentials. Set these before you use this library.

Here is an example:

```shell
SNAP_USER=distributedlife SNAP_APIKEY=derpderp bundle exec dashing start
```

Using the gem:

An `ArtefactGrabber` requires four parameters: the `owner`, the `repo`, the `branch` and the pipeline name. This is usually `defaultPipeline`.

To get an artefact supply the `stage` and the `filename` that you have  told [Snap CI](https://snap-ci.com) to archive.

All values are case sensitive.

```ruby
snap = SnapCI::ArtefactGrabber.new(
  "distributedlife",
  "snap-ci-artefact-grabber",
  "master",
  "defaultPipeline"
)

file_contents = snap.get_artefact_url_for_stage(
  "build",
  "coverage/coverage-summary.json"
)

json = JSON.parse(file_contents)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/snap-ci-artefact-grabber/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
