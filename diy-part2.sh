#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# https://github.com/yfdoor/OpenWrt/blob/master/.github/workflows/OpenWrt-Build.yml
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

#custom your packages
git clone -b master  https://github.com/vernesong/OpenClash.git package/luci-app-openclash
#svn co --force https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome && svn revert -R package/luci-app-adguardhome

#passwall-package 
#git clone -b packages  https://github.com/xiaorouji/openwrt-passwall.git  package/passwall
#git clone -b main  https://github.com/starambler/openwrt-passwall.git  package/passwall
git clone -b main  https://github.com/xiaorouji/openwrt-passwall2.git  package/passwall

#git clone -b master  https://github.com/fw876/helloworld.git  package/helloworld
#for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do \
 # svn checkout "https://github.com/immortalwrt/packages/trunk/net/$i" "package/helloworld/$i"; \
#done

#add upx
mkdir -p tools/ucl && wget -P tools/ucl https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile 
mkdir -p tools/upx && wget -P tools/upx https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/upx/Makefile
sed -i '23a\tools-y += ucl upx' tools/Makefile
sed -i '/builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile

#update golang
pushd feeds/packages/lang
rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
popd
