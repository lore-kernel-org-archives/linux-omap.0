From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw: use BIT macro
Date: Fri,  6 Jul 2018 21:44:44 +0300
Message-ID: <20180706184445.29111-2-ivan.khoronzhuk@linaro.org>
References: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

It's needed to avoid checkpatch warnings for farther changes.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 093998124149..f355e65323f3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -253,23 +253,23 @@ struct cpsw_ss_regs {
 #define RX_DSCP_PRI_MAP7    0x4c /* Rx DSCP Priority to Rx Packet Mapping */
 
 /* Bit definitions for the CPSW2_CONTROL register */
-#define PASS_PRI_TAGGED     (1<<24) /* Pass Priority Tagged */
-#define VLAN_LTYPE2_EN      (1<<21) /* VLAN LTYPE 2 enable */
-#define VLAN_LTYPE1_EN      (1<<20) /* VLAN LTYPE 1 enable */
-#define DSCP_PRI_EN         (1<<16) /* DSCP Priority Enable */
-#define TS_320              (1<<14) /* Time Sync Dest Port 320 enable */
-#define TS_319              (1<<13) /* Time Sync Dest Port 319 enable */
-#define TS_132              (1<<12) /* Time Sync Dest IP Addr 132 enable */
-#define TS_131              (1<<11) /* Time Sync Dest IP Addr 131 enable */
-#define TS_130              (1<<10) /* Time Sync Dest IP Addr 130 enable */
-#define TS_129              (1<<9)  /* Time Sync Dest IP Addr 129 enable */
-#define TS_TTL_NONZERO      (1<<8)  /* Time Sync Time To Live Non-zero enable */
-#define TS_ANNEX_F_EN       (1<<6)  /* Time Sync Annex F enable */
-#define TS_ANNEX_D_EN       (1<<4)  /* Time Sync Annex D enable */
-#define TS_LTYPE2_EN        (1<<3)  /* Time Sync LTYPE 2 enable */
-#define TS_LTYPE1_EN        (1<<2)  /* Time Sync LTYPE 1 enable */
-#define TS_TX_EN            (1<<1)  /* Time Sync Transmit Enable */
-#define TS_RX_EN            (1<<0)  /* Time Sync Receive Enable */
+#define PASS_PRI_TAGGED     BIT(24) /* Pass Priority Tagged */
+#define VLAN_LTYPE2_EN      BIT(21) /* VLAN LTYPE 2 enable */
+#define VLAN_LTYPE1_EN      BIT(20) /* VLAN LTYPE 1 enable */
+#define DSCP_PRI_EN         BIT(16) /* DSCP Priority Enable */
+#define TS_320              BIT(14) /* Time Sync Dest Port 320 enable */
+#define TS_319              BIT(13) /* Time Sync Dest Port 319 enable */
+#define TS_132              BIT(12) /* Time Sync Dest IP Addr 132 enable */
+#define TS_131              BIT(11) /* Time Sync Dest IP Addr 131 enable */
+#define TS_130              BIT(10) /* Time Sync Dest IP Addr 130 enable */
+#define TS_129              BIT(9)  /* Time Sync Dest IP Addr 129 enable */
+#define TS_TTL_NONZERO      BIT(8)  /* Time Sync Time To Live Non-zero enable */
+#define TS_ANNEX_F_EN       BIT(6)  /* Time Sync Annex F enable */
+#define TS_ANNEX_D_EN       BIT(4)  /* Time Sync Annex D enable */
+#define TS_LTYPE2_EN        BIT(3)  /* Time Sync LTYPE 2 enable */
+#define TS_LTYPE1_EN        BIT(2)  /* Time Sync LTYPE 1 enable */
+#define TS_TX_EN            BIT(1)  /* Time Sync Transmit Enable */
+#define TS_RX_EN            BIT(0)  /* Time Sync Receive Enable */
 
 #define CTRL_V2_TS_BITS \
 	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
-- 
2.17.1
