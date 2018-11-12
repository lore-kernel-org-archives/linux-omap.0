From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 3/4] net: ethernet: ti: cpts: move enable/disable flags outside of cpts module
Date: Mon, 12 Nov 2018 16:00:22 +0200
Message-ID: <20181112140023.12407-4-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Each slave has it's own receive timestamp filter. But cpts rx/tx
timestamp enable flags are used to allow ts retrieve only for one
user. This limitation causes data path redundancy and setting overlap
if cpsw module is in dual-mac mode for instance.

If rx ts is enabled only for one port - the second interface must expect
every incoming packet to be PTP packet w/o absolutely any reason, and if
it's PTP - do unneeded stuff, as rx filter for second port is not set
and cpts fifo is not supposed to contain appropriate ts event.
That's not correct.

So, to fix control overlap and avoid redundant CPU cycles, the patch
splits rx/tx ts enable flags between network devices. After the patch,
PTP timestamping still should be used for only one port (or PTP id
counter has to be different for both ports as cpts IP is common).

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c        | 46 ++++++++++++++-------------
 drivers/net/ethernet/ti/cpts.c        |  2 --
 drivers/net/ethernet/ti/cpts.h        | 38 ----------------------
 drivers/net/ethernet/ti/netcp_ethss.c | 32 ++++++++++---------
 4 files changed, 41 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 9434fd5a5477..48ea21e7e0cb 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -466,6 +466,8 @@ struct cpsw_priv {
 	bool				mqprio_hw;
 	int				fifo_bw[CPSW_TC_NUM];
 	int				shp_cfg_speed;
+	int				tx_ts_enabled;
+	int				rx_ts_enabled;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
 };
@@ -905,6 +907,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	struct net_device	*ndev = skb->dev;
 	int			ret = 0, port;
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_priv	*priv;
 
 	if (cpsw->data.dual_emac) {
 		port = CPDMA_RX_SOURCE_PORT(status);
@@ -939,7 +942,9 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		skb_put(skb, len);
 		if (status & CPDMA_RX_VLAN_ENCAP)
 			cpsw_rx_vlan_encap(skb);
-		cpts_rx_timestamp(cpsw->cpts, skb);
+		priv = netdev_priv(ndev);
+		if (priv->rx_ts_enabled)
+			cpts_rx_timestamp(cpsw->cpts, skb);
 		skb->protocol = eth_type_trans(skb, ndev);
 		netif_receive_skb(skb);
 		ndev->stats.rx_bytes += len;
@@ -2126,7 +2131,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	}
 
 	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
-	    cpts_is_tx_enabled(cpts) && cpts_can_timestamp(cpts, skb))
+	    priv->tx_ts_enabled && cpts_can_timestamp(cpts, skb))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	q_idx = skb_get_queue_mapping(skb);
@@ -2170,13 +2175,13 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 
 #if IS_ENABLED(CONFIG_TI_CPTS)
 
