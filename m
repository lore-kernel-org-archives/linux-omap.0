From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 20/20] net: ethernet: ti: cpsw: move ethtool func in separate file
Date: Fri, 26 Apr 2019 20:12:42 +0300
Message-ID: <1556298762-8632-21-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

As a preparatory patch to add support for a switchdev based cpsw driver,
move common ethtool functions to separate cpsw-ethtool.c file so that they
can be used across both drivers. It will simplify CPSW driver code
maintenance also.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Makefile       |   2 +-
 drivers/net/ethernet/ti/cpsw.c         | 690 +-----------------------
 drivers/net/ethernet/ti/cpsw_ethtool.c | 719 +++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_priv.h    |  83 +--
 4 files changed, 769 insertions(+), 725 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/cpsw_ethtool.c

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 0a75c1957626..c3f53a40b48f 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
-ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o
+ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o cpsw_ale.o
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4449f2eeac09..660c716e7eb6 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -60,82 +60,6 @@ static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
 module_param(descs_pool_size, int, 0444);
 MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
 
-struct cpsw_stats {
-	char stat_string[ETH_GSTRING_LEN];
-	int type;
-	int sizeof_stat;
-	int stat_offset;
-};
-
-enum {
-	CPSW_STATS,
-	CPDMA_RX_STATS,
-	CPDMA_TX_STATS,
-};
-
-#define CPSW_STAT(m)		CPSW_STATS,				\
-				FIELD_SIZEOF(struct cpsw_hw_stats, m), \
-				offsetof(struct cpsw_hw_stats, m)
-#define CPDMA_RX_STAT(m)	CPDMA_RX_STATS,				   \
-				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
-				offsetof(struct cpdma_chan_stats, m)
-#define CPDMA_TX_STAT(m)	CPDMA_TX_STATS,				   \
-				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
-				offsetof(struct cpdma_chan_stats, m)
-
-static const struct cpsw_stats cpsw_gstrings_stats[] = {
-	{ "Good Rx Frames", CPSW_STAT(rxgoodframes) },
-	{ "Broadcast Rx Frames", CPSW_STAT(rxbroadcastframes) },
-	{ "Multicast Rx Frames", CPSW_STAT(rxmulticastframes) },
-	{ "Pause Rx Frames", CPSW_STAT(rxpauseframes) },
-	{ "Rx CRC Errors", CPSW_STAT(rxcrcerrors) },
-	{ "Rx Align/Code Errors", CPSW_STAT(rxaligncodeerrors) },
-	{ "Oversize Rx Frames", CPSW_STAT(rxoversizedframes) },
-	{ "Rx Jabbers", CPSW_STAT(rxjabberframes) },
-	{ "Undersize (Short) Rx Frames", CPSW_STAT(rxundersizedframes) },
-	{ "Rx Fragments", CPSW_STAT(rxfragments) },
-	{ "Rx Octets", CPSW_STAT(rxoctets) },
-	{ "Good Tx Frames", CPSW_STAT(txgoodframes) },
-	{ "Broadcast Tx Frames", CPSW_STAT(txbroadcastframes) },
-	{ "Multicast Tx Frames", CPSW_STAT(txmulticastframes) },
-	{ "Pause Tx Frames", CPSW_STAT(txpauseframes) },
-	{ "Deferred Tx Frames", CPSW_STAT(txdeferredframes) },
-	{ "Collisions", CPSW_STAT(txcollisionframes) },
-	{ "Single Collision Tx Frames", CPSW_STAT(txsinglecollframes) },
-	{ "Multiple Collision Tx Frames", CPSW_STAT(txmultcollframes) },
-	{ "Excessive Collisions", CPSW_STAT(txexcessivecollisions) },
-	{ "Late Collisions", CPSW_STAT(txlatecollisions) },
-	{ "Tx Underrun", CPSW_STAT(txunderrun) },
-	{ "Carrier Sense Errors", CPSW_STAT(txcarriersenseerrors) },
-	{ "Tx Octets", CPSW_STAT(txoctets) },
-	{ "Rx + Tx 64 Octet Frames", CPSW_STAT(octetframes64) },
-	{ "Rx + Tx 65-127 Octet Frames", CPSW_STAT(octetframes65t127) },
-	{ "Rx + Tx 128-255 Octet Frames", CPSW_STAT(octetframes128t255) },
-	{ "Rx + Tx 256-511 Octet Frames", CPSW_STAT(octetframes256t511) },
-	{ "Rx + Tx 512-1023 Octet Frames", CPSW_STAT(octetframes512t1023) },
-	{ "Rx + Tx 1024-Up Octet Frames", CPSW_STAT(octetframes1024tup) },
-	{ "Net Octets", CPSW_STAT(netoctets) },
-	{ "Rx Start of Frame Overruns", CPSW_STAT(rxsofoverruns) },
-	{ "Rx Middle of Frame Overruns", CPSW_STAT(rxmofoverruns) },
-	{ "Rx DMA Overruns", CPSW_STAT(rxdmaoverruns) },
-};
-
-static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
-	{ "head_enqueue", CPDMA_RX_STAT(head_enqueue) },
-	{ "tail_enqueue", CPDMA_RX_STAT(tail_enqueue) },
-	{ "pad_enqueue", CPDMA_RX_STAT(pad_enqueue) },
-	{ "misqueued", CPDMA_RX_STAT(misqueued) },
-	{ "desc_alloc_fail", CPDMA_RX_STAT(desc_alloc_fail) },
-	{ "pad_alloc_fail", CPDMA_RX_STAT(pad_alloc_fail) },
-	{ "runt_receive_buf", CPDMA_RX_STAT(runt_receive_buff) },
-	{ "runt_transmit_buf", CPDMA_RX_STAT(runt_transmit_buff) },
-	{ "empty_dequeue", CPDMA_RX_STAT(empty_dequeue) },
-	{ "busy_dequeue", CPDMA_RX_STAT(busy_dequeue) },
-	{ "good_dequeue", CPDMA_RX_STAT(good_dequeue) },
-	{ "requeue", CPDMA_RX_STAT(requeue) },
-	{ "teardown_dequeue", CPDMA_RX_STAT(teardown_dequeue) },
-};
-
 #define for_each_slave(priv, func, arg...)				\
 	do {								\
 		struct cpsw_slave *slave;				\
@@ -395,7 +319,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 			       cpsw_del_mc_addr);
 }
 
-static void cpsw_intr_enable(struct cpsw_common *cpsw)
+void cpsw_intr_enable(struct cpsw_common *cpsw)
 {
 	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
 	writel_relaxed(0xFF, &cpsw->wr_regs->rx_en);
@@ -404,7 +328,7 @@ static void cpsw_intr_enable(struct cpsw_common *cpsw)
 	return;
 }
 
