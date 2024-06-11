install-scoop() {
    # 国内项目地址：https://gitee.com/glsnames/scoop-installepowershell 执行脚本：
    # Powershell

    # =====================================
    # Step1: 安装环境配置
    # =====================================
    # 设置允许远程执行脚本
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    # 设置软件安装的位置
    $env:SCOOP='D:\Scoop'
    [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'USER')

    # =====================================
    # Step2: 编辑Hosts文件并更新缓存
    # =====================================
    # NOTE: https://github.com/521xueweihan/GitHub520
    notepad C:\Windows\System32\drivers\etc\hosts
    ipconfig /flushdns

    # =====================================
    # Step3: 安装Scoop
    # =====================================
    # 方式1
    iwr --useb scoop.201704.xyz | iex
    # 方式2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    # 方式3
		iex (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1')

    # =====================================
    # Step4: 检查Scoop安装情况
    # =====================================
		scoop help

    # =====================================
    # 国内镜像加速方案
    # =====================================
    scoop bucket add main https://codechina.csdn.net/mirrors/ScoopInstaller/Main.git
    scoop bucket add extras https://codechina.csdn.net/mirrors/lukesampson/scoop-extras.git
    scoop bucket add nonportable https://codechina.csdn.net/mirrors/TheRandomLabs/scoop-nonportable
    scoop bucket add nirsoft https://codechina.csdn.net/mirrors/kodybrown/scoop-nirsoft.git
    scoop bucket add nerd-fonts https://codechina.csdn.net/mirrors/matthewjberger/scoop-nerd-fonts.git
    scoop bucket add java https://codechina.csdn.net/mirrors/ScoopInstaller/Java.git
    scoop bucket add versions https://codechina.csdn.net/mirrors/ScoopInstaller/Versions.git
    scoop update

    # 更换scoop更新镜像
    scoop config SCOOP_REPO "https://gitee.com/glsnames/scoop-installer"

    # 设置代理：可选
    scoop config proxy 127.0.0.1:4412
    # 删除代理
    scoop config rm proxy

    # 拉取新库地址
    scoop update

    # NOTE: 卸载 scoop
    scoop uninstall scoop
}

scoop-install-packages() {
    # search apps
    # NOTE: http://scoop.sh search apps
    # https://github.com/rasa/scoop-directory | https://rasa.github.io/scoop-directory/search

    # 查看代理IP地址
    curl -x socks5h://192.168.123.88:7890 -x GET cip.cc

    # 查询所有在线可用的Bucket
    scoop bucket known

    # =====================================
    # Bucket: extras main
    # =====================================
    # 查看已安装的软件列表
    scoop list

    scoop install git # 包含7Zip
    scoop install aria2 # 多线程下载
    # NOTE: 配置是否使用aria2下载，false为禁用，true为启用
    scoop config aria2-enabled true
    scoop install main/neovim
    scoop install main/typst
    scoop install main/lua
    scoop install main/lua-language-server
    scoop install main/stylua
    scoop install main/luajit
    scooo install curl
    scoop install ag
    scoop install main/go
    scoop install python
    scoop install main/ruff
    scoop install main/pipx
    scoop install main/rye
    scoop install extras/spyder
    scoop install ffmpeg
    scoop install main/nodejs
    scoop install main/rust
    scoop install main/rustup
    scoop install main/rust-analyzer
    scoop install main/just
    scoop install main/neofetch
    scoop install main/shfmt

    scoop list

    # =====================================
    # Bucket: main end
    # =====================================

		# =====================================
		#  Bucket: extras start
		# =====================================
    # 查看当前bucket列表
    scoop bucket list
    # 添加bucket仓库
    scoop bucket add extras
    # 删除bucket仓库
    scoop bucket rm extras

    scoop install extras/psreadline
    scoop install extras/wechat
    scoop install extras/qq
    scoop install extras/scoop-completion
    scoop install extras/posh-git
    scoop install snipaste
    scooo install googlechrome
    scooo install firefox
    scoop install extras/vscode
    scooo install everything
    scooo install emacs
    # NOTE: 安装指定版本的软件
    scooo install freedownloadmanager@6.18.0
    # =====================================
    # Bucket: extras end
    # =====================================

    # =====================================
    # Bucket: versions start
    # =====================================
    scoop bucket add versions

    scoop install versions/python312
    scoop install versions/neovim-nightly
    scoop install versions/lua53
    scoop install versions/rust-nightly
    # =====================================
    # Bucket: versions end
    # =====================================

		# =====================================
		#  Bucket: nerd-fonts start
		# =====================================
    scoop bucket add nerd-fonts

    scoop install nerd-fonts/JetBrainsMono-NF
		# =====================================
		#  Bucket: nerd-fonts end
		# =====================================

    # 添加第三方bucket仓库
    # scoop bucket add 别名 git地址
    scoop bucket add scoopcn https://github.com/scoopcn/scoopcn.git

    scoop install screentogif
    scoop install scrcpy
    scoop install netease-music
}

scoop-uninstall-packages() {
    scoop rm scrcpy  # 控制手机屏幕软件

}

#  NOTE: Main Functions
function main() {
    install-scoop
    scoop-install-packages
    scoop-uninstall-packages
}

main
