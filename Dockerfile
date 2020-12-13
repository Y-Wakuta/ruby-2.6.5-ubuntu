FROM ubuntu:16.04
MAINTAINER Y-Wakuta

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git vim
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
WORKDIR /root/.rbenv
RUN git pull

RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
WORKDIR /root/.rbenv/plugins/ruby-build
RUN git pull

RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile

# Install multiple versions of ruby
ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /root/.rbenv/shims:$PATH
RUN xargs -L 1 rbenv install 2.6.5
RUN rbenv global 2.6.5
RUN gem install bundler
