From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 02/11] net: ethernet: ti: cpsw: move set of common functions in cpsw_priv
Date: Thu, 25 Apr 2019 01:24:18 +0300
Message-ID: <1556144667-27997-3-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

As a preparatory patch to add support for a switchdev based cpsw driver,
move common functions to cpsw-priv.c so that they can be used across both
drivers.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c      | 552 ----------------------------
 drivers/net/ethernet/ti/cpsw_priv.c | 552 ++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_priv.h |  13 +-
 3 files changed, 564 insertions(+), 553 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ca6475c920db..2998a45e01e8 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -305,44 +305,6 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 			       cpsw_del_mc_addr);
 }
 
-void cpsw_intr_enable(struct cpsw_common *cpsw)
-{
-	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
-	writel_relaxed(0xFF, &cpsw->wr_regs->rx_en);
-
-	cpdma_ctlr_int_ctrl(cpsw->dma, true);
-	return;
-}
-
-void cpsw_intr_disable(struct cpsw_common *cpsw)
-{
-	writel_relaxed(0, &cpsw->wr_regs->tx_en);
-	writel_relaxed(0, &cpsw->wr_regs->rx_en);
-
-	cpdma_ctlr_int_ctrl(cpsw->dma, false);
-	return;
-}
-
-void cpsw_tx_handler(void *token, int len, int status)
-{
-	struct netdev_queue	*txq;
-	struct sk_buff		*skb = token;
-	struct net_device	*ndev = skb->dev;
-	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
-
-	/* Check whether the queue is stopped due to stalled tx dma, if the
-	 * queue is stopped then start the queue as we have free desc for tx
-	 */
-	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
-	if (unlikely(netif_tx_queue_stopped(txq)))
-		netif_tx_wake_queue(txq);
-
-	cpts_tx_timestamp(cpsw->cpts, skb);
-	ndev->stats.tx_packets++;
-	ndev->stats.tx_bytes += len;
-	dev_kfree_skb_any(skb);
-}
-
 static void cpsw_rx_vlan_encap(struct sk_buff *skb)
 {
 	struct cpsw_priv *priv = netdev_priv(skb->dev);
@@ -455,242 +417,6 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		dev_kfree_skb_any(new_skb);
 }
 
