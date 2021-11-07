.PHONY: default help

default: help
help: ## help: display available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-10s %s\n\033[0m", $$1, $$2}'

# repository information
SRC_NAME    := vimfiles
SRC_WORKDIR := $(shell pwd)
SRC_LOG_FMT := `/bin/date "+%Y-%m-%d %H:%M:%S %z [$(SRC_NAME)]"`

# --------------------------------------------------
# Install Targets
# --------------------------------------------------
clean: ## core: remove vim configurations from home directory
	@echo $(SRC_LOG_FMT) "removing vim configurations from home directory"
	@rm -f $(HOME)/.vimrc >/dev/null 2>&1; true
	@rm -rf $(HOME)/.vim >/dev/null 2>&1; true

install: ## core: install vim configurations into home directory
	@echo $(SRC_LOG_FMT) "installing vim-plug"
	@curl -sfLSo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@echo $(SRC_LOG_FMT) "installing vimrc"
	@cp -af conf/vimrc ~/.vimrc

	@echo $(SRC_LOG_FMT) "installing vim plug-ins"
	@vim +PlugInstall -c q -c q