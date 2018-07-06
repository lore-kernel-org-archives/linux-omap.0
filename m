From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: allow PTP 224.0.0.107 to be timestamped
Date: Fri,  6 Jul 2018 21:44:45 +0300
Message-ID: <20180706184445.29111-3-ivan.khoronzhuk@linaro.org>
References: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Tested on AM572x with cpsw v1.15 for PTP sync and delay_req messages.
It doesn't work on cpsw v1.12, so added only for cpsw v > 1.15.

Command for testing:
ptp4l -P -4 -H -i eth0 -l 6 -m -q -p /dev/ptp0 -f ptp.cfg
where ptp.cfg:

[global]
tx_timestamp_timeout     20

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f355e65323f3..00761fe59848 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -257,6 +257,7 @@ struct cpsw_ss_regs {
 #define VLAN_LTYPE2_EN      BIT(21) /* VLAN LTYPE 2 enable */
 #define VLAN_LTYPE1_EN      BIT(20) /* VLAN LTYPE 1 enable */
 #define DSCP_PRI_EN         BIT(16) /* DSCP Priority Enable */
+#define TS_107              BIT(15) /* Tyme Sync Dest IP Address 107 */
 #define TS_320              BIT(14) /* Time Sync Dest Port 320 enable */
 #define TS_319              BIT(13) /* Time Sync Dest Port 319 enable */
 #define TS_132              BIT(12) /* Time Sync Dest IP Addr 132 enable */
@@ -281,7 +282,7 @@ struct cpsw_ss_regs {
 
 
 #define CTRL_V3_TS_BITS \
-	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
+	(TS_107 | TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
 	 TS_TTL_NONZERO | TS_ANNEX_F_EN | TS_ANNEX_D_EN |\
 	 TS_LTYPE1_EN)
 
-- 
2.17.1