-void cpsw_split_res(struct cpsw_common *cpsw)
-{
-	u32 consumed_rate = 0, bigest_rate = 0;
-	struct cpsw_vector *txv = cpsw->txv;
-	int i, ch_weight, rlim_ch_num = 0;
-	int budget, bigest_rate_ch = 0;
-	u32 ch_rate, max_rate;
-	int ch_budget = 0;
-
-	for (i = 0; i < cpsw->tx_ch_num; i++) {
-		ch_rate = cpdma_chan_get_rate(txv[i].ch);
-		if (!ch_rate)
-			continue;
-
-		rlim_ch_num++;
-		consumed_rate += ch_rate;
-	}
-
-	if (cpsw->tx_ch_num == rlim_ch_num) {
-		max_rate = consumed_rate;
-	} else if (!rlim_ch_num) {
-		ch_budget = CPSW_POLL_WEIGHT / cpsw->tx_ch_num;
-		bigest_rate = 0;
-		max_rate = consumed_rate;
-	} else {
-		max_rate = cpsw->speed * 1000;
-
-		/* if max_rate is less then expected due to reduced link speed,
-		 * split proportionally according next potential max speed
-		 */
-		if (max_rate < consumed_rate)
-			max_rate *= 10;
-
-		if (max_rate < consumed_rate)
-			max_rate *= 10;
-
-		ch_budget = (consumed_rate * CPSW_POLL_WEIGHT) / max_rate;
-		ch_budget = (CPSW_POLL_WEIGHT - ch_budget) /
-			    (cpsw->tx_ch_num - rlim_ch_num);
-		bigest_rate = (max_rate - consumed_rate) /
-			      (cpsw->tx_ch_num - rlim_ch_num);
-	}
-
-	/* split tx weight/budget */
-	budget = CPSW_POLL_WEIGHT;
-	for (i = 0; i < cpsw->tx_ch_num; i++) {
-		ch_rate = cpdma_chan_get_rate(txv[i].ch);
-		if (ch_rate) {
-			txv[i].budget = (ch_rate * CPSW_POLL_WEIGHT) / max_rate;
-			if (!txv[i].budget)
-				txv[i].budget++;
-			if (ch_rate > bigest_rate) {
-				bigest_rate_ch = i;
-				bigest_rate = ch_rate;
-			}
-
-			ch_weight = (ch_rate * 100) / max_rate;
-			if (!ch_weight)
-				ch_weight++;
-			cpdma_chan_set_weight(cpsw->txv[i].ch, ch_weight);
-		} else {
-			txv[i].budget = ch_budget;
-			if (!bigest_rate_ch)
-				bigest_rate_ch = i;
-			cpdma_chan_set_weight(cpsw->txv[i].ch, 0);
-		}
-
-		budget -= txv[i].budget;
-	}
-
-	if (budget)
-		txv[bigest_rate_ch].budget += budget;
-
-	/* split rx budget */
-	budget = CPSW_POLL_WEIGHT;
-	ch_budget = budget / cpsw->rx_ch_num;
-	for (i = 0; i < cpsw->rx_ch_num; i++) {
-		cpsw->rxv[i].budget = ch_budget;
-		budget -= ch_budget;
-	}
-
-	if (budget)
-		cpsw->rxv[0].budget += budget;
-}
-
-static irqreturn_t cpsw_tx_interrupt(int irq, void *dev_id)
-{
-	struct cpsw_common *cpsw = dev_id;
-
-	writel(0, &cpsw->wr_regs->tx_en);
-	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_TX);
-
-	if (cpsw->quirk_irq) {
-		disable_irq_nosync(cpsw->irqs_table[1]);
-		cpsw->tx_irq_disabled = true;
-	}
-
-	napi_schedule(&cpsw->napi_tx);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t cpsw_rx_interrupt(int irq, void *dev_id)
-{
-	struct cpsw_common *cpsw = dev_id;
-
-	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_RX);
-	writel(0, &cpsw->wr_regs->rx_en);
-
-	if (cpsw->quirk_irq) {
-		disable_irq_nosync(cpsw->irqs_table[0]);
-		cpsw->rx_irq_disabled = true;
-	}
-
-	napi_schedule(&cpsw->napi_rx);
-	return IRQ_HANDLED;
-}
-
-static int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
-{
-	u32			ch_map;
-	int			num_tx, cur_budget, ch;
-	struct cpsw_common	*cpsw = napi_to_cpsw(napi_tx);
-	struct cpsw_vector	*txv;
-
-	/* process every unprocessed channel */
-	ch_map = cpdma_ctrl_txchs_state(cpsw->dma);
-	for (ch = 0, num_tx = 0; ch_map & 0xff; ch_map <<= 1, ch++) {
-		if (!(ch_map & 0x80))
-			continue;
-
-		txv = &cpsw->txv[ch];
-		if (unlikely(txv->budget > budget - num_tx))
-			cur_budget = budget - num_tx;
-		else
-			cur_budget = txv->budget;
-
-		num_tx += cpdma_chan_process(txv->ch, cur_budget);
-		if (num_tx >= budget)
-			break;
-	}
-
-	if (num_tx < budget) {
-		napi_complete(napi_tx);
-		writel(0xff, &cpsw->wr_regs->tx_en);
-	}
-
-	return num_tx;
-}
-
-static int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
-{
-	struct cpsw_common *cpsw = napi_to_cpsw(napi_tx);
-	int num_tx;
-
-	num_tx = cpdma_chan_process(cpsw->txv[0].ch, budget);
-	if (num_tx < budget) {
-		napi_complete(napi_tx);
-		writel(0xff, &cpsw->wr_regs->tx_en);
-		if (cpsw->tx_irq_disabled) {
-			cpsw->tx_irq_disabled = false;
-			enable_irq(cpsw->irqs_table[1]);
-		}
-	}
-
-	return num_tx;
-}
-
-static int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget)
-{
-	u32			ch_map;
-	int			num_rx, cur_budget, ch;
-	struct cpsw_common	*cpsw = napi_to_cpsw(napi_rx);
-	struct cpsw_vector	*rxv;
-
-	/* process every unprocessed channel */
-	ch_map = cpdma_ctrl_rxchs_state(cpsw->dma);
-	for (ch = 0, num_rx = 0; ch_map; ch_map >>= 1, ch++) {
-		if (!(ch_map & 0x01))
-			continue;
-
-		rxv = &cpsw->rxv[ch];
-		if (unlikely(rxv->budget > budget - num_rx))
-			cur_budget = budget - num_rx;
-		else
-			cur_budget = rxv->budget;
-
-		num_rx += cpdma_chan_process(rxv->ch, cur_budget);
-		if (num_rx >= budget)
-			break;
-	}
-
-	if (num_rx < budget) {
-		napi_complete_done(napi_rx, num_rx);
-		writel(0xff, &cpsw->wr_regs->rx_en);
-	}
-
-	return num_rx;
-}
-
-static int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
-{
-	struct cpsw_common *cpsw = napi_to_cpsw(napi_rx);
-	int num_rx;
-
-	num_rx = cpdma_chan_process(cpsw->rxv[0].ch, budget);
-	if (num_rx < budget) {
-		napi_complete_done(napi_rx, num_rx);
-		writel(0xff, &cpsw->wr_regs->rx_en);
-		if (cpsw->rx_irq_disabled) {
-			cpsw->rx_irq_disabled = false;
-			enable_irq(cpsw->irqs_table[0]);
-		}
-	}
-
-	return num_rx;
-}
-
-static inline void soft_reset(const char *module, void __iomem *reg)
-{
-	unsigned long timeout = jiffies + HZ;
-
-	writel_relaxed(1, reg);
-	do {
-		cpu_relax();
-	} while ((readl_relaxed(reg) & 1) && time_after(timeout, jiffies));
-
-	WARN(readl_relaxed(reg) & 1, "failed to soft-reset %s\n", module);
-}
-
-static void cpsw_set_slave_mac(struct cpsw_slave *slave,
-			       struct cpsw_priv *priv)
-{
-	slave_write(slave, mac_hi(priv->mac_addr), SA_HI);
-	slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
-}
-
 static bool cpsw_shp_is_off(struct cpsw_priv *priv)
 {
 	struct cpsw_common *cpsw = priv->cpsw;
@@ -788,44 +514,6 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 	slave->mac_control = mac_control;
 }
 
