FROM ruby:2.5-alpine

ENV REPO_URL=https://github.com/bosr/slate
ENV SLATE_VERSION=docker

RUN apk add --no-cache coreutils git make g++ nodejs

RUN git clone --branch $SLATE_VERSION --single-branch --depth 1 \
  ${REPO_URL} /slate

WORKDIR /slate

COPY ./source/stylesheets/ ./source/javascripts/ ./source/fonts/ ./source/images/ /template/
COPY ./build.sh /slate

RUN bundle install --verbose && rm -rf .git

CMD ["/slate/build.sh"]