-static void cpsw_intr_disable(struct cpsw_common *cpsw)
+void cpsw_intr_disable(struct cpsw_common *cpsw)
 {
 	writel_relaxed(0, &cpsw->wr_regs->tx_en);
 	writel_relaxed(0, &cpsw->wr_regs->rx_en);
@@ -413,7 +337,7 @@ static void cpsw_intr_disable(struct cpsw_common *cpsw)
 	return;
 }
 
-static void cpsw_tx_handler(void *token, int len, int status)
+void cpsw_tx_handler(void *token, int len, int status)
 {
 	struct netdev_queue	*txq;
 	struct sk_buff		*skb = token;
@@ -545,7 +469,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		dev_kfree_skb_any(new_skb);
 }
 
-static void cpsw_split_res(struct cpsw_common *cpsw)
+void cpsw_split_res(struct cpsw_common *cpsw)
 {
 	u32 consumed_rate = 0, bigest_rate = 0;
 	struct cpsw_vector *txv = cpsw->txv;
@@ -937,156 +861,6 @@ static void cpsw_adjust_link(struct net_device *ndev)
 	}
 }
 
-static int cpsw_get_coalesce(struct net_device *ndev,
-				struct ethtool_coalesce *coal)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	coal->rx_coalesce_usecs = cpsw->coal_intvl;
-	return 0;
-}
-
-static int cpsw_set_coalesce(struct net_device *ndev,
-				struct ethtool_coalesce *coal)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	u32 int_ctrl;
-	u32 num_interrupts = 0;
-	u32 prescale = 0;
-	u32 addnl_dvdr = 1;
-	u32 coal_intvl = 0;
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	coal_intvl = coal->rx_coalesce_usecs;
-
-	int_ctrl =  readl(&cpsw->wr_regs->int_control);
-	prescale = cpsw->bus_freq_mhz * 4;
-
-	if (!coal->rx_coalesce_usecs) {
-		int_ctrl &= ~(CPSW_INTPRESCALE_MASK | CPSW_INTPACEEN);
-		goto update_return;
-	}
-
-	if (coal_intvl < CPSW_CMINTMIN_INTVL)
-		coal_intvl = CPSW_CMINTMIN_INTVL;
-
-	if (coal_intvl > CPSW_CMINTMAX_INTVL) {
-		/* Interrupt pacer works with 4us Pulse, we can
-		 * throttle further by dilating the 4us pulse.
-		 */
-		addnl_dvdr = CPSW_INTPRESCALE_MASK / prescale;
-
-		if (addnl_dvdr > 1) {
-			prescale *= addnl_dvdr;
-			if (coal_intvl > (CPSW_CMINTMAX_INTVL * addnl_dvdr))
-				coal_intvl = (CPSW_CMINTMAX_INTVL
-						* addnl_dvdr);
-		} else {
-			addnl_dvdr = 1;
-			coal_intvl = CPSW_CMINTMAX_INTVL;
-		}
-	}
-
-	num_interrupts = (1000 * addnl_dvdr) / coal_intvl;
-	writel(num_interrupts, &cpsw->wr_regs->rx_imax);
-	writel(num_interrupts, &cpsw->wr_regs->tx_imax);
-
-	int_ctrl |= CPSW_INTPACEEN;
-	int_ctrl &= (~CPSW_INTPRESCALE_MASK);
-	int_ctrl |= (prescale & CPSW_INTPRESCALE_MASK);
-
-update_return:
-	writel(int_ctrl, &cpsw->wr_regs->int_control);
-
-	cpsw_notice(priv, timer, "Set coalesce to %d usecs.\n", coal_intvl);
-	cpsw->coal_intvl = coal_intvl;
-
-	return 0;
-}
-
-static int cpsw_get_sset_count(struct net_device *ndev, int sset)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	switch (sset) {
-	case ETH_SS_STATS:
-		return (CPSW_STATS_COMMON_LEN +
-		       (cpsw->rx_ch_num + cpsw->tx_ch_num) *
-		       CPSW_STATS_CH_LEN);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static void cpsw_add_ch_strings(u8 **p, int ch_num, int rx_dir)
-{
-	int ch_stats_len;
-	int line;
-	int i;
-
-	ch_stats_len = CPSW_STATS_CH_LEN * ch_num;
-	for (i = 0; i < ch_stats_len; i++) {
-		line = i % CPSW_STATS_CH_LEN;
-		snprintf(*p, ETH_GSTRING_LEN,
-			 "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
-			 (long)(i / CPSW_STATS_CH_LEN),
-			 cpsw_gstrings_ch_stats[line].stat_string);
-		*p += ETH_GSTRING_LEN;
-	}
-}
-
-static void cpsw_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	u8 *p = data;
-	int i;
-
-	switch (stringset) {
-	case ETH_SS_STATS:
-		for (i = 0; i < CPSW_STATS_COMMON_LEN; i++) {
-			memcpy(p, cpsw_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-
-		cpsw_add_ch_strings(&p, cpsw->rx_ch_num, 1);
-		cpsw_add_ch_strings(&p, cpsw->tx_ch_num, 0);
-		break;
-	}
-}
-
-static void cpsw_get_ethtool_stats(struct net_device *ndev,
-				    struct ethtool_stats *stats, u64 *data)
-{
-	u8 *p;
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	struct cpdma_chan_stats ch_stats;
-	int i, l, ch;
-
-	/* Collect Davinci CPDMA stats for Rx and Tx Channel */
-	for (l = 0; l < CPSW_STATS_COMMON_LEN; l++)
-		data[l] = readl(cpsw->hw_stats +
-				cpsw_gstrings_stats[l].stat_offset);
-
-	for (ch = 0; ch < cpsw->rx_ch_num; ch++) {
-		cpdma_chan_get_stats(cpsw->rxv[ch].ch, &ch_stats);
-		for (i = 0; i < CPSW_STATS_CH_LEN; i++, l++) {
-			p = (u8 *)&ch_stats +
-				cpsw_gstrings_ch_stats[i].stat_offset;
-			data[l] = *(u32 *)p;
-		}
-	}
-
-	for (ch = 0; ch < cpsw->tx_ch_num; ch++) {
-		cpdma_chan_get_stats(cpsw->txv[ch].ch, &ch_stats);
-		for (i = 0; i < CPSW_STATS_CH_LEN; i++, l++) {
-			p = (u8 *)&ch_stats +
-				cpsw_gstrings_ch_stats[i].stat_offset;
-			data[l] = *(u32 *)p;
-		}
-	}
-}
-
 static inline void cpsw_add_dual_emac_def_ale_entries(
 		struct cpsw_priv *priv, struct cpsw_slave *slave,
 		u32 slave_port)
@@ -1258,7 +1032,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	}
 }
 