-static int cpsw_get_common_speed(struct cpsw_common *cpsw)
-{
-	int i, speed;
-
-	for (i = 0, speed = 0; i < cpsw->data.slaves; i++)
-		if (cpsw->slaves[i].phy && cpsw->slaves[i].phy->link)
-			speed += cpsw->slaves[i].phy->speed;
-
-	return speed;
-}
-
-static int cpsw_need_resplit(struct cpsw_common *cpsw)
-{
-	int i, rlim_ch_num;
-	int speed, ch_rate;
-
-	/* re-split resources only in case speed was changed */
-	speed = cpsw_get_common_speed(cpsw);
-	if (speed == cpsw->speed || !speed)
-		return 0;
-
-	cpsw->speed = speed;
-
-	for (i = 0, rlim_ch_num = 0; i < cpsw->tx_ch_num; i++) {
-		ch_rate = cpdma_chan_get_rate(cpsw->txv[i].ch);
-		if (!ch_rate)
-			break;
-
-		rlim_ch_num++;
-	}
-
-	/* cases not dependent on speed */
-	if (!rlim_ch_num || rlim_ch_num == cpsw->tx_ch_num)
-		return 0;
-
-	return 1;
-}
-
 static void cpsw_adjust_link(struct net_device *ndev)
 {
 	struct cpsw_priv	*priv = netdev_priv(ndev);
@@ -1018,45 +706,6 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	}
 }
 
-int cpsw_fill_rx_channels(struct cpsw_priv *priv)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-	struct sk_buff *skb;
-	int ch_buf_num;
-	int ch, i, ret;
-
-	for (ch = 0; ch < cpsw->rx_ch_num; ch++) {
-		ch_buf_num = cpdma_chan_get_rx_buf_num(cpsw->rxv[ch].ch);
-		for (i = 0; i < ch_buf_num; i++) {
-			skb = __netdev_alloc_skb_ip_align(priv->ndev,
-							  cpsw->rx_packet_max,
-							  GFP_KERNEL);
-			if (!skb) {
-				cpsw_err(priv, ifup, "cannot allocate skb\n");
-				return -ENOMEM;
-			}
-
-			skb_set_queue_mapping(skb, ch);
-			ret = cpdma_chan_submit(cpsw->rxv[ch].ch, skb,
-						skb->data, skb_tailroom(skb),
-						0);
-			if (ret < 0) {
-				cpsw_err(priv, ifup,
-					 "cannot submit skb to channel %d rx, error %d\n",
-					 ch, ret);
-				kfree_skb(skb);
-				return ret;
-			}
-			kmemleak_not_leak(skb);
-		}
-
-		cpsw_info(priv, ifup, "ch %d rx, submitted %d descriptors\n",
-			  ch, ch_buf_num);
-	}
-
-	return 0;
-}
-
 static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
 {
 	u32 slave_port;
@@ -1505,207 +1154,6 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_BUSY;
 }
 
