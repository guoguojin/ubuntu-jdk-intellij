FROM birchwoodlangham/ubuntu-jdk:1.8.0_144

# install zsh, python pip etc.
RUN apt-get update && \
    apt-get install -y -qq --fix-missing python-pip python-dev powerline \
    software-properties-common git libxext-dev libxrender-dev libxslt1.1 \
    libxtst-dev libgtk2.0-0 libcanberra-gtk-module libxss1 libxkbfile1 \
    gconf2 gconf-service libnotify4 libnss3 gvfs-bin xdg-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install psutil thefuck sexpdata websocket-client && \
    useradd -d /home/user -m -U user

USER user
WORKDIR /home/user

# Use this one to install the plugins etc.
COPY vimrc_plugins /home/user/.vimrc

# Now for vim plugins, the powerline fonts and nerd fonts required for powerline
RUN git clone https://github.com/powerline/fonts.git && \
    fonts/install.sh && \
    rm -rf fonts && \
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git fonts && \
    cd /home/user/fonts && \
    ./install.sh -q --copy --complete && \
    cd /home/user && \
    rm -rf fonts && \
    mkdir -p /home/user/.vim && \
    git clone https://github.com/VundleVim/Vundle.vim.git /home/user/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall && \
    mkdir idea && \
    wget https://download.jetbrains.com/idea/ideaIU-2017.2.1-no-jdk.tar.gz && \
    tar -C idea -zxf ideaIU-2017.2.1-no-jdk.tar.gz --strip-components=1 && \
    rm ideaIU-2017.2.1-no-jdk.tar.gz

# copy configuration files for vim, zsh and tmux
COPY vimrc /home/user/.vimrc

VOLUME ["/home/user/code", "/home/user/.m2", "/home/user/.ivy2", "/home/user/.IntelliJIdea2017.2"]

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV DERBY_HOME=/usr/lib/jvm/java-8-oracle/db

CMD ["/home/user/idea/bin/idea.sh"]
