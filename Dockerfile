FROM ruby:3.2 

LABEL Name=giabbiswriteups 
EXPOSE 4000

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . /app

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]