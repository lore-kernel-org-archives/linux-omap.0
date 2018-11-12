From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 4/4] net: ethernet: ti: cpsw: allow vlan tagged packets to be timestamped
Date: Mon, 12 Nov 2018 16:00:23 +0200
Message-ID: <20181112140023.12407-5-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Allow vlan tagged packets to be timestamped, as no any restrictions
for this.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 48ea21e7e0cb..e4aa030f1726 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -283,7 +283,7 @@ struct cpsw_ss_regs {
 
 #define CTRL_V2_TS_BITS \
 	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
-	 TS_TTL_NONZERO  | TS_ANNEX_D_EN | TS_LTYPE1_EN)
+	 TS_TTL_NONZERO  | TS_ANNEX_D_EN | TS_LTYPE1_EN | VLAN_LTYPE1_EN)
 
 #define CTRL_V2_ALL_TS_MASK (CTRL_V2_TS_BITS | TS_TX_EN | TS_RX_EN)
 #define CTRL_V2_TX_TS_BITS  (CTRL_V2_TS_BITS | TS_TX_EN)
@@ -293,7 +293,7 @@ struct cpsw_ss_regs {
 #define CTRL_V3_TS_BITS \
 	(TS_107 | TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
 	 TS_TTL_NONZERO | TS_ANNEX_F_EN | TS_ANNEX_D_EN |\
-	 TS_LTYPE1_EN)
+	 TS_LTYPE1_EN | VLAN_LTYPE1_EN)
 
 #define CTRL_V3_ALL_TS_MASK (CTRL_V3_TS_BITS | TS_TX_EN | TS_RX_EN)
 #define CTRL_V3_TX_TS_BITS  (CTRL_V3_TS_BITS | TS_TX_EN)
@@ -2235,6 +2235,7 @@ static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
 	slave_write(slave, mtype, CPSW2_TS_SEQ_MTYPE);
 	slave_write(slave, ctrl, CPSW2_CONTROL);
 	writel_relaxed(ETH_P_1588, &cpsw->regs->ts_ltype);
+	writel_relaxed(ETH_P_8021Q, &cpsw->regs->vlan_ltype);
 }
 
 static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
-- 
2.17.1
