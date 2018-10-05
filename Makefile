all:
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/.zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/.tmux.conf ~/.tmux.conf
	# [ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	# [ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/vimrc ~/.config/nvim/init.vim
	
	brew bundle

clean:
	rm -f ~/.vimrc 
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.gitconfig
	# rm -f ~/.tigrc
	# rm -f ~/.config/nvim/init.vim

.PHONY: all
