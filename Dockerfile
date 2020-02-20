FROM ruby:2.2.2

WORKDIR /app
VOLUME /app/bin

RUN gem install bundler --version 1.11.2
RUN gem install rb2exe

ADD . /app

RUN bundle install

RUN rb2exe kuberails.rb --add=. --output=./bin/linux/kuberails-l64 --target=l64
RUN rb2exe kuberails.rb --add=. --output=./bin/osx/kuberails-osx --target=osx

CMD ./kuberails-l64