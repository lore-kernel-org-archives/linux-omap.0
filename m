From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] net: ethernet: ti: cpsw: fix runtime pm while add/del reserved vid
Date: Fri, 10 Aug 2018 15:47:07 +0300
Message-ID: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Here 2 not critical fixes for:
- vlan ale table leak while error if deleting vlan (simplifies next fix)
- runtime pm while try to set reserved vlan

Based on net/master

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw: clear all entries when delete vid
  net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan

 drivers/net/ethernet/ti/cpsw.c     | 25 +++++++++++--------------
 drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
 2 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.17.1
