FROM buildpack-deps:xenial-curl

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		openjdk-8-jdk \
		git \
		patch \
		python3 \
	&& rm -rf /var/lib/apt/lists/*

# Install Bazel
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && apt-get update \
	&& apt-get -y install bazel \
	&& apt-get clean all \
	&& rm -rf /var/lib/apt/lists/* \
	&& bazel 
	
RUN curl -O https://bootstrap.pypa.io/get-pip.py \
	&& python3 get-pip.py 

ENV PATH $HOME/.local/bin:$PATH

RUN pip3 install --upgrade awscli \
	&& rm get-pip.py

WORKDIR /bazel
EXPOSE 3000
ONBUILD COPY . /bazel
ONBUILD RUN bazel --output_base=.output build --verbose_failures --sandbox_debug //:app
