.DEFAULT_GOAL := help

.PHONY: help all link defaults brew config-check

help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: link defaults brew ## 全てのセットアップ（リンク、システム設定、Brew）を実行

link: ## links/ 配下のシンボリックリンクを作成
	@echo "\033[0;34mRun links.sh\033[0m"
	@bash .bin/link.sh
	@echo "\033[0;32mDone.\033[0m"

defaults: ## macOSのシステム設定を反映
	@echo "\033[0;34mRun defaults.sh\033[0m"
	@bash .bin/defaults.sh
	@echo "\033[0;32mDone.\033[0m"

brew: ## Brewfileに基づいたインストールを実行
	@echo "\033[0;34mRun brew.sh\033[0m"
	@bash .bin/brew.sh
	@echo "\033[0;32mDone.\033[0m"

config-check: ## configs/ の中身を確認
	@ls -R configs/