-#if IS_ENABLED(CONFIG_TI_CPTS)
-
-static void cpsw_hwtstamp_v1(struct cpsw_priv *priv)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave = &cpsw->slaves[cpsw->data.active_slave];
-	u32 ts_en, seq_id;
-
-	if (!priv->tx_ts_enabled && !priv->rx_ts_enabled) {
-		slave_write(slave, 0, CPSW1_TS_CTL);
-		return;
-	}
-
-	seq_id = (30 << CPSW_V1_SEQ_ID_OFS_SHIFT) | ETH_P_1588;
-	ts_en = EVENT_MSG_BITS << CPSW_V1_MSG_TYPE_OFS;
-
-	if (priv->tx_ts_enabled)
-		ts_en |= CPSW_V1_TS_TX_EN;
-
-	if (priv->rx_ts_enabled)
-		ts_en |= CPSW_V1_TS_RX_EN;
-
-	slave_write(slave, ts_en, CPSW1_TS_CTL);
-	slave_write(slave, seq_id, CPSW1_TS_SEQ_LTYPE);
-}
-
-static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
-{
-	struct cpsw_slave *slave;
-	struct cpsw_common *cpsw = priv->cpsw;
-	u32 ctrl, mtype;
-
-	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
-
-	ctrl = slave_read(slave, CPSW2_CONTROL);
-	switch (cpsw->version) {
-	case CPSW_VERSION_2:
-		ctrl &= ~CTRL_V2_ALL_TS_MASK;
-
-		if (priv->tx_ts_enabled)
-			ctrl |= CTRL_V2_TX_TS_BITS;
-
-		if (priv->rx_ts_enabled)
-			ctrl |= CTRL_V2_RX_TS_BITS;
-		break;
-	case CPSW_VERSION_3:
-	default:
-		ctrl &= ~CTRL_V3_ALL_TS_MASK;
-
-		if (priv->tx_ts_enabled)
-			ctrl |= CTRL_V3_TX_TS_BITS;
-
-		if (priv->rx_ts_enabled)
-			ctrl |= CTRL_V3_RX_TS_BITS;
-		break;
-	}
-
-	mtype = (30 << TS_SEQ_ID_OFFSET_SHIFT) | EVENT_MSG_BITS;
-
-	slave_write(slave, mtype, CPSW2_TS_SEQ_MTYPE);
-	slave_write(slave, ctrl, CPSW2_CONTROL);
-	writel_relaxed(ETH_P_1588, &cpsw->regs->ts_ltype);
-	writel_relaxed(ETH_P_8021Q, &cpsw->regs->vlan_ltype);
-}
-
-static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
-{
-	struct cpsw_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config cfg;
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	if (cpsw->version != CPSW_VERSION_1 &&
-	    cpsw->version != CPSW_VERSION_2 &&
-	    cpsw->version != CPSW_VERSION_3)
-		return -EOPNOTSUPP;
-
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
-	/* reserved for future extensions */
-	if (cfg.flags)
-		return -EINVAL;
-
-	if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
-		return -ERANGE;
-
-	switch (cfg.rx_filter) {
-	case HWTSTAMP_FILTER_NONE:
-		priv->rx_ts_enabled = 0;
-		break;
-	case HWTSTAMP_FILTER_ALL:
-	case HWTSTAMP_FILTER_NTP_ALL:
-		return -ERANGE;
-	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
-		break;
-	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-	case HWTSTAMP_FILTER_PTP_V2_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		break;
-	default:
-		return -ERANGE;
-	}
-
-	priv->tx_ts_enabled = cfg.tx_type == HWTSTAMP_TX_ON;
-
-	switch (cpsw->version) {
-	case CPSW_VERSION_1:
-		cpsw_hwtstamp_v1(priv);
-		break;
-	case CPSW_VERSION_2:
-	case CPSW_VERSION_3:
-		cpsw_hwtstamp_v2(priv);
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
-}
-
-static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
-{
-	struct cpsw_common *cpsw = ndev_to_cpsw(dev);
-	struct cpsw_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config cfg;
-
-	if (cpsw->version != CPSW_VERSION_1 &&
-	    cpsw->version != CPSW_VERSION_2 &&
-	    cpsw->version != CPSW_VERSION_3)
-		return -EOPNOTSUPP;
-
-	cfg.flags = 0;
-	cfg.tx_type = priv->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = priv->rx_ts_enabled;
-
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
-}
-#else
-static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
-{
-	return -EOPNOTSUPP;
-}
-#endif /*CONFIG_TI_CPTS*/
-
-static int cpsw_ndo_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
-{
-	struct cpsw_priv *priv = netdev_priv(dev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int slave_no = cpsw_slave_index(cpsw, priv);
-
-	if (!netif_running(dev))
-		return -EINVAL;
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return cpsw_hwtstamp_set(dev, req);
-	case SIOCGHWTSTAMP:
-		return cpsw_hwtstamp_get(dev, req);
-	}
-
-	if (!cpsw->slaves[slave_no].phy)
-		return -EOPNOTSUPP;
-	return phy_mii_ioctl(cpsw->slaves[slave_no].phy, req, cmd);
-}
-
-static void cpsw_ndo_tx_timeout(struct net_device *ndev)
-{
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int ch;
-
-	cpsw_err(priv, tx_err, "transmit timeout, restarting dma\n");
-	ndev->stats.tx_errors++;
-	cpsw_intr_disable(cpsw);
-	for (ch = 0; ch < cpsw->tx_ch_num; ch++) {
-		cpdma_chan_stop(cpsw->txv[ch].ch);
-		cpdma_chan_start(cpsw->txv[ch].ch);
-	}
-
-	cpsw_intr_enable(cpsw);
-	netif_trans_update(ndev);
-	netif_tx_wake_all_queues(ndev);
-}
-
 static int cpsw_ndo_set_mac_address(struct net_device *ndev, void *p)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 468746a7593e..a53547e9c04d 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -7,18 +7,388 @@
 
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 
+#include "cpsw.h"
 #include "cpts.h"
 #include "cpsw_ale.h"
 #include "cpsw_priv.h"
 #include "cpsw_sl.h"
 #include "davinci_cpdma.h"
 
+void cpsw_intr_enable(struct cpsw_common *cpsw)
+{
+	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
+	writel_relaxed(0xFF, &cpsw->wr_regs->rx_en);
+
+	cpdma_ctlr_int_ctrl(cpsw->dma, true);
+}
+
+void cpsw_intr_disable(struct cpsw_common *cpsw)
+{
+	writel_relaxed(0, &cpsw->wr_regs->tx_en);
+	writel_relaxed(0, &cpsw->wr_regs->rx_en);
+
+	cpdma_ctlr_int_ctrl(cpsw->dma, false);
+}
+
+void cpsw_tx_handler(void *token, int len, int status)
+{
+	struct netdev_queue	*txq;
+	struct sk_buff		*skb = token;
+	struct net_device	*ndev = skb->dev;
+	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
+
+	/* Check whether the queue is stopped due to stalled tx dma, if the
+	 * queue is stopped then start the queue as we have free desc for tx
+	 */
+	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
+	if (unlikely(netif_tx_queue_stopped(txq)))
+		netif_tx_wake_queue(txq);
+
+	cpts_tx_timestamp(cpsw->cpts, skb);
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += len;
+	dev_kfree_skb_any(skb);
+}
+
+irqreturn_t cpsw_tx_interrupt(int irq, void *dev_id)
+{
+	struct cpsw_common *cpsw = dev_id;
+
+	writel(0, &cpsw->wr_regs->tx_en);
+	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_TX);
+
+	if (cpsw->quirk_irq) {
+		disable_irq_nosync(cpsw->irqs_table[1]);
+		cpsw->tx_irq_disabled = true;
+	}
+
+	napi_schedule(&cpsw->napi_tx);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t cpsw_rx_interrupt(int irq, void *dev_id)
+{
+	struct cpsw_common *cpsw = dev_id;
+
+	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_RX);
+	writel(0, &cpsw->wr_regs->rx_en);
+
+	if (cpsw->quirk_irq) {
+		disable_irq_nosync(cpsw->irqs_table[0]);
+		cpsw->rx_irq_disabled = true;
+	}
+
+	napi_schedule(&cpsw->napi_rx);
+	return IRQ_HANDLED;
+}
+
+int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
+{
+	u32			ch_map;
+	int			num_tx, cur_budget, ch;
+	struct cpsw_common	*cpsw = napi_to_cpsw(napi_tx);
+	struct cpsw_vector	*txv;
+
+	/* process every unprocessed channel */
+	ch_map = cpdma_ctrl_txchs_state(cpsw->dma);
+	for (ch = 0, num_tx = 0; ch_map & 0xff; ch_map <<= 1, ch++) {
+		if (!(ch_map & 0x80))
+			continue;
+
+		txv = &cpsw->txv[ch];
+		if (unlikely(txv->budget > budget - num_tx))
+			cur_budget = budget - num_tx;
+		else
+			cur_budget = txv->budget;
+
+		num_tx += cpdma_chan_process(txv->ch, cur_budget);
+		if (num_tx >= budget)
+			break;
+	}
+
+	if (num_tx < budget) {
+		napi_complete(napi_tx);
+		writel(0xff, &cpsw->wr_regs->tx_en);
+	}
+
+	return num_tx;
+}
+
+int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
+{
+	struct cpsw_common *cpsw = napi_to_cpsw(napi_tx);
+	int num_tx;
+
+	num_tx = cpdma_chan_process(cpsw->txv[0].ch, budget);
+	if (num_tx < budget) {
+		napi_complete(napi_tx);
+		writel(0xff, &cpsw->wr_regs->tx_en);
+		if (cpsw->tx_irq_disabled) {
+			cpsw->tx_irq_disabled = false;
+			enable_irq(cpsw->irqs_table[1]);
+		}
+	}
+
+	return num_tx;
+}
+
+int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget)
+{
+	u32			ch_map;
+	int			num_rx, cur_budget, ch;
+	struct cpsw_common	*cpsw = napi_to_cpsw(napi_rx);
+	struct cpsw_vector	*rxv;
+
+	/* process every unprocessed channel */
+	ch_map = cpdma_ctrl_rxchs_state(cpsw->dma);
+	for (ch = 0, num_rx = 0; ch_map; ch_map >>= 1, ch++) {
+		if (!(ch_map & 0x01))
+			continue;
+
+		rxv = &cpsw->rxv[ch];
+		if (unlikely(rxv->budget > budget - num_rx))
+			cur_budget = budget - num_rx;
+		else
+			cur_budget = rxv->budget;
+
+		num_rx += cpdma_chan_process(rxv->ch, cur_budget);
+		if (num_rx >= budget)
+			break;
+	}
+
+	if (num_rx < budget) {
+		napi_complete_done(napi_rx, num_rx);
+		writel(0xff, &cpsw->wr_regs->rx_en);
+	}
+
+	return num_rx;
+}
+
+int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
+{
+	struct cpsw_common *cpsw = napi_to_cpsw(napi_rx);
+	int num_rx;
+
+	num_rx = cpdma_chan_process(cpsw->rxv[0].ch, budget);
+	if (num_rx < budget) {
+		napi_complete_done(napi_rx, num_rx);
+		writel(0xff, &cpsw->wr_regs->rx_en);
+		if (cpsw->rx_irq_disabled) {
+			cpsw->rx_irq_disabled = false;
+			enable_irq(cpsw->irqs_table[0]);
+		}
+	}
+
+	return num_rx;
+}
+
+void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	slave_write(slave, mac_hi(priv->mac_addr), SA_HI);
+	slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
+}
+
+void soft_reset(const char *module, void __iomem *reg)
+{
+	unsigned long timeout = jiffies + HZ;
+
+	writel_relaxed(1, reg);
+	do {
+		cpu_relax();
+	} while ((readl_relaxed(reg) & 1) && time_after(timeout, jiffies));
+
+	WARN(readl_relaxed(reg) & 1, "failed to soft-reset %s\n", module);
+}
+
+void cpsw_ndo_tx_timeout(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ch;
+
+	cpsw_err(priv, tx_err, "transmit timeout, restarting dma\n");
+	ndev->stats.tx_errors++;
+	cpsw_intr_disable(cpsw);
+	for (ch = 0; ch < cpsw->tx_ch_num; ch++) {
+		cpdma_chan_stop(cpsw->txv[ch].ch);
+		cpdma_chan_start(cpsw->txv[ch].ch);
+	}
+
+	cpsw_intr_enable(cpsw);
+	netif_trans_update(ndev);
+	netif_tx_wake_all_queues(ndev);
+}
+
+int cpsw_fill_rx_channels(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct sk_buff *skb;
+	int ch_buf_num;
+	int ch, i, ret;
+
+	for (ch = 0; ch < cpsw->rx_ch_num; ch++) {
+		ch_buf_num = cpdma_chan_get_rx_buf_num(cpsw->rxv[ch].ch);
+		for (i = 0; i < ch_buf_num; i++) {
+			skb = __netdev_alloc_skb_ip_align(priv->ndev,
+							  cpsw->rx_packet_max,
+							  GFP_KERNEL);
+			if (!skb) {
+				cpsw_err(priv, ifup, "cannot allocate skb\n");
+				return -ENOMEM;
+			}
+
+			skb_set_queue_mapping(skb, ch);
+			ret = cpdma_chan_submit(cpsw->rxv[ch].ch, skb,
+						skb->data, skb_tailroom(skb),
+						0);
+			if (ret < 0) {
+				cpsw_err(priv, ifup,
+					 "cannot submit skb to channel %d rx, error %d\n",
+					 ch, ret);
+				kfree_skb(skb);
+				return ret;
+			}
+			kmemleak_not_leak(skb);
+		}
+
+		cpsw_info(priv, ifup, "ch %d rx, submitted %d descriptors\n",
+			  ch, ch_buf_num);
+	}
+
+	return 0;
+}
+
+static int cpsw_get_common_speed(struct cpsw_common *cpsw)
+{
+	int i, speed;
+
+	for (i = 0, speed = 0; i < cpsw->data.slaves; i++)
+		if (cpsw->slaves[i].phy && cpsw->slaves[i].phy->link)
+			speed += cpsw->slaves[i].phy->speed;
+
+	return speed;
+}
+
+int cpsw_need_resplit(struct cpsw_common *cpsw)
+{
+	int i, rlim_ch_num;
+	int speed, ch_rate;
+
+	/* re-split resources only in case speed was changed */
+	speed = cpsw_get_common_speed(cpsw);
+	if (speed == cpsw->speed || !speed)
+		return 0;
+
+	cpsw->speed = speed;
+
+	for (i = 0, rlim_ch_num = 0; i < cpsw->tx_ch_num; i++) {
+		ch_rate = cpdma_chan_get_rate(cpsw->txv[i].ch);
+		if (!ch_rate)
+			break;
+
+		rlim_ch_num++;
+	}
+
+	/* cases not dependent on speed */
+	if (!rlim_ch_num || rlim_ch_num == cpsw->tx_ch_num)
+		return 0;
+
+	return 1;
+}
+
+void cpsw_split_res(struct cpsw_common *cpsw)
+{
+	u32 consumed_rate = 0, bigest_rate = 0;
+	struct cpsw_vector *txv = cpsw->txv;
+	int i, ch_weight, rlim_ch_num = 0;
+	int budget, bigest_rate_ch = 0;
+	u32 ch_rate, max_rate;
+	int ch_budget = 0;
+
+	for (i = 0; i < cpsw->tx_ch_num; i++) {
+		ch_rate = cpdma_chan_get_rate(txv[i].ch);
+		if (!ch_rate)
+			continue;
+
+		rlim_ch_num++;
+		consumed_rate += ch_rate;
+	}
+
+	if (cpsw->tx_ch_num == rlim_ch_num) {
+		max_rate = consumed_rate;
+	} else if (!rlim_ch_num) {
+		ch_budget = CPSW_POLL_WEIGHT / cpsw->tx_ch_num;
+		bigest_rate = 0;
+		max_rate = consumed_rate;
+	} else {
+		max_rate = cpsw->speed * 1000;
+
+		/* if max_rate is less then expected due to reduced link speed,
+		 * split proportionally according next potential max speed
+		 */
+		if (max_rate < consumed_rate)
+			max_rate *= 10;
+
+		if (max_rate < consumed_rate)
+			max_rate *= 10;
+
+		ch_budget = (consumed_rate * CPSW_POLL_WEIGHT) / max_rate;
+		ch_budget = (CPSW_POLL_WEIGHT - ch_budget) /
+			    (cpsw->tx_ch_num - rlim_ch_num);
+		bigest_rate = (max_rate - consumed_rate) /
+			      (cpsw->tx_ch_num - rlim_ch_num);
+	}
+
+	/* split tx weight/budget */
+	budget = CPSW_POLL_WEIGHT;
+	for (i = 0; i < cpsw->tx_ch_num; i++) {
+		ch_rate = cpdma_chan_get_rate(txv[i].ch);
+		if (ch_rate) {
+			txv[i].budget = (ch_rate * CPSW_POLL_WEIGHT) / max_rate;
+			if (!txv[i].budget)
+				txv[i].budget++;
+			if (ch_rate > bigest_rate) {
+				bigest_rate_ch = i;
+				bigest_rate = ch_rate;
+			}
+
+			ch_weight = (ch_rate * 100) / max_rate;
+			if (!ch_weight)
+				ch_weight++;
+			cpdma_chan_set_weight(cpsw->txv[i].ch, ch_weight);
+		} else {
+			txv[i].budget = ch_budget;
+			if (!bigest_rate_ch)
+				bigest_rate_ch = i;
+			cpdma_chan_set_weight(cpsw->txv[i].ch, 0);
+		}
+
+		budget -= txv[i].budget;
+	}
+
+	if (budget)
+		txv[bigest_rate_ch].budget += budget;
+
+	/* split rx budget */
+	budget = CPSW_POLL_WEIGHT;
+	ch_budget = budget / cpsw->rx_ch_num;
+	for (i = 0; i < cpsw->rx_ch_num; i++) {
+		cpsw->rxv[i].budget = ch_budget;
+		budget -= ch_budget;
+	}
+
+	if (budget)
+		cpsw->rxv[0].budget += budget;
+}
+
 int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 		     int ale_ageout, u32 desc_mem_phys, int descs_pool_size)
 {
@@ -129,3 +499,185 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 
 	return ret;
 }
