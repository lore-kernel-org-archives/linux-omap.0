From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 19/20] net: ethernet: ti: cpsw: switch to use mac sl api
Date: Fri, 26 Apr 2019 20:12:41 +0300
Message-ID: <1556298762-8632-20-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch CPSW driver to use the new MAC SL API.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Makefile    |  2 +-
 drivers/net/ethernet/ti/cpsw.c      | 54 +++++++++++++++--------------
 drivers/net/ethernet/ti/cpsw_priv.c |  5 ++-
 drivers/net/ethernet/ti/cpsw_priv.h | 15 +-------
 4 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index de1561596646..0a75c1957626 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
-ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o
+ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o cpsw_ale.o
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4219b13e6a8e..4449f2eeac09 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -38,6 +38,7 @@
 #include "cpsw.h"
 #include "cpsw_ale.h"
 #include "cpsw_priv.h"
+#include "cpsw_sl.h"
 #include "cpts.h"
 #include "davinci_cpdma.h"
 
@@ -826,29 +827,32 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 	slave_port = cpsw_get_slave_port(slave->slave_num);
 
 	if (phy->link) {
-		mac_control = cpsw->data.mac_control;
-
-		/* enable forwarding */
-		cpsw_ale_control_set(cpsw->ale, slave_port,
-				     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
+		mac_control = CPSW_SL_CTL_GMII_EN;
 
 		if (phy->speed == 1000)
-			mac_control |= BIT(7);	/* GIGABITEN	*/
+			mac_control |= CPSW_SL_CTL_GIG;
 		if (phy->duplex)
-			mac_control |= BIT(0);	/* FULLDUPLEXEN	*/
+			mac_control |= CPSW_SL_CTL_FULLDUPLEX;
 
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
-			mac_control |= BIT(15);
+			mac_control |= CPSW_SL_CTL_IFCTL_A;
 		/* in band mode only works in 10Mbps RGMII mode */
 		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
-			mac_control |= BIT(18); /* In Band mode */
+			mac_control |= CPSW_SL_CTL_EXT_EN; /* In Band mode */
 
 		if (priv->rx_pause)
-			mac_control |= BIT(3);
+			mac_control |= CPSW_SL_CTL_RX_FLOW_EN;
 
 		if (priv->tx_pause)
-			mac_control |= BIT(4);
+			mac_control |= CPSW_SL_CTL_TX_FLOW_EN;
+
+		if (mac_control != slave->mac_control)
+			cpsw_sl_ctl_set(slave->mac_sl, mac_control);
+
+		/* enable forwarding */
+		cpsw_ale_control_set(cpsw->ale, slave_port,
+				     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
 
 		*link = true;
 
@@ -862,12 +866,14 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 		/* disable forwarding */
 		cpsw_ale_control_set(cpsw->ale, slave_port,
 				     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
+
+		cpsw_sl_wait_for_idle(slave->mac_sl, 100);
+
+		cpsw_sl_ctl_reset(slave->mac_sl);
 	}
 
-	if (mac_control != slave->mac_control) {
+	if (mac_control != slave->mac_control)
 		phy_print_status(phy);
-		writel_relaxed(mac_control, &slave->sliver->mac_control);
-	}
 
 	slave->mac_control = mac_control;
 }
@@ -1103,24 +1109,18 @@ static inline void cpsw_add_dual_emac_def_ale_entries(
 			     ALE_PORT_DROP_UNKNOWN_VLAN, 1);
 }
 
-static void soft_reset_slave(struct cpsw_slave *slave)
-{
-	char name[32];
-
-	snprintf(name, sizeof(name), "slave-%d", slave->slave_num);
-	soft_reset(name, &slave->sliver->soft_reset);
-}
-
 static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 {
 	u32 slave_port;
 	struct phy_device *phy;
 	struct cpsw_common *cpsw = priv->cpsw;
 
-	soft_reset_slave(slave);
+	cpsw_sl_reset(slave->mac_sl, 100);
+	cpsw_sl_ctl_reset(slave->mac_sl);
 
 	/* setup priority mapping */
-	writel_relaxed(RX_PRIORITY_MAPPING, &slave->sliver->rx_pri_map);
+	cpsw_sl_reg_write(slave->mac_sl, CPSW_SL_RX_PRI_MAP,
+			  RX_PRIORITY_MAPPING);
 
 	switch (cpsw->version) {
 	case CPSW_VERSION_1:
@@ -1146,7 +1146,8 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	}
 
 	/* setup max packet size, and mac address */
-	writel_relaxed(cpsw->rx_packet_max, &slave->sliver->rx_maxlen);
+	cpsw_sl_reg_write(slave->mac_sl, CPSW_SL_RX_MAXLEN,
+			  cpsw->rx_packet_max);
 	cpsw_set_slave_mac(slave, priv);
 
 	slave->mac_control = 0;	/* no link yet */
@@ -1309,7 +1310,8 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
 	slave->phy = NULL;
 	cpsw_ale_control_set(cpsw->ale, slave_port,
 			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
-	soft_reset_slave(slave);
+	cpsw_sl_reset(slave->mac_sl, 100);
+	cpsw_sl_ctl_reset(slave->mac_sl);
 }
 
 static int cpsw_tc_to_fifo(int tc, int num_tc)
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index d4d1e0b397bc..476d050a022c 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -16,6 +16,7 @@
 #include "cpts.h"
 #include "cpsw_ale.h"
 #include "cpsw_priv.h"
+#include "cpsw_sl.h"
 #include "davinci_cpdma.h"
 
 int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
@@ -78,8 +79,10 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 		slave->slave_num = i;
 		slave->data	= &cpsw->data.slave_data[i];
 		slave->regs	= regs + slave_offset;
-		slave->sliver	= regs + sliver_offset;
 		slave->port_vlan = slave->data->dual_emac_res_vlan;
+		slave->mac_sl = cpsw_sl_get("cpsw", dev, regs + sliver_offset);
+		if (IS_ERR(slave->mac_sl))
+			return PTR_ERR(slave->mac_sl);
 
 		slave_offset  += slave_size;
 		sliver_offset += SLIVER_SIZE;
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 53bd6e020f94..fc1a8dee391e 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -269,19 +269,6 @@ struct cpsw_host_regs {
 	u32	cpdma_rx_chan_map;
 };
 
-struct cpsw_sliver_regs {
-	u32	id_ver;
-	u32	mac_control;
-	u32	mac_status;
-	u32	soft_reset;
-	u32	rx_maxlen;
-	u32	__reserved_0;
-	u32	rx_pause;
-	u32	tx_pause;
-	u32	__reserved_1;
-	u32	rx_pri_map;
-};
-
 struct cpsw_hw_stats {
 	u32	rxgoodframes;
 	u32	rxbroadcastframes;
@@ -344,13 +331,13 @@ struct cpsw_platform_data {
 
 struct cpsw_slave {
 	void __iomem			*regs;
-	struct cpsw_sliver_regs __iomem	*sliver;
 	int				slave_num;
 	u32				mac_control;
 	struct cpsw_slave_data		*data;
 	struct phy_device		*phy;
 	struct net_device		*ndev;
 	u32				port_vlan;
+	struct cpsw_sl			*mac_sl;
 };
 
 static inline u32 slave_read(struct cpsw_slave *slave, u32 offset)
-- 
2.17.1
