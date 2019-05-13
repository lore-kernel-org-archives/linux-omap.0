From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: netcp_ethss: fix build
Date: Mon, 13 May 2019 16:16:36 +0300
Message-ID: <1557753396-12367-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix reported build fail:
ERROR: "cpsw_ale_flush_multicast" [drivers/net/ethernet/ti/keystone_netcp_ethss.ko] undefined!
ERROR: "cpsw_ale_create" [drivers/net/ethernet/ti/keystone_netcp_ethss.ko] undefined!
ERROR: "cpsw_ale_add_vlan" [drivers/net/ethernet/ti/keystone_netcp_ethss.ko] undefined!

Fixes: 16f54164828b ("net: ethernet: ti: cpsw: drop CONFIG_TI_CPSW_ALE config option")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index c3f53a40b48f..ed12e1e5df2f 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -19,4 +19,4 @@ ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtoo
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o cpsw_ale.o
 obj-$(CONFIG_TI_KEYSTONE_NETCP_ETHSS) += keystone_netcp_ethss.o
-keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o
+keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o cpsw_ale.o
-- 
2.17.1