-static int cpsw_fill_rx_channels(struct cpsw_priv *priv)
+int cpsw_fill_rx_channels(struct cpsw_priv *priv)
 {
 	struct cpsw_common *cpsw = priv->cpsw;
 	struct sk_buff *skb;
@@ -1983,18 +1757,6 @@ static int cpsw_ndo_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void cpsw_ndo_poll_controller(struct net_device *ndev)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	cpsw_intr_disable(cpsw);
-	cpsw_rx_interrupt(cpsw->irqs_table[0], cpsw);
-	cpsw_tx_interrupt(cpsw->irqs_table[1], cpsw);
-	cpsw_intr_enable(cpsw);
-}
-#endif
-
 static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 				unsigned short vid)
 {
@@ -2260,25 +2022,6 @@ static const struct net_device_ops cpsw_netdev_ops = {
 	.ndo_setup_tc           = cpsw_ndo_setup_tc,
 };
 
-static int cpsw_get_regs_len(struct net_device *ndev)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	return cpsw->data.ale_entries * ALE_ENTRY_WORDS * sizeof(u32);
-}
-
-static void cpsw_get_regs(struct net_device *ndev,
-			  struct ethtool_regs *regs, void *p)
-{
-	u32 *reg = p;
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	/* update CPSW IP version */
-	regs->version = cpsw->version;
-
-	cpsw_ale_dump(cpsw->ale, reg);
-}
-
 static void cpsw_get_drvinfo(struct net_device *ndev,
 			     struct ethtool_drvinfo *info)
 {
@@ -2290,119 +2033,6 @@ static void cpsw_get_drvinfo(struct net_device *ndev,
 	strlcpy(info->bus_info, pdev->name, sizeof(info->bus_info));
 }
 
-static u32 cpsw_get_msglevel(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	return priv->msg_enable;
-}
-
-static void cpsw_set_msglevel(struct net_device *ndev, u32 value)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	priv->msg_enable = value;
-}
-
-#if IS_ENABLED(CONFIG_TI_CPTS)
-static int cpsw_get_ts_info(struct net_device *ndev,
-			    struct ethtool_ts_info *info)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_HARDWARE |
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
-		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = cpsw->cpts->phc_index;
-	info->tx_types =
-		(1 << HWTSTAMP_TX_OFF) |
-		(1 << HWTSTAMP_TX_ON);
-	info->rx_filters =
-		(1 << HWTSTAMP_FILTER_NONE) |
-		(1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
-		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
-	return 0;
-}
-#else
-static int cpsw_get_ts_info(struct net_device *ndev,
-			    struct ethtool_ts_info *info)
-{
-	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE;
-	info->phc_index = -1;
-	info->tx_types = 0;
-	info->rx_filters = 0;
-	return 0;
-}
-#endif
-
-static int cpsw_get_link_ksettings(struct net_device *ndev,
-				   struct ethtool_link_ksettings *ecmd)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (!cpsw->slaves[slave_no].phy)
-		return -EOPNOTSUPP;
-
-	phy_ethtool_ksettings_get(cpsw->slaves[slave_no].phy, ecmd);
-	return 0;
-}
-
-static int cpsw_set_link_ksettings(struct net_device *ndev,
-				   const struct ethtool_link_ksettings *ecmd)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (cpsw->slaves[slave_no].phy)
-		return phy_ethtool_ksettings_set(cpsw->slaves[slave_no].phy,
-						 ecmd);
-	else
-		return -EOPNOTSUPP;
-}
-
-static void cpsw_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	wol->supported = 0;
-	wol->wolopts = 0;
-
-	if (cpsw->slaves[slave_no].phy)
-		phy_ethtool_get_wol(cpsw->slaves[slave_no].phy, wol);
-}
-
-static int cpsw_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (cpsw->slaves[slave_no].phy)
-		return phy_ethtool_set_wol(cpsw->slaves[slave_no].phy, wol);
-	else
-		return -EOPNOTSUPP;
-}
-
-static void cpsw_get_pauseparam(struct net_device *ndev,
-				struct ethtool_pauseparam *pause)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-
-	pause->autoneg = AUTONEG_DISABLE;
-	pause->rx_pause = priv->rx_pause ? true : false;
-	pause->tx_pause = priv->tx_pause ? true : false;
-}
-
 static int cpsw_set_pauseparam(struct net_device *ndev,
 			       struct ethtool_pauseparam *pause)
 {
@@ -2416,316 +2046,10 @@ static int cpsw_set_pauseparam(struct net_device *ndev,
 	return 0;
 }
 
-static int cpsw_ethtool_op_begin(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int ret;
-
-	ret = pm_runtime_get_sync(cpsw->dev);
-	if (ret < 0) {
-		cpsw_err(priv, drv, "ethtool begin failed %d\n", ret);
-		pm_runtime_put_noidle(cpsw->dev);
-	}
-
-	return ret;
-}
-
-static void cpsw_ethtool_op_complete(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	int ret;
-
-	ret = pm_runtime_put(priv->cpsw->dev);
-	if (ret < 0)
-		cpsw_err(priv, drv, "ethtool complete failed %d\n", ret);
-}
-
-static void cpsw_get_channels(struct net_device *ndev,
-			      struct ethtool_channels *ch)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-
-	ch->max_rx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
-	ch->max_tx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
-	ch->max_combined = 0;
-	ch->max_other = 0;
-	ch->other_count = 0;
-	ch->rx_count = cpsw->rx_ch_num;
-	ch->tx_count = cpsw->tx_ch_num;
-	ch->combined_count = 0;
-}
-
-static int cpsw_check_ch_settings(struct cpsw_common *cpsw,
-				  struct ethtool_channels *ch)
-{
-	if (cpsw->quirk_irq) {
-		dev_err(cpsw->dev, "Maximum one tx/rx queue is allowed");
-		return -EOPNOTSUPP;
-	}
-
-	if (ch->combined_count)
-		return -EINVAL;
-
-	/* verify we have at least one channel in each direction */
-	if (!ch->rx_count || !ch->tx_count)
-		return -EINVAL;
-
-	if (ch->rx_count > cpsw->data.channels ||
-	    ch->tx_count > cpsw->data.channels)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-	void (*handler)(void *, int, int);
-	struct netdev_queue *queue;
-	struct cpsw_vector *vec;
-	int ret, *ch, vch;
-
-	if (rx) {
-		ch = &cpsw->rx_ch_num;
-		vec = cpsw->rxv;
-		handler = cpsw_rx_handler;
-	} else {
-		ch = &cpsw->tx_ch_num;
-		vec = cpsw->txv;
-		handler = cpsw_tx_handler;
-	}
-
-	while (*ch < ch_num) {
-		vch = rx ? *ch : 7 - *ch;
-		vec[*ch].ch = cpdma_chan_create(cpsw->dma, vch, handler, rx);
-		queue = netdev_get_tx_queue(priv->ndev, *ch);
-		queue->tx_maxrate = 0;
-
-		if (IS_ERR(vec[*ch].ch))
-			return PTR_ERR(vec[*ch].ch);
-
-		if (!vec[*ch].ch)
-			return -EINVAL;
-
-		cpsw_info(priv, ifup, "created new %d %s channel\n", *ch,
-			  (rx ? "rx" : "tx"));
-		(*ch)++;
-	}
-
-	while (*ch > ch_num) {
-		(*ch)--;
-
-		ret = cpdma_chan_destroy(vec[*ch].ch);
-		if (ret)
-			return ret;
-
-		cpsw_info(priv, ifup, "destroyed %d %s channel\n", *ch,
-			  (rx ? "rx" : "tx"));
-	}
-
-	return 0;
-}
-
-static int cpsw_update_channels(struct cpsw_priv *priv,
-				struct ethtool_channels *ch)
-{
-	int ret;
-
-	ret = cpsw_update_channels_res(priv, ch->rx_count, 1);
-	if (ret)
-		return ret;
-
-	ret = cpsw_update_channels_res(priv, ch->tx_count, 0);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void cpsw_suspend_data_pass(struct net_device *ndev)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	struct cpsw_slave *slave;
-	int i;
-
-	/* Disable NAPI scheduling */
-	cpsw_intr_disable(cpsw);
-
-	/* Stop all transmit queues for every network device.
-	 * Disable re-using rx descriptors with dormant_on.
-	 */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
-			continue;
-
-		netif_tx_stop_all_queues(slave->ndev);
-		netif_dormant_on(slave->ndev);
-	}
-
-	/* Handle rest of tx packets and stop cpdma channels */
-	cpdma_ctlr_stop(cpsw->dma);
-}
-
-static int cpsw_resume_data_pass(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
-	int i, ret;
-
-	/* Allow rx packets handling */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_dormant_off(slave->ndev);
-
-	/* After this receive is started */
-	if (cpsw->usage_count) {
-		ret = cpsw_fill_rx_channels(priv);
-		if (ret)
-			return ret;
-
-		cpdma_ctlr_start(cpsw->dma);
-		cpsw_intr_enable(cpsw);
-	}
-
-	/* Resume transmit for every affected interface */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_tx_start_all_queues(slave->ndev);
-
-	return 0;
-}
-
 static int cpsw_set_channels(struct net_device *ndev,
 			     struct ethtool_channels *chs)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
