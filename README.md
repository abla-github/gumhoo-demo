[![Circle CI](https://circleci.com/gh/abla-github/gumhoo-demo.svg?style=shield)](https://circleci.com/gh/abla-github/gumhoo-demo)

# Gumhoo Demo

> This application is only for demonstration purpose

## Prerequisite

- ruby  2.3.0
- rails 4.2.2
- PostgreSQL
 
## Getting Started

1. To get the source code from GitHub.
```
$ git clone git@github.com:abla-github/gumhoo-demo.git
```
2. Using Bundler to install the gems needed by the app.
```
$ bundle install
```
3. Migrating the database & initializing with the seed data.
```
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```
4. Running the Rails server on a local machine.
```
$ rails server
```
5. Browse to [http://localhost:3000](http://localhost:3000).

## How to run the test suite
```
$ bundle exec rake test
```

## Heroku app [Open](https://gumhoo-seyjhflo.herokuapp.com/)
