
.PHONY: setup
setup:
	@sudo apt update -qq
	@sudo apt install --no-install-recommends -qq -y build-essential devscripts
