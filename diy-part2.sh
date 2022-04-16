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

#openclash packages
git clone -b master  https://github.com/vernesong/OpenClash.git package/luci-app-openclash

#passwall package 
git clone  https://github.com/xiaorouji/openwrt-passwall.git  package/passwall
git clone -b luci  https://github.com/xiaorouji/openwrt-passwall.git  package/luci-app-passwall
git clone  https://github.com/xiaorouji/openwrt-passwall2.git   package/luci-app-passwall2

#helloworld package
git clone -b master  https://github.com/fw876/helloworld.git  package/helloworld
#for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt"  "redsocks2"; do \
#  svn checkout "https://github.com/immortalwrt/packages/trunk/net/$i" "package/helloworld/$i"; \
#done
svn checkout https://github.com/immortalwrt/packages/trunk/net/redsocks2    package/helloworld/redsocks2

#CDN speedtest
git clone https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git package/luci-app-cloudflarespeedtest
git clone https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git package/cdnspeedtest

#update golang
pushd feeds/packages/lang
rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
popd
