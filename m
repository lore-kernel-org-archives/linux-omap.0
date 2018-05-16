From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: ethernet: ti: cpsw: disable mq feature for "AM33xx ES1.0" devices
Date: Thu, 17 May 2018 01:21:45 +0300
Message-ID: <20180516222145.26877-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The early versions of am33xx devices, related to ES1.0 SoC revision
have errata limiting mq support. That's the same errata as
commit 7da1160002f1 ("drivers: net: cpsw: add am335x errata workarround for
interrutps")

AM33xx Errata [1] Advisory 1.0.9
http://www.ti.com/lit/er/sprz360f/sprz360f.pdf

After additional investigation were found that drivers w/a is
propagated on all AM33xx SoCs and on DM814x. But the errata exists
only for ES1.0 of AM33xx family, limiting mq support for revisions
after ES1.0. So, disable mq support only for related SoCs and use
separate polls for revisions allowing mq.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 109 ++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 28d893b93d30..a7285dddfd29 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -36,6 +36,7 @@
 #include <linux/of_device.h>
 #include <linux/if_vlan.h>
 #include <linux/kmemleak.h>
+#include <linux/sys_soc.h>
 
 #include <linux/pinctrl/consumer.h>
 
@@ -957,7 +958,7 @@ static irqreturn_t cpsw_rx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
+static int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
 {
 	u32			ch_map;
 	int			num_tx, cur_budget, ch;
@@ -984,7 +985,21 @@ static int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
 	if (num_tx < budget) {
 		napi_complete(napi_tx);
 		writel(0xff, &cpsw->wr_regs->tx_en);
-		if (cpsw->quirk_irq && cpsw->tx_irq_disabled) {
+	}
+
+	return num_tx;
+}
+
+static int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
+{
+	struct cpsw_common *cpsw = napi_to_cpsw(napi_tx);
+	int num_tx;
+
+	num_tx = cpdma_chan_process(cpsw->txv[0].ch, budget);
+	if (num_tx < budget) {
+		napi_complete(napi_tx);
+		writel(0xff, &cpsw->wr_regs->tx_en);
+		if (cpsw->tx_irq_disabled) {
 			cpsw->tx_irq_disabled = false;
 			enable_irq(cpsw->irqs_table[1]);
 		}
@@ -993,7 +1008,7 @@ static int cpsw_tx_poll(struct napi_struct *napi_tx, int budget)
 	return num_tx;
 }
 
-static int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
+static int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget)
 {
 	u32			ch_map;
 	int			num_rx, cur_budget, ch;
@@ -1020,7 +1035,21 @@ static int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
 	if (num_rx < budget) {
 		napi_complete_done(napi_rx, num_rx);
 		writel(0xff, &cpsw->wr_regs->rx_en);
-		if (cpsw->quirk_irq && cpsw->rx_irq_disabled) {
+	}
+
+	return num_rx;
+}
+
+static int cpsw_rx_poll(struct napi_struct *napi_rx, int budget)
+{
+	struct cpsw_common *cpsw = napi_to_cpsw(napi_rx);
+	int num_rx;
+
+	num_rx = cpdma_chan_process(cpsw->rxv[0].ch, budget);
+	if (num_rx < budget) {
+		napi_complete_done(napi_rx, num_rx);
+		writel(0xff, &cpsw->wr_regs->rx_en);
+		if (cpsw->rx_irq_disabled) {
 			cpsw->rx_irq_disabled = false;
 			enable_irq(cpsw->irqs_table[0]);
 		}
@@ -2364,9 +2393,9 @@ static void cpsw_get_channels(struct net_device *ndev,
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
 
+	ch->max_rx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
+	ch->max_tx = cpsw->quirk_irq ? 1 : CPSW_MAX_QUEUES;
 	ch->max_combined = 0;
-	ch->max_rx = CPSW_MAX_QUEUES;
-	ch->max_tx = CPSW_MAX_QUEUES;
 	ch->max_other = 0;
 	ch->other_count = 0;
 	ch->rx_count = cpsw->rx_ch_num;
@@ -2377,6 +2406,11 @@ static void cpsw_get_channels(struct net_device *ndev,
 static int cpsw_check_ch_settings(struct cpsw_common *cpsw,
 				  struct ethtool_channels *ch)
 {
+	if (cpsw->quirk_irq) {
+		dev_err(cpsw->dev, "Maximum one tx/rx queue is allowed");
+		return -EOPNOTSUPP;
+	}
+
 	if (ch->combined_count)
 		return -EINVAL;
 
@@ -2917,44 +2951,20 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	return ret;
 }
 
-#define CPSW_QUIRK_IRQ		BIT(0)
-
-static const struct platform_device_id cpsw_devtype[] = {
-	{
-		/* keep it for existing comaptibles */
-		.name = "cpsw",
-		.driver_data = CPSW_QUIRK_IRQ,
-	}, {
-		.name = "am335x-cpsw",
-		.driver_data = CPSW_QUIRK_IRQ,
-	}, {
-		.name = "am4372-cpsw",
-		.driver_data = 0,
-	}, {
-		.name = "dra7-cpsw",
-		.driver_data = 0,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, cpsw_devtype);
-
-enum ti_cpsw_type {
-	CPSW = 0,
-	AM335X_CPSW,
-	AM4372_CPSW,
-	DRA7_CPSW,
-};
-
 static const struct of_device_id cpsw_of_mtable[] = {
-	{ .compatible = "ti,cpsw", .data = &cpsw_devtype[CPSW], },
-	{ .compatible = "ti,am335x-cpsw", .data = &cpsw_devtype[AM335X_CPSW], },
-	{ .compatible = "ti,am4372-cpsw", .data = &cpsw_devtype[AM4372_CPSW], },
-	{ .compatible = "ti,dra7-cpsw", .data = &cpsw_devtype[DRA7_CPSW], },
+	{ .compatible = "ti,cpsw"},
+	{ .compatible = "ti,am335x-cpsw"},
+	{ .compatible = "ti,am4372-cpsw"},
+	{ .compatible = "ti,dra7-cpsw"},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cpsw_of_mtable);
 
+static const struct soc_device_attribute cpsw_soc_devices[] = {
+	{ .family = "AM33xx", .revision = "ES1.0"},
+	{ /* sentinel */ }
+};
+
 static int cpsw_probe(struct platform_device *pdev)
 {
 	struct clk			*clk;
@@ -2966,9 +2976,9 @@ static int cpsw_probe(struct platform_device *pdev)
 	void __iomem			*ss_regs;
 	void __iomem			*cpts_regs;
 	struct resource			*res, *ss_res;
-	const struct of_device_id	*of_id;
 	struct gpio_descs		*mode;
 	u32 slave_offset, sliver_offset, slave_size;
+	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
 	int ret = 0, i;
 	int irq;
@@ -3141,6 +3151,10 @@ static int cpsw_probe(struct platform_device *pdev)
 		goto clean_dt_ret;
 	}
 
+	soc = soc_device_match(cpsw_soc_devices);
+	if (soc)
+		cpsw->quirk_irq = 1;
+
 	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
 	if (IS_ERR(cpsw->txv[0].ch)) {
 		dev_err(priv->dev, "error initializing tx dma channel\n");
@@ -3180,19 +3194,16 @@ static int cpsw_probe(struct platform_device *pdev)
 		goto clean_dma_ret;
 	}
 
-	of_id = of_match_device(cpsw_of_mtable, &pdev->dev);
-	if (of_id) {
-		pdev->id_entry = of_id->data;
-		if (pdev->id_entry->driver_data)
-			cpsw->quirk_irq = true;
-	}
-
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-	netif_napi_add(ndev, &cpsw->napi_rx, cpsw_rx_poll, CPSW_POLL_WEIGHT);
-	netif_tx_napi_add(ndev, &cpsw->napi_tx, cpsw_tx_poll, CPSW_POLL_WEIGHT);
+	netif_napi_add(ndev, &cpsw->napi_rx,
+		       cpsw->quirk_irq ? cpsw_rx_poll : cpsw_rx_mq_poll,
+		       CPSW_POLL_WEIGHT);
+	netif_tx_napi_add(ndev, &cpsw->napi_tx,
+			  cpsw->quirk_irq ? cpsw_tx_poll : cpsw_tx_mq_poll,
+			  CPSW_POLL_WEIGHT);
 	cpsw_split_res(ndev);
 
 	/* register the network device */
-- 
2.17.0
