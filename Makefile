.DEFAULT_GOAL := help

.PHONY: help all link defaults brew config-check build-apps

help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: link defaults brew build-apps ## 全てのセットアップ（リンク、システム設定、Brew、アプリビルド）を実行

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

build-apps: ## apps/ 配下のSwiftアプリをビルドしてインストール
	@echo "\033[0;34mBuild OpenInWezTerm.app\033[0m"
	@mkdir -p ~/Applications/OpenInWezTerm.app/Contents/MacOS
	@cp apps/OpenInWezTerm/Info.plist ~/Applications/OpenInWezTerm.app/Contents/Info.plist
	@swiftc -o ~/Applications/OpenInWezTerm.app/Contents/MacOS/OpenInWezTerm apps/OpenInWezTerm/OpenInWezTerm.swift -framework Cocoa
	@echo "\033[0;32mDone.\033[0m"

config-check: ## configs/ の中身を確認
	@ls -R configs/