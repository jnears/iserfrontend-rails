# ISER Frontend for Rails apps

This gem provides standard frontend CSS and JavaScript code for ISER Rails 4 applications.

**This is currently very much work in progress and not ready for production use.**

## Installation

Add this line to your application's Gemfile:

    gem 'iserfrontend-rails', github: 'paulgroves/iserfrontend-rails'

And then execute:

    $ bundle

## Usage

Simply require iserwww from your JavaScript and CSS application manifests.

In file `/app/assets/javascripts/application.js`, add the line:

      //= require iserwww

In file `/app/assets/stylesheets/application.css`, add the line:

      *= require iserwww

## Styleguide

The styleguide will be available to your app at the URL

      /styleguide

This provides documentation and examples of available styles and features.

## Requirements

Rails ~4.0.0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