-	int i, ret;
-
-	ret = cpsw_check_ch_settings(cpsw, chs);
-	if (ret < 0)
-		return ret;
-
-	cpsw_suspend_data_pass(ndev);
-	ret = cpsw_update_channels(priv, chs);
-	if (ret)
-		goto err;
-
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
-			continue;
-
-		/* Inform stack about new count of queues */
-		ret = netif_set_real_num_tx_queues(slave->ndev,
-						   cpsw->tx_ch_num);
-		if (ret) {
-			dev_err(priv->dev, "cannot set real number of tx queues\n");
-			goto err;
-		}
-
-		ret = netif_set_real_num_rx_queues(slave->ndev,
-						   cpsw->rx_ch_num);
-		if (ret) {
-			dev_err(priv->dev, "cannot set real number of rx queues\n");
-			goto err;
-		}
-	}
-
-	if (cpsw->usage_count)
-		cpsw_split_res(cpsw);
-
-	ret = cpsw_resume_data_pass(ndev);
-	if (!ret)
-		return 0;
-err:
-	dev_err(priv->dev, "cannot update channels number, closing device\n");
-	dev_close(ndev);
-	return ret;
-}
-
-static int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (cpsw->slaves[slave_no].phy)
-		return phy_ethtool_get_eee(cpsw->slaves[slave_no].phy, edata);
-	else
-		return -EOPNOTSUPP;
-}
-
-static int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (cpsw->slaves[slave_no].phy)
-		return phy_ethtool_set_eee(cpsw->slaves[slave_no].phy, edata);
-	else
-		return -EOPNOTSUPP;
-}
-
-static int cpsw_nway_reset(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (cpsw->slaves[slave_no].phy)
-		return genphy_restart_aneg(cpsw->slaves[slave_no].phy);
-	else
-		return -EOPNOTSUPP;
-}
-
-static void cpsw_get_ringparam(struct net_device *ndev,
-			       struct ethtool_ringparam *ering)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	/* not supported */
-	ering->tx_max_pending = 0;
-	ering->tx_pending = cpdma_get_num_tx_descs(cpsw->dma);
-	ering->rx_max_pending = descs_pool_size - CPSW_MAX_QUEUES;
-	ering->rx_pending = cpdma_get_num_rx_descs(cpsw->dma);
-}
-
-static int cpsw_set_ringparam(struct net_device *ndev,
-			      struct ethtool_ringparam *ering)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int ret;
-
-	/* ignore ering->tx_pending - only rx_pending adjustment is supported */
-
-	if (ering->rx_mini_pending || ering->rx_jumbo_pending ||
-	    ering->rx_pending < CPSW_MAX_QUEUES ||
-	    ering->rx_pending > (descs_pool_size - CPSW_MAX_QUEUES))
-		return -EINVAL;
-
-	if (ering->rx_pending == cpdma_get_num_rx_descs(cpsw->dma))
-		return 0;
-
-	cpsw_suspend_data_pass(ndev);
-
-	cpdma_set_num_rx_descs(cpsw->dma, ering->rx_pending);
-
-	if (cpsw->usage_count)
-		cpdma_chan_split_pool(cpsw->dma);
-
-	ret = cpsw_resume_data_pass(ndev);
-	if (!ret)
-		return 0;
-
-	dev_err(&ndev->dev, "cannot set ring params, closing device\n");
-	dev_close(ndev);
-	return ret;
+	return cpsw_set_channels_common(ndev, chs, cpsw_rx_handler);
 }
 
 static const struct ethtool_ops cpsw_ethtool_ops = {
@@ -3106,7 +2430,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	cpsw->rx_packet_max = max(rx_packet_max, CPSW_MAX_PACKET_SIZE);
-
+	cpsw->descs_pool_size = descs_pool_size;
 
 	ret = cpsw_init_common(cpsw, ss_regs, ale_ageout,
 			       ss_res->start + CPSW2_BD_OFFSET,
diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
new file mode 100644
index 000000000000..a4a7ec0d2531
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -0,0 +1,719 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments Ethernet Switch Driver ethtool intf
+ *
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/kmemleak.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
+#include <linux/phy.h>
+#include <linux/pm_runtime.h>
+#include <linux/skbuff.h>
+
+#include "cpsw.h"
+#include "cpts.h"
+#include "cpsw_ale.h"
+#include "cpsw_priv.h"
+#include "davinci_cpdma.h"
+
+struct cpsw_hw_stats {
+	u32	rxgoodframes;
+	u32	rxbroadcastframes;
+	u32	rxmulticastframes;
+	u32	rxpauseframes;
+	u32	rxcrcerrors;
+	u32	rxaligncodeerrors;
+	u32	rxoversizedframes;
+	u32	rxjabberframes;
+	u32	rxundersizedframes;
+	u32	rxfragments;
+	u32	__pad_0[2];
+	u32	rxoctets;
+	u32	txgoodframes;
+	u32	txbroadcastframes;
+	u32	txmulticastframes;
+	u32	txpauseframes;
+	u32	txdeferredframes;
+	u32	txcollisionframes;
+	u32	txsinglecollframes;
+	u32	txmultcollframes;
+	u32	txexcessivecollisions;
+	u32	txlatecollisions;
+	u32	txunderrun;
+	u32	txcarriersenseerrors;
+	u32	txoctets;
+	u32	octetframes64;
+	u32	octetframes65t127;
+	u32	octetframes128t255;
+	u32	octetframes256t511;
+	u32	octetframes512t1023;
+	u32	octetframes1024tup;
+	u32	netoctets;
+	u32	rxsofoverruns;
+	u32	rxmofoverruns;
+	u32	rxdmaoverruns;
+};
+
+struct cpsw_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int type;
+	int sizeof_stat;
+	int stat_offset;
+};
+
+enum {
+	CPSW_STATS,
+	CPDMA_RX_STATS,
+	CPDMA_TX_STATS,
+};
+
+#define CPSW_STAT(m)		CPSW_STATS,				\
+				FIELD_SIZEOF(struct cpsw_hw_stats, m), \
+				offsetof(struct cpsw_hw_stats, m)
+#define CPDMA_RX_STAT(m)	CPDMA_RX_STATS,				   \
+				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
+				offsetof(struct cpdma_chan_stats, m)
+#define CPDMA_TX_STAT(m)	CPDMA_TX_STATS,				   \
+				FIELD_SIZEOF(struct cpdma_chan_stats, m), \
+				offsetof(struct cpdma_chan_stats, m)
+
+static const struct cpsw_stats cpsw_gstrings_stats[] = {
+	{ "Good Rx Frames", CPSW_STAT(rxgoodframes) },
+	{ "Broadcast Rx Frames", CPSW_STAT(rxbroadcastframes) },
+	{ "Multicast Rx Frames", CPSW_STAT(rxmulticastframes) },
+	{ "Pause Rx Frames", CPSW_STAT(rxpauseframes) },
+	{ "Rx CRC Errors", CPSW_STAT(rxcrcerrors) },
+	{ "Rx Align/Code Errors", CPSW_STAT(rxaligncodeerrors) },
+	{ "Oversize Rx Frames", CPSW_STAT(rxoversizedframes) },
+	{ "Rx Jabbers", CPSW_STAT(rxjabberframes) },
+	{ "Undersize (Short) Rx Frames", CPSW_STAT(rxundersizedframes) },
+	{ "Rx Fragments", CPSW_STAT(rxfragments) },
+	{ "Rx Octets", CPSW_STAT(rxoctets) },
+	{ "Good Tx Frames", CPSW_STAT(txgoodframes) },
+	{ "Broadcast Tx Frames", CPSW_STAT(txbroadcastframes) },
+	{ "Multicast Tx Frames", CPSW_STAT(txmulticastframes) },
+	{ "Pause Tx Frames", CPSW_STAT(txpauseframes) },
+	{ "Deferred Tx Frames", CPSW_STAT(txdeferredframes) },
+	{ "Collisions", CPSW_STAT(txcollisionframes) },
+	{ "Single Collision Tx Frames", CPSW_STAT(txsinglecollframes) },
+	{ "Multiple Collision Tx Frames", CPSW_STAT(txmultcollframes) },
+	{ "Excessive Collisions", CPSW_STAT(txexcessivecollisions) },
+	{ "Late Collisions", CPSW_STAT(txlatecollisions) },
+	{ "Tx Underrun", CPSW_STAT(txunderrun) },
+	{ "Carrier Sense Errors", CPSW_STAT(txcarriersenseerrors) },
+	{ "Tx Octets", CPSW_STAT(txoctets) },
+	{ "Rx + Tx 64 Octet Frames", CPSW_STAT(octetframes64) },
+	{ "Rx + Tx 65-127 Octet Frames", CPSW_STAT(octetframes65t127) },
+	{ "Rx + Tx 128-255 Octet Frames", CPSW_STAT(octetframes128t255) },
+	{ "Rx + Tx 256-511 Octet Frames", CPSW_STAT(octetframes256t511) },
+	{ "Rx + Tx 512-1023 Octet Frames", CPSW_STAT(octetframes512t1023) },
+	{ "Rx + Tx 1024-Up Octet Frames", CPSW_STAT(octetframes1024tup) },
+	{ "Net Octets", CPSW_STAT(netoctets) },
+	{ "Rx Start of Frame Overruns", CPSW_STAT(rxsofoverruns) },
+	{ "Rx Middle of Frame Overruns", CPSW_STAT(rxmofoverruns) },
+	{ "Rx DMA Overruns", CPSW_STAT(rxdmaoverruns) },
+};
+
+static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
+	{ "head_enqueue", CPDMA_RX_STAT(head_enqueue) },
+	{ "tail_enqueue", CPDMA_RX_STAT(tail_enqueue) },
+	{ "pad_enqueue", CPDMA_RX_STAT(pad_enqueue) },
+	{ "misqueued", CPDMA_RX_STAT(misqueued) },
+	{ "desc_alloc_fail", CPDMA_RX_STAT(desc_alloc_fail) },
+	{ "pad_alloc_fail", CPDMA_RX_STAT(pad_alloc_fail) },
+	{ "runt_receive_buf", CPDMA_RX_STAT(runt_receive_buff) },
+	{ "runt_transmit_buf", CPDMA_RX_STAT(runt_transmit_buff) },
+	{ "empty_dequeue", CPDMA_RX_STAT(empty_dequeue) },
+	{ "busy_dequeue", CPDMA_RX_STAT(busy_dequeue) },
+	{ "good_dequeue", CPDMA_RX_STAT(good_dequeue) },
+	{ "requeue", CPDMA_RX_STAT(requeue) },
+	{ "teardown_dequeue", CPDMA_RX_STAT(teardown_dequeue) },
+};
+
+#define CPSW_STATS_COMMON_LEN	ARRAY_SIZE(cpsw_gstrings_stats)
+#define CPSW_STATS_CH_LEN	ARRAY_SIZE(cpsw_gstrings_ch_stats)
+
+u32 cpsw_get_msglevel(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	return priv->msg_enable;
+}
+
+void cpsw_set_msglevel(struct net_device *ndev, u32 value)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	priv->msg_enable = value;
+}
+
+int cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	coal->rx_coalesce_usecs = cpsw->coal_intvl;
+	return 0;
+}
+
+int cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	u32 int_ctrl;
+	u32 num_interrupts = 0;
+	u32 prescale = 0;
+	u32 addnl_dvdr = 1;
+	u32 coal_intvl = 0;
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	coal_intvl = coal->rx_coalesce_usecs;
+
+	int_ctrl =  readl(&cpsw->wr_regs->int_control);
+	prescale = cpsw->bus_freq_mhz * 4;
+
+	if (!coal->rx_coalesce_usecs) {
+		int_ctrl &= ~(CPSW_INTPRESCALE_MASK | CPSW_INTPACEEN);
+		goto update_return;
+	}
+
+	if (coal_intvl < CPSW_CMINTMIN_INTVL)
+		coal_intvl = CPSW_CMINTMIN_INTVL;
+
+	if (coal_intvl > CPSW_CMINTMAX_INTVL) {
+		/* Interrupt pacer works with 4us Pulse, we can
+		 * throttle further by dilating the 4us pulse.
+		 */
+		addnl_dvdr = CPSW_INTPRESCALE_MASK / prescale;
+
+		if (addnl_dvdr > 1) {
+			prescale *= addnl_dvdr;
+			if (coal_intvl > (CPSW_CMINTMAX_INTVL * addnl_dvdr))
+				coal_intvl = (CPSW_CMINTMAX_INTVL
+						* addnl_dvdr);
+		} else {
+			addnl_dvdr = 1;
+			coal_intvl = CPSW_CMINTMAX_INTVL;
+		}
+	}
+
+	num_interrupts = (1000 * addnl_dvdr) / coal_intvl;
+	writel(num_interrupts, &cpsw->wr_regs->rx_imax);
+	writel(num_interrupts, &cpsw->wr_regs->tx_imax);
+
+	int_ctrl |= CPSW_INTPACEEN;
+	int_ctrl &= (~CPSW_INTPRESCALE_MASK);
+	int_ctrl |= (prescale & CPSW_INTPRESCALE_MASK);
+
+update_return:
+	writel(int_ctrl, &cpsw->wr_regs->int_control);
+
+	cpsw_notice(priv, timer, "Set coalesce to %d usecs.\n", coal_intvl);
+	cpsw->coal_intvl = coal_intvl;
+
+	return 0;
+}
+
+int cpsw_get_sset_count(struct net_device *ndev, int sset)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return (CPSW_STATS_COMMON_LEN +
+		       (cpsw->rx_ch_num + cpsw->tx_ch_num) *
+		       CPSW_STATS_CH_LEN);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void cpsw_add_ch_strings(u8 **p, int ch_num, int rx_dir)
+{
+	int ch_stats_len;
+	int line;
+	int i;
+
+	ch_stats_len = CPSW_STATS_CH_LEN * ch_num;
+	for (i = 0; i < ch_stats_len; i++) {
+		line = i % CPSW_STATS_CH_LEN;
+		snprintf(*p, ETH_GSTRING_LEN,
+			 "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
+			 (long)(i / CPSW_STATS_CH_LEN),
+			 cpsw_gstrings_ch_stats[line].stat_string);
+		*p += ETH_GSTRING_LEN;
+	}
+}
+
+void cpsw_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	u8 *p = data;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < CPSW_STATS_COMMON_LEN; i++) {
+			memcpy(p, cpsw_gstrings_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+
+		cpsw_add_ch_strings(&p, cpsw->rx_ch_num, 1);
+		cpsw_add_ch_strings(&p, cpsw->tx_ch_num, 0);
+		break;
+	}
+}
+
+void cpsw_get_ethtool_stats(struct net_device *ndev,
+			    struct ethtool_stats *stats, u64 *data)
+{
+	u8 *p;
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct cpdma_chan_stats ch_stats;
+	int i, l, ch;
+
+	/* Collect Davinci CPDMA stats for Rx and Tx Channel */
+	for (l = 0; l < CPSW_STATS_COMMON_LEN; l++)
+		data[l] = readl(cpsw->hw_stats +
+				cpsw_gstrings_stats[l].stat_offset);
+
+	for (ch = 0; ch < cpsw->rx_ch_num; ch++) {
+		cpdma_chan_get_stats(cpsw->rxv[ch].ch, &ch_stats);
+		for (i = 0; i < CPSW_STATS_CH_LEN; i++, l++) {
+			p = (u8 *)&ch_stats +
+				cpsw_gstrings_ch_stats[i].stat_offset;
+			data[l] = *(u32 *)p;
+		}
+	}
+
+	for (ch = 0; ch < cpsw->tx_ch_num; ch++) {
+		cpdma_chan_get_stats(cpsw->txv[ch].ch, &ch_stats);
+		for (i = 0; i < CPSW_STATS_CH_LEN; i++, l++) {
+			p = (u8 *)&ch_stats +
+				cpsw_gstrings_ch_stats[i].stat_offset;
+			data[l] = *(u32 *)p;
+		}
+	}
+}
+
+void cpsw_get_pauseparam(struct net_device *ndev,
+			 struct ethtool_pauseparam *pause)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	pause->autoneg = AUTONEG_DISABLE;
+	pause->rx_pause = priv->rx_pause ? true : false;
+	pause->tx_pause = priv->tx_pause ? true : false;
+}
+
+void cpsw_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	wol->supported = 0;
+	wol->wolopts = 0;
+
+	if (cpsw->slaves[slave_no].phy)
+		phy_ethtool_get_wol(cpsw->slaves[slave_no].phy, wol);
+}
+
+int cpsw_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (cpsw->slaves[slave_no].phy)
+		return phy_ethtool_set_wol(cpsw->slaves[slave_no].phy, wol);
+	else
+		return -EOPNOTSUPP;
+}
+
+int cpsw_get_regs_len(struct net_device *ndev)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	return cpsw->data.ale_entries * ALE_ENTRY_WORDS * sizeof(u32);
+}
+
+void cpsw_get_regs(struct net_device *ndev, struct ethtool_regs *regs, void *p)
+{
+	u32 *reg = p;
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	/* update CPSW IP version */
+	regs->version = cpsw->version;
+
+	cpsw_ale_dump(cpsw->ale, reg);
+}
+
+int cpsw_ethtool_op_begin(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ret;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		cpsw_err(priv, drv, "ethtool begin failed %d\n", ret);
+		pm_runtime_put_noidle(cpsw->dev);
+	}
+
+	return ret;
+}
+
+void cpsw_ethtool_op_complete(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = pm_runtime_put(priv->cpsw->dev);
+	if (ret < 0)
+		cpsw_err(priv, drv, "ethtool complete failed %d\n", ret);
+}
+
+void cpsw_get_channels(struct net_device *ndev, struct ethtool_channels *ch)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	ch->max_rx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
+	ch->max_tx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
+	ch->max_combined = 0;
+	ch->max_other = 0;
+	ch->other_count = 0;
+	ch->rx_count = cpsw->rx_ch_num;
+	ch->tx_count = cpsw->tx_ch_num;
+	ch->combined_count = 0;
+}
+
+int cpsw_get_link_ksettings(struct net_device *ndev,
+			    struct ethtool_link_ksettings *ecmd)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (!cpsw->slaves[slave_no].phy)
+		return -EOPNOTSUPP;
+
+	phy_ethtool_ksettings_get(cpsw->slaves[slave_no].phy, ecmd);
+	return 0;
+}
+
+int cpsw_set_link_ksettings(struct net_device *ndev,
+			    const struct ethtool_link_ksettings *ecmd)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (!cpsw->slaves[slave_no].phy)
+		return -EOPNOTSUPP;
+
+	return phy_ethtool_ksettings_set(cpsw->slaves[slave_no].phy, ecmd);
+}
+
+int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (cpsw->slaves[slave_no].phy)
+		return phy_ethtool_get_eee(cpsw->slaves[slave_no].phy, edata);
+	else
+		return -EOPNOTSUPP;
+}
+
+int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (cpsw->slaves[slave_no].phy)
+		return phy_ethtool_set_eee(cpsw->slaves[slave_no].phy, edata);
+	else
+		return -EOPNOTSUPP;
+}
+
+int cpsw_nway_reset(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (cpsw->slaves[slave_no].phy)
+		return genphy_restart_aneg(cpsw->slaves[slave_no].phy);
+	else
+		return -EOPNOTSUPP;
+}
+
+static void cpsw_suspend_data_pass(struct net_device *ndev)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_slave *slave;
+	int i;
+
+	/* Disable NAPI scheduling */
+	cpsw_intr_disable(cpsw);
+
+	/* Stop all transmit queues for every network device.
+	 * Disable re-using rx descriptors with dormant_on.
+	 */
+	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
+		if (!(slave->ndev && netif_running(slave->ndev)))
+			continue;
+
+		netif_tx_stop_all_queues(slave->ndev);
+		netif_dormant_on(slave->ndev);
+	}
+
+	/* Handle rest of tx packets and stop cpdma channels */
+	cpdma_ctlr_stop(cpsw->dma);
+}
+
+static int cpsw_resume_data_pass(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	int i, ret;
+
+	/* Allow rx packets handling */
+	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
+		if (slave->ndev && netif_running(slave->ndev))
+			netif_dormant_off(slave->ndev);
+
+	/* After this receive is started */
+	if (cpsw->usage_count) {
+		ret = cpsw_fill_rx_channels(priv);
+		if (ret)
+			return ret;
+
+		cpdma_ctlr_start(cpsw->dma);
+		cpsw_intr_enable(cpsw);
+	}
+
+	/* Resume transmit for every affected interface */
+	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
+		if (slave->ndev && netif_running(slave->ndev))
+			netif_tx_start_all_queues(slave->ndev);
+
+	return 0;
+}
+
+static int cpsw_check_ch_settings(struct cpsw_common *cpsw,
+				  struct ethtool_channels *ch)
+{
+	if (cpsw->quirk_irq) {
+		dev_err(cpsw->dev, "Maximum one tx/rx queue is allowed");
+		return -EOPNOTSUPP;
+	}
+
+	if (ch->combined_count)
+		return -EINVAL;
+
+	/* verify we have at least one channel in each direction */
+	if (!ch->rx_count || !ch->tx_count)
+		return -EINVAL;
+
+	if (ch->rx_count > cpsw->data.channels ||
+	    ch->tx_count > cpsw->data.channels)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx,
+				    cpdma_handler_fn rx_handler)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	void (*handler)(void *, int, int);
+	struct netdev_queue *queue;
+	struct cpsw_vector *vec;
+	int ret, *ch, vch;
+
+	if (rx) {
+		ch = &cpsw->rx_ch_num;
+		vec = cpsw->rxv;
+		handler = rx_handler;
+	} else {
+		ch = &cpsw->tx_ch_num;
+		vec = cpsw->txv;
+		handler = cpsw_tx_handler;
+	}
+
+	while (*ch < ch_num) {
+		vch = rx ? *ch : 7 - *ch;
+		vec[*ch].ch = cpdma_chan_create(cpsw->dma, vch, handler, rx);
+		queue = netdev_get_tx_queue(priv->ndev, *ch);
+		queue->tx_maxrate = 0;
+
+		if (IS_ERR(vec[*ch].ch))
+			return PTR_ERR(vec[*ch].ch);
+
+		if (!vec[*ch].ch)
+			return -EINVAL;
+
+		cpsw_info(priv, ifup, "created new %d %s channel\n", *ch,
+			  (rx ? "rx" : "tx"));
+		(*ch)++;
+	}
+
+	while (*ch > ch_num) {
+		(*ch)--;
+
+		ret = cpdma_chan_destroy(vec[*ch].ch);
+		if (ret)
+			return ret;
+
+		cpsw_info(priv, ifup, "destroyed %d %s channel\n", *ch,
+			  (rx ? "rx" : "tx"));
+	}
+
+	return 0;
+}
+
+int cpsw_set_channels_common(struct net_device *ndev,
+			     struct ethtool_channels *chs,
+			     cpdma_handler_fn rx_handler)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	int i, ret;
+
+	ret = cpsw_check_ch_settings(cpsw, chs);
+	if (ret < 0)
+		return ret;
+
+	cpsw_suspend_data_pass(ndev);
+
+	ret = cpsw_update_channels_res(priv, chs->rx_count, 1, rx_handler);
+	if (ret)
+		goto err;
+
+	ret = cpsw_update_channels_res(priv, chs->tx_count, 0, rx_handler);
+	if (ret)
+		goto err;
+
+	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
+		if (!(slave->ndev && netif_running(slave->ndev)))
+			continue;
+
+		/* Inform stack about new count of queues */
+		ret = netif_set_real_num_tx_queues(slave->ndev,
+						   cpsw->tx_ch_num);
+		if (ret) {
+			dev_err(priv->dev, "cannot set real number of tx queues\n");
+			goto err;
+		}
+
+		ret = netif_set_real_num_rx_queues(slave->ndev,
+						   cpsw->rx_ch_num);
+		if (ret) {
+			dev_err(priv->dev, "cannot set real number of rx queues\n");
+			goto err;
+		}
+	}
+
+	if (cpsw->usage_count)
+		cpsw_split_res(cpsw);
+
+	ret = cpsw_resume_data_pass(ndev);
+	if (!ret)
+		return 0;
+err:
+	dev_err(priv->dev, "cannot update channels number, closing device\n");
+	dev_close(ndev);
+	return ret;
+}
+
+void cpsw_get_ringparam(struct net_device *ndev,
+			struct ethtool_ringparam *ering)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	/* not supported */
+	ering->tx_max_pending = 0;
+	ering->tx_pending = cpdma_get_num_tx_descs(cpsw->dma);
+	ering->rx_max_pending = cpsw->descs_pool_size - CPSW_MAX_QUEUES;
+	ering->rx_pending = cpdma_get_num_rx_descs(cpsw->dma);
+}
+
+int cpsw_set_ringparam(struct net_device *ndev,
+		       struct ethtool_ringparam *ering)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ret;
+
+	/* ignore ering->tx_pending - only rx_pending adjustment is supported */
+
+	if (ering->rx_mini_pending || ering->rx_jumbo_pending ||
+	    ering->rx_pending < CPSW_MAX_QUEUES ||
+	    ering->rx_pending > (cpsw->descs_pool_size - CPSW_MAX_QUEUES))
+		return -EINVAL;
+
+	if (ering->rx_pending == cpdma_get_num_rx_descs(cpsw->dma))
+		return 0;
+
+	cpsw_suspend_data_pass(ndev);
+
+	cpdma_set_num_rx_descs(cpsw->dma, ering->rx_pending);
+
+	if (cpsw->usage_count)
+		cpdma_chan_split_pool(cpsw->dma);
+
+	ret = cpsw_resume_data_pass(ndev);
+	if (!ret)
+		return 0;
+
+	dev_err(cpsw->dev, "cannot set ring params, closing device\n");
+	dev_close(ndev);
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_TI_CPTS)
+int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_HARDWARE |
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->phc_index = cpsw->cpts->phc_index;
+	info->tx_types =
+		(1 << HWTSTAMP_TX_OFF) |
+		(1 << HWTSTAMP_TX_ON);
+	info->rx_filters =
+		(1 << HWTSTAMP_FILTER_NONE) |
+		(1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT);
+	return 0;
+}
+#else
+int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
+{
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+	info->tx_types = 0;
+	info->rx_filters = 0;
+	return 0;
+}
+#endif
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index fc1a8dee391e..04795b97ee71 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -6,6 +6,8 @@
 #ifndef DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_
 #define DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_
 