-static void cpsw_hwtstamp_v1(struct cpsw_common *cpsw)
+static void cpsw_hwtstamp_v1(struct cpsw_priv *priv)
 {
+	struct cpsw_common *cpsw = priv->cpsw;
 	struct cpsw_slave *slave = &cpsw->slaves[cpsw->data.active_slave];
 	u32 ts_en, seq_id;
 
-	if (!cpts_is_tx_enabled(cpsw->cpts) &&
-	    !cpts_is_rx_enabled(cpsw->cpts)) {
+	if (!priv->tx_ts_enabled && !priv->rx_ts_enabled) {
 		slave_write(slave, 0, CPSW1_TS_CTL);
 		return;
 	}
@@ -2184,10 +2189,10 @@ static void cpsw_hwtstamp_v1(struct cpsw_common *cpsw)
 	seq_id = (30 << CPSW_V1_SEQ_ID_OFS_SHIFT) | ETH_P_1588;
 	ts_en = EVENT_MSG_BITS << CPSW_V1_MSG_TYPE_OFS;
 
-	if (cpts_is_tx_enabled(cpsw->cpts))
+	if (priv->tx_ts_enabled)
 		ts_en |= CPSW_V1_TS_TX_EN;
 
-	if (cpts_is_rx_enabled(cpsw->cpts))
+	if (priv->rx_ts_enabled)
 		ts_en |= CPSW_V1_TS_RX_EN;
 
 	slave_write(slave, ts_en, CPSW1_TS_CTL);
@@ -2207,20 +2212,20 @@ static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
 	case CPSW_VERSION_2:
 		ctrl &= ~CTRL_V2_ALL_TS_MASK;
 
-		if (cpts_is_tx_enabled(cpsw->cpts))
+		if (priv->tx_ts_enabled)
 			ctrl |= CTRL_V2_TX_TS_BITS;
 
-		if (cpts_is_rx_enabled(cpsw->cpts))
+		if (priv->rx_ts_enabled)
 			ctrl |= CTRL_V2_RX_TS_BITS;
 		break;
 	case CPSW_VERSION_3:
 	default:
 		ctrl &= ~CTRL_V3_ALL_TS_MASK;
 
-		if (cpts_is_tx_enabled(cpsw->cpts))
+		if (priv->tx_ts_enabled)
 			ctrl |= CTRL_V3_TX_TS_BITS;
 
-		if (cpts_is_rx_enabled(cpsw->cpts))
+		if (priv->rx_ts_enabled)
 			ctrl |= CTRL_V3_RX_TS_BITS;
 		break;
 	}
@@ -2237,7 +2242,6 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	struct cpsw_priv *priv = netdev_priv(dev);
 	struct hwtstamp_config cfg;
 	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpts *cpts = cpsw->cpts;
 
 	if (cpsw->version != CPSW_VERSION_1 &&
 	    cpsw->version != CPSW_VERSION_2 &&
@@ -2256,7 +2260,7 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		cpts_rx_enable(cpts, 0);
+		priv->rx_ts_enabled = 0;
 		break;
 	case HWTSTAMP_FILTER_ALL:
 	case HWTSTAMP_FILTER_NTP_ALL:
@@ -2264,7 +2268,7 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		cpts_rx_enable(cpts, HWTSTAMP_FILTER_PTP_V1_L4_EVENT);
+		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -2276,18 +2280,18 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		cpts_rx_enable(cpts, HWTSTAMP_FILTER_PTP_V2_EVENT);
+		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	cpts_tx_enable(cpts, cfg.tx_type == HWTSTAMP_TX_ON);
+	priv->tx_ts_enabled = cfg.tx_type == HWTSTAMP_TX_ON;
 
 	switch (cpsw->version) {
 	case CPSW_VERSION_1:
-		cpsw_hwtstamp_v1(cpsw);
+		cpsw_hwtstamp_v1(priv);
 		break;
 	case CPSW_VERSION_2:
 	case CPSW_VERSION_3:
@@ -2303,7 +2307,7 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(dev);
-	struct cpts *cpts = cpsw->cpts;
+	struct cpsw_priv *priv = netdev_priv(dev);
 	struct hwtstamp_config cfg;
 
 	if (cpsw->version != CPSW_VERSION_1 &&
@@ -2312,10 +2316,8 @@ static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
 		return -EOPNOTSUPP;
 
 	cfg.flags = 0;
-	cfg.tx_type = cpts_is_tx_enabled(cpts) ?
-		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = (cpts_is_rx_enabled(cpts) ?
-			 cpts->rx_enable : HWTSTAMP_FILTER_NONE);
+	cfg.tx_type = priv->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	cfg.rx_filter = priv->rx_ts_enabled;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 63232b35024e..054f78295d1d 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -430,8 +430,6 @@ void cpts_rx_timestamp(struct cpts *cpts, struct sk_buff *skb)
 	u64 ns;
 	struct skb_shared_hwtstamps *ssh;
 
-	if (!cpts->rx_enable)
-		return;
 	ns = cpts_find_ts(cpts, skb, CPTS_EV_RX);
 	if (!ns)
 		return;
diff --git a/drivers/net/ethernet/ti/cpts.h b/drivers/net/ethernet/ti/cpts.h
index 73d73faf0f38..d2c7decd59b6 100644
--- a/drivers/net/ethernet/ti/cpts.h
+++ b/drivers/net/ethernet/ti/cpts.h
@@ -136,26 +136,6 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 			 struct device_node *node);
 void cpts_release(struct cpts *cpts);
 
-static inline void cpts_rx_enable(struct cpts *cpts, int enable)
-{
-	cpts->rx_enable = enable;
-}
-
-static inline bool cpts_is_rx_enabled(struct cpts *cpts)
-{
-	return !!cpts->rx_enable;
-}
-
-static inline void cpts_tx_enable(struct cpts *cpts, int enable)
-{
-	cpts->tx_enable = enable;
-}
-
-static inline bool cpts_is_tx_enabled(struct cpts *cpts)
-{
-	return !!cpts->tx_enable;
-}
-
 static inline bool cpts_can_timestamp(struct cpts *cpts, struct sk_buff *skb)
 {
 	unsigned int class = ptp_classify_raw(skb);
@@ -197,24 +177,6 @@ static inline void cpts_unregister(struct cpts *cpts)
 {
 }
 
-static inline void cpts_rx_enable(struct cpts *cpts, int enable)
-{
-}
-
-static inline bool cpts_is_rx_enabled(struct cpts *cpts)
-{
-	return false;
-}
-
-static inline void cpts_tx_enable(struct cpts *cpts, int enable)
-{
-}
-
-static inline bool cpts_is_tx_enabled(struct cpts *cpts)
-{
-	return false;
-}
-
 static inline bool cpts_can_timestamp(struct cpts *cpts, struct sk_buff *skb)
 {
 	return false;
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 0397ccb6597e..20d81e0b1c29 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -763,6 +763,8 @@ struct gbe_priv {
 
 	int                             cpts_registered;
 	struct cpts                     *cpts;
+	int				rx_ts_enabled;
+	int				tx_ts_enabled;
 };
 
 struct gbe_intf {
@@ -2564,7 +2566,7 @@ static int gbe_txtstamp_mark_pkt(struct gbe_intf *gbe_intf,
 	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
 
 	if (!(skb_shinfo(p_info->skb)->tx_flags & SKBTX_HW_TSTAMP) ||
-	    !cpts_is_tx_enabled(gbe_dev->cpts))
+	    !gbe_dev->tx_ts_enabled)
 		return 0;
 
 	/* If phy has the txtstamp api, assume it will do it.
@@ -2598,7 +2600,9 @@ static int gbe_rxtstamp(struct gbe_intf *gbe_intf, struct netcp_packet *p_info)
 		return 0;
 	}
 
-	cpts_rx_timestamp(gbe_dev->cpts, p_info->skb);
+	if (gbe_dev->rx_ts_enabled)
+		cpts_rx_timestamp(gbe_dev->cpts, p_info->skb);
+
 	p_info->rxtstamp_complete = true;
 
 	return 0;
@@ -2614,10 +2618,8 @@ static int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 		return -EOPNOTSUPP;
 
 	cfg.flags = 0;
-	cfg.tx_type = cpts_is_tx_enabled(cpts) ?
-		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = (cpts_is_rx_enabled(cpts) ?
-			 cpts->rx_enable : HWTSTAMP_FILTER_NONE);
+	cfg.tx_type = gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	cfg.rx_filter = gbe_dev->rx_ts_enabled;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
@@ -2628,8 +2630,8 @@ static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
 	struct gbe_slave *slave = gbe_intf->slave;
 	u32 ts_en, seq_id, ctl;
 
-	if (!cpts_is_rx_enabled(gbe_dev->cpts) &&
-	    !cpts_is_tx_enabled(gbe_dev->cpts)) {
+	if (!gbe_dev->rx_ts_enabled &&
+	    !gbe_dev->tx_ts_enabled) {
 		writel(0, GBE_REG_ADDR(slave, port_regs, ts_ctl));
 		return;
 	}
@@ -2641,10 +2643,10 @@ static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
 		(slave->ts_ctl.uni ?  TS_UNI_EN :
 			slave->ts_ctl.maddr_map << TS_CTL_MADDR_SHIFT);
 
-	if (cpts_is_tx_enabled(gbe_dev->cpts))
+	if (gbe_dev->tx_ts_enabled)
 		ts_en |= (TS_TX_ANX_ALL_EN | TS_TX_VLAN_LT1_EN);
 
-	if (cpts_is_rx_enabled(gbe_dev->cpts))
+	if (gbe_dev->rx_ts_enabled)
 		ts_en |= (TS_RX_ANX_ALL_EN | TS_RX_VLAN_LT1_EN);
 
 	writel(ts_en,  GBE_REG_ADDR(slave, port_regs, ts_ctl));
@@ -2670,10 +2672,10 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 
 	switch (cfg.tx_type) {
 	case HWTSTAMP_TX_OFF:
-		cpts_tx_enable(cpts, 0);
+		gbe_dev->tx_ts_enabled = 0;
 		break;
 	case HWTSTAMP_TX_ON:
-		cpts_tx_enable(cpts, 1);
+		gbe_dev->tx_ts_enabled = 1;
 		break;
 	default:
 		return -ERANGE;
@@ -2681,12 +2683,12 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		cpts_rx_enable(cpts, 0);
+		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		cpts_rx_enable(cpts, HWTSTAMP_FILTER_PTP_V1_L4_EVENT);
+		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -2698,7 +2700,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		cpts_rx_enable(cpts, HWTSTAMP_FILTER_PTP_V2_EVENT);
+		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	default:
-- 
2.17.1
