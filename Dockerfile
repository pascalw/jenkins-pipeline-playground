FROM ruby:2.4-alpine

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock /tmp/
RUN cd /tmp && bundle install
