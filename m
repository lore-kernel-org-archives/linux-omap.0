From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 02/11] net: ethernet: ti: cpsw: use proper io apis
Date: Wed, 22 Nov 2017 15:25:48 -0600
Message-ID: <20171122212557.9998-3-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use writel_relaxed/readl_relaxed() IO API instead of raw version
as it is recommended.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 9235b9e..955ee68 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -365,12 +365,12 @@ struct cpsw_slave {
 
 static inline u32 slave_read(struct cpsw_slave *slave, u32 offset)
 {
-	return __raw_readl(slave->regs + offset);
+	return readl_relaxed(slave->regs + offset);
 }
 
 static inline void slave_write(struct cpsw_slave *slave, u32 val, u32 offset)
 {
-	__raw_writel(val, slave->regs + offset);
+	writel_relaxed(val, slave->regs + offset);
 }
 
 struct cpsw_vector {
@@ -660,8 +660,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
 {
-	__raw_writel(0xFF, &cpsw->wr_regs->tx_en);
-	__raw_writel(0xFF, &cpsw->wr_regs->rx_en);
+	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
+	writel_relaxed(0xFF, &cpsw->wr_regs->rx_en);
 
 	cpdma_ctlr_int_ctrl(cpsw->dma, true);
 	return;
@@ -669,8 +669,8 @@ static void cpsw_intr_enable(struct cpsw_common *cpsw)
 
 static void cpsw_intr_disable(struct cpsw_common *cpsw)
 {
-	__raw_writel(0, &cpsw->wr_regs->tx_en);
-	__raw_writel(0, &cpsw->wr_regs->rx_en);
+	writel_relaxed(0, &cpsw->wr_regs->tx_en);
+	writel_relaxed(0, &cpsw->wr_regs->rx_en);
 
 	cpdma_ctlr_int_ctrl(cpsw->dma, false);
 	return;
@@ -949,12 +949,12 @@ static inline void soft_reset(const char *module, void __iomem *reg)
 {
 	unsigned long timeout = jiffies + HZ;
 
-	__raw_writel(1, reg);
+	writel_relaxed(1, reg);
 	do {
 		cpu_relax();
-	} while ((__raw_readl(reg) & 1) && time_after(timeout, jiffies));
+	} while ((readl_relaxed(reg) & 1) && time_after(timeout, jiffies));
 
-	WARN(__raw_readl(reg) & 1, "failed to soft-reset %s\n", module);
+	WARN(readl_relaxed(reg) & 1, "failed to soft-reset %s\n", module);
 }
 
 #define mac_hi(mac)	(((mac)[0] << 0) | ((mac)[1] << 8) |	\
@@ -1015,7 +1015,7 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 
 	if (mac_control != slave->mac_control) {
 		phy_print_status(phy);
-		__raw_writel(mac_control, &slave->sliver->mac_control);
+		writel_relaxed(mac_control, &slave->sliver->mac_control);
 	}
 
 	slave->mac_control = mac_control;
@@ -1278,7 +1278,7 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	soft_reset_slave(slave);
 
 	/* setup priority mapping */
-	__raw_writel(RX_PRIORITY_MAPPING, &slave->sliver->rx_pri_map);
+	writel_relaxed(RX_PRIORITY_MAPPING, &slave->sliver->rx_pri_map);
 
 	switch (cpsw->version) {
 	case CPSW_VERSION_1:
@@ -1304,7 +1304,7 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	}
 
 	/* setup max packet size, and mac address */
-	__raw_writel(cpsw->rx_packet_max, &slave->sliver->rx_maxlen);
+	writel_relaxed(cpsw->rx_packet_max, &slave->sliver->rx_maxlen);
 	cpsw_set_slave_mac(slave, priv);
 
 	slave->mac_control = 0;	/* no link yet */
@@ -1395,9 +1395,9 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	writel(fifo_mode, &cpsw->host_port_regs->tx_in_ctl);
 
 	/* setup host port priority mapping */
-	__raw_writel(CPDMA_TX_PRIORITY_MAP,
-		     &cpsw->host_port_regs->cpdma_tx_pri_map);
-	__raw_writel(0, &cpsw->host_port_regs->cpdma_rx_chan_map);
+	writel_relaxed(CPDMA_TX_PRIORITY_MAP,
+		       &cpsw->host_port_regs->cpdma_tx_pri_map);
+	writel_relaxed(0, &cpsw->host_port_regs->cpdma_rx_chan_map);
 
 	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
 			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
@@ -1514,10 +1514,10 @@ static int cpsw_ndo_open(struct net_device *ndev)
 	/* initialize shared resources for every ndev */
 	if (!cpsw->usage_count) {
 		/* disable priority elevation */
-		__raw_writel(0, &cpsw->regs->ptype);
+		writel_relaxed(0, &cpsw->regs->ptype);
 
 		/* enable statistics collection only on all ports */
-		__raw_writel(0x7, &cpsw->regs->stat_port_en);
+		writel_relaxed(0x7, &cpsw->regs->stat_port_en);
 
 		/* Enable internal fifo flow control */
 		writel(0x7, &cpsw->regs->flow_control);
@@ -1703,7 +1703,7 @@ static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
 
 	slave_write(slave, mtype, CPSW2_TS_SEQ_MTYPE);
 	slave_write(slave, ctrl, CPSW2_CONTROL);
-	__raw_writel(ETH_P_1588, &cpsw->regs->ts_ltype);
+	writel_relaxed(ETH_P_1588, &cpsw->regs->ts_ltype);
 }
 
 static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
-- 
2.10.5