+
+#if IS_ENABLED(CONFIG_TI_CPTS)
+
+static void cpsw_hwtstamp_v1(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	u32 ts_en, seq_id;
+
+	if (!priv->tx_ts_enabled && !priv->rx_ts_enabled) {
+		slave_write(slave, 0, CPSW1_TS_CTL);
+		return;
+	}
+
+	seq_id = (30 << CPSW_V1_SEQ_ID_OFS_SHIFT) | ETH_P_1588;
+	ts_en = EVENT_MSG_BITS << CPSW_V1_MSG_TYPE_OFS;
+
+	if (priv->tx_ts_enabled)
+		ts_en |= CPSW_V1_TS_TX_EN;
+
+	if (priv->rx_ts_enabled)
+		ts_en |= CPSW_V1_TS_RX_EN;
+
+	slave_write(slave, ts_en, CPSW1_TS_CTL);
+	slave_write(slave, seq_id, CPSW1_TS_SEQ_LTYPE);
+}
+
+static void cpsw_hwtstamp_v2(struct cpsw_priv *priv)
+{
+	struct cpsw_slave *slave;
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 ctrl, mtype;
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+
+	ctrl = slave_read(slave, CPSW2_CONTROL);
+	switch (cpsw->version) {
+	case CPSW_VERSION_2:
+		ctrl &= ~CTRL_V2_ALL_TS_MASK;
+
+		if (priv->tx_ts_enabled)
+			ctrl |= CTRL_V2_TX_TS_BITS;
+
+		if (priv->rx_ts_enabled)
+			ctrl |= CTRL_V2_RX_TS_BITS;
+		break;
+	case CPSW_VERSION_3:
+	default:
+		ctrl &= ~CTRL_V3_ALL_TS_MASK;
+
+		if (priv->tx_ts_enabled)
+			ctrl |= CTRL_V3_TX_TS_BITS;
+
+		if (priv->rx_ts_enabled)
+			ctrl |= CTRL_V3_RX_TS_BITS;
+		break;
+	}
+
+	mtype = (30 << TS_SEQ_ID_OFFSET_SHIFT) | EVENT_MSG_BITS;
+
+	slave_write(slave, mtype, CPSW2_TS_SEQ_MTYPE);
+	slave_write(slave, ctrl, CPSW2_CONTROL);
+	writel_relaxed(ETH_P_1588, &cpsw->regs->ts_ltype);
+	writel_relaxed(ETH_P_8021Q, &cpsw->regs->vlan_ltype);
+}
+
+static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+{
+	struct cpsw_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config cfg;
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	if (cpsw->version != CPSW_VERSION_1 &&
+	    cpsw->version != CPSW_VERSION_2 &&
+	    cpsw->version != CPSW_VERSION_3)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (cfg.flags)
+		return -EINVAL;
+
+	if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
+		return -ERANGE;
+
+	switch (cfg.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		priv->rx_ts_enabled = 0;
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_NTP_ALL:
+		return -ERANGE;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		priv->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	priv->tx_ts_enabled = cfg.tx_type == HWTSTAMP_TX_ON;
+
+	switch (cpsw->version) {
+	case CPSW_VERSION_1:
+		cpsw_hwtstamp_v1(priv);
+		break;
+	case CPSW_VERSION_2:
+	case CPSW_VERSION_3:
+		cpsw_hwtstamp_v2(priv);
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+}
+
+static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(dev);
+	struct cpsw_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config cfg;
+
+	if (cpsw->version != CPSW_VERSION_1 &&
+	    cpsw->version != CPSW_VERSION_2 &&
+	    cpsw->version != CPSW_VERSION_3)
+		return -EOPNOTSUPP;
+
+	cfg.flags = 0;
+	cfg.tx_type = priv->tx_ts_enabled ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	cfg.rx_filter = priv->rx_ts_enabled;
+
+	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+}
+#else
+static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+{
+	return -EOPNOTSUPP;
+}
+#endif /*CONFIG_TI_CPTS*/
+
+int cpsw_ndo_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
+{
+	struct cpsw_priv *priv = netdev_priv(dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		return cpsw_hwtstamp_set(dev, req);
+	case SIOCGHWTSTAMP:
+		return cpsw_hwtstamp_get(dev, req);
+	}
+
+	if (!cpsw->slaves[slave_no].phy)
+		return -EOPNOTSUPP;
+	return phy_mii_ioctl(cpsw->slaves[slave_no].phy, req, cmd);
+}
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index c826fb2c78db..19d1da91862e 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -400,9 +400,20 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 		     int ale_ageout, u32 desc_mem_phys, int descs_pool_size);
 void cpsw_split_res(struct cpsw_common *cpsw);
 int cpsw_fill_rx_channels(struct cpsw_priv *priv);
