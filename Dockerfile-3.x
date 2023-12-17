FROM debian:12
LABEL author="parse@lf.dev"

# godot version
ARG GODOT_VERSION="3.5.3"

# install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    unzip \
    zip

# make folders
RUN mkdir -p ~/.cache
RUN mkdir -p ~/.config/godot
RUN mkdir -p ~/.local/share/godot/templates

# install godot engine
RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
RUN unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
RUN mv Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot
RUN chmod +x /usr/local/bin/godot
RUN rm Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip

# install export templates
RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz
RUN unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz
RUN mv templates ~/.local/share/godot/templates/${GODOT_VERSION}.stable
RUN rm Godot_v${GODOT_VERSION}-stable_export_templates.tpz