+#include "davinci_cpdma.h"
+
 #define CPSW_DEBUG	(NETIF_MSG_HW		| NETIF_MSG_WOL		| \
 			 NETIF_MSG_DRV		| NETIF_MSG_LINK	| \
 			 NETIF_MSG_IFUP		| NETIF_MSG_INTR	| \
@@ -269,44 +271,6 @@ struct cpsw_host_regs {
 	u32	cpdma_rx_chan_map;
 };
 
-struct cpsw_hw_stats {
-	u32	rxgoodframes;
-	u32	rxbroadcastframes;
-	u32	rxmulticastframes;
-	u32	rxpauseframes;
-	u32	rxcrcerrors;
-	u32	rxaligncodeerrors;
-	u32	rxoversizedframes;
-	u32	rxjabberframes;
-	u32	rxundersizedframes;
-	u32	rxfragments;
-	u32	__pad_0[2];
-	u32	rxoctets;
-	u32	txgoodframes;
-	u32	txbroadcastframes;
-	u32	txmulticastframes;
-	u32	txpauseframes;
-	u32	txdeferredframes;
-	u32	txcollisionframes;
-	u32	txsinglecollframes;
-	u32	txmultcollframes;
-	u32	txexcessivecollisions;
-	u32	txlatecollisions;
-	u32	txunderrun;
-	u32	txcarriersenseerrors;
-	u32	txoctets;
-	u32	octetframes64;
-	u32	octetframes65t127;
-	u32	octetframes128t255;
-	u32	octetframes256t511;
-	u32	octetframes512t1023;
-	u32	octetframes1024tup;
-	u32	netoctets;
-	u32	rxsofoverruns;
-	u32	rxmofoverruns;
-	u32	rxdmaoverruns;
-};
-
 struct cpsw_slave_data {
 	struct device_node *phy_node;
 	char		phy_id[MII_BUS_ID_SIZE];
@@ -368,6 +332,7 @@ struct cpsw_common {
 	u32				coal_intvl;
 	u32				bus_freq_mhz;
 	int				rx_packet_max;
+	int				descs_pool_size;
 	struct cpsw_slave		*slaves;
 	struct cpdma_ctlr		*dma;
 	struct cpsw_vector		txv[CPSW_MAX_QUEUES];
@@ -399,9 +364,6 @@ struct cpsw_priv {
 	struct cpsw_common *cpsw;
 };
 
-#define CPSW_STATS_COMMON_LEN	ARRAY_SIZE(cpsw_gstrings_stats)
-#define CPSW_STATS_CH_LEN	ARRAY_SIZE(cpsw_gstrings_ch_stats)
-
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)
 #define napi_to_cpsw(napi)	container_of(napi, struct cpsw_common, napi)
 
@@ -424,5 +386,44 @@ struct addr_sync_ctx {
 int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 		     int ale_ageout, phys_addr_t desc_mem_phys,
 		     int descs_pool_size);
+void cpsw_split_res(struct cpsw_common *cpsw);
+int cpsw_fill_rx_channels(struct cpsw_priv *priv);
+void cpsw_intr_enable(struct cpsw_common *cpsw);
+void cpsw_intr_disable(struct cpsw_common *cpsw);
+void cpsw_tx_handler(void *token, int len, int status);
+
+/* ethtool */
+u32 cpsw_get_msglevel(struct net_device *ndev);
+void cpsw_set_msglevel(struct net_device *ndev, u32 value);
+int cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal);
+int cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal);
+int cpsw_get_sset_count(struct net_device *ndev, int sset);
+void cpsw_get_strings(struct net_device *ndev, u32 stringset, u8 *data);
+void cpsw_get_ethtool_stats(struct net_device *ndev,
+			    struct ethtool_stats *stats, u64 *data);
+void cpsw_get_pauseparam(struct net_device *ndev,
+			 struct ethtool_pauseparam *pause);
+void cpsw_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol);
+int cpsw_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol);
+int cpsw_get_regs_len(struct net_device *ndev);
+void cpsw_get_regs(struct net_device *ndev, struct ethtool_regs *regs, void *p);
+int cpsw_ethtool_op_begin(struct net_device *ndev);
+void cpsw_ethtool_op_complete(struct net_device *ndev);
+void cpsw_get_channels(struct net_device *ndev, struct ethtool_channels *ch);
+int cpsw_get_link_ksettings(struct net_device *ndev,
+			    struct ethtool_link_ksettings *ecmd);
+int cpsw_set_link_ksettings(struct net_device *ndev,
+			    const struct ethtool_link_ksettings *ecmd);
+int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata);
+int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata);
+int cpsw_nway_reset(struct net_device *ndev);
+void cpsw_get_ringparam(struct net_device *ndev,
+			struct ethtool_ringparam *ering);
+int cpsw_set_ringparam(struct net_device *ndev,
+		       struct ethtool_ringparam *ering);
+int cpsw_set_channels_common(struct net_device *ndev,
+			     struct ethtool_channels *chs,
+			     cpdma_handler_fn rx_handler);
+int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info);
 
 #endif /* DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_ */
-- 
2.17.1