+int cpsw_need_resplit(struct cpsw_common *cpsw);
+void soft_reset(const char *module, void __iomem *reg);
 void cpsw_intr_enable(struct cpsw_common *cpsw);
 void cpsw_intr_disable(struct cpsw_common *cpsw);
+void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv);
+void cpsw_ndo_tx_timeout(struct net_device *ndev);
 void cpsw_tx_handler(void *token, int len, int status);
+irqreturn_t cpsw_tx_interrupt(int irq, void *dev_id);
+irqreturn_t cpsw_rx_interrupt(int irq, void *dev_id);
+int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget);
+int cpsw_tx_poll(struct napi_struct *napi_tx, int budget);
+int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget);
+int cpsw_rx_poll(struct napi_struct *napi_rx, int budget);
+int cpsw_ndo_ioctl(struct net_device *dev, struct ifreq *req, int cmd);
 
 /* ethtool */
 u32 cpsw_get_msglevel(struct net_device *ndev);
@@ -432,7 +443,7 @@ int cpsw_nway_reset(struct net_device *ndev);
 void cpsw_get_ringparam(struct net_device *ndev,
 			struct ethtool_ringparam *ering);
 int cpsw_set_ringparam(struct net_device *ndev,
-		       struct ethtool_ringparam *ering);
+			struct ethtool_ringparam *ering);
 int cpsw_set_channels_common(struct net_device *ndev,
 			     struct ethtool_channels *chs,
 			     cpdma_handler_fn rx_handler);
-- 
2.17.1
