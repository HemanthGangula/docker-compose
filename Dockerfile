# Dockerfile for Ruby on Rails application with PostgreSQL DB

# Use the official Ruby base image
FROM ruby:2.7

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory in the container
WORKDIR /app

# Install git
RUN apt-get install -y git

# Clone the GitHub repository
RUN git clone https://github.com/HemanthGangula/Budget-App .

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Set environment variables
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
