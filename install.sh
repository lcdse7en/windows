install-scoop() {
    # 国内项目地址：https://gitee.com/glsnames/scoop-installepowershell 执行脚本：
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser

    # 设置软件安装的位置
    $env:SCOOP='D:\workspaces\Scoop'
    [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'USER')

    # 执行安装命令
    iwr --useb scoop.201704.xyz | iex

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
    # scoop.sh search apps
    scoop install git aria2

    # 查询内置的Bucket仓库
    scoop bucket known

    # 添加bucket仓库
    scoop bucket add nirsoft

    scoop update

    # 添加第三方bucket仓库
    # scoop bucket add 别名 git地址
    scoop bucket add scoopcn https://github.com/scoopcn/scoopcn.git

    scoop install snipaste
    scoop install screentogif
    scoop install scrcpy
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
