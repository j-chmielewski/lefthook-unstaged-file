FROM ubuntu:bionic
RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
    && apt-get clean
RUN : \
    && curl --location --silent --output /tmp/lefthook.deb https://github.com/evilmartians/lefthook/releases/download/v1.7.18/lefthook_1.7.18_amd64.deb \
    && echo '264f8192209025e0f9fff7b528ea8d9a486504fde3cad07b45f607f98033bf9a  /tmp/lefthook.deb' | sha256sum --check \
    && dpkg -i /tmp/lefthook.deb \
    && which lefthook

WORKDIR /src

COPY lefthook.yml ./

ENV \
    GIT_AUTHOR_EMAIL=a@example.com \
    GIT_AUTHOR_NAME='A A' \
    GIT_COMMITTER_EMAIL=a@example.com \
    GIT_COMMITTER_NAME='A A'

RUN : \
    && git init \
    && git add . \
    && : unstaged file, commit should succeed \
    && touch unstaged-file \
    && lefthook install

ENV LEFTHOOK_VERBOSE=false
CMD ["git", "commit", "-m", "test"]
