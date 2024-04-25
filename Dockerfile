# Use an image with Ruby and Node.js installed
FROM ruby:3.1.2

# Set the working directory inside the container
WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && \
    apt-get install -y git \
                       nodejs \
                       yarn \
                       postgresql-client

# Install Bundler gem
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install project dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]