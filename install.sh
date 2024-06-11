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
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    # 方式3
		iex (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1')

    # =====================================
    # Step4: 检查Scoop安装情况
    # =====================================
		scoop help

    # 更换scoop更新镜像
    scoop config SCOOP_REPO "https://gitee.com/glsnames/scoop-installer"

    # 设置代理：可选
    scoop config proxy 127.0.0.1:4412
    # 删除代理
    scoop config rm proxy

    # 拉取新库地址
    scoop update
}

scoop-install-packages() {
    # https://scoop.sh search apps
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
    scooo install curl
    scoop install ag
    scoop install go
    scoop install python
    scoop install ffmpeg
    scoop install nodejs

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

    scoop install snipaste
    scooo install googlechrome
    scooo install firefox
    scooo install vscode
    scooo install everything
    scooo install emacs
    # =====================================
    # Bucket: extras end
    # =====================================

    scoop update
    scoop update

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
