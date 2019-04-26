From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 05/20] net: ethernet: ti: cpsw: use local var dev in probe
Date: Fri, 26 Apr 2019 20:12:27 +0300
Message-ID: <1556298762-8632-6-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use local variable struct device *dev in probe to simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
changes in v2:
 - fixed dev variable alignment

 drivers/net/ethernet/ti/cpsw.c | 65 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 13a339c64892..cd85bb7c4700 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3458,6 +3458,7 @@ static const struct soc_device_attribute cpsw_soc_devices[] = {
 
 static int cpsw_probe(struct platform_device *pdev)
 {
+	struct device			*dev = &pdev->dev;
 	struct clk			*clk;
 	struct cpsw_platform_data	*data;
 	struct net_device		*ndev;
@@ -3474,15 +3475,15 @@ static int cpsw_probe(struct platform_device *pdev)
 	int ret = 0, i, ch;
 	int irq;
 
-	cpsw = devm_kzalloc(&pdev->dev, sizeof(struct cpsw_common), GFP_KERNEL);
+	cpsw = devm_kzalloc(dev, sizeof(struct cpsw_common), GFP_KERNEL);
 	if (!cpsw)
 		return -ENOMEM;
 
-	cpsw->dev = &pdev->dev;
+	cpsw->dev = dev;
 
 	ndev = alloc_etherdev_mq(sizeof(struct cpsw_priv), CPSW_MAX_QUEUES);
 	if (!ndev) {
-		dev_err(&pdev->dev, "error allocating net_device\n");
+		dev_err(dev, "error allocating net_device\n");
 		return -ENOMEM;
 	}
 
@@ -3490,31 +3491,31 @@ static int cpsw_probe(struct platform_device *pdev)
 	priv = netdev_priv(ndev);
 	priv->cpsw = cpsw;
 	priv->ndev = ndev;
-	priv->dev  = &ndev->dev;
+	priv->dev  = dev;
 	priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 	cpsw->rx_packet_max = max(rx_packet_max, 128);
 
-	mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
+	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
 	if (IS_ERR(mode)) {
 		ret = PTR_ERR(mode);
-		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
+		dev_err(dev, "gpio request failed, ret %d\n", ret);
 		goto clean_ndev_ret;
 	}
 
 	/*
 	 * This may be required here for child devices.
 	 */
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	/* Select default pin state */
-	pinctrl_pm_select_default_state(&pdev->dev);
+	pinctrl_pm_select_default_state(dev);
 
 	/* Need to enable clocks with runtime PM api to access module
 	 * registers
 	 */
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_put_noidle(dev);
 		goto clean_runtime_disable_ret;
 	}
 
@@ -3528,15 +3529,15 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	if (is_valid_ether_addr(data->slave_data[0].mac_addr)) {
 		memcpy(priv->mac_addr, data->slave_data[0].mac_addr, ETH_ALEN);
-		dev_info(&pdev->dev, "Detected MACID = %pM\n", priv->mac_addr);
+		dev_info(dev, "Detected MACID = %pM\n", priv->mac_addr);
 	} else {
 		eth_random_addr(priv->mac_addr);
-		dev_info(&pdev->dev, "Random MACID = %pM\n", priv->mac_addr);
+		dev_info(dev, "Random MACID = %pM\n", priv->mac_addr);
 	}
 
 	memcpy(ndev->dev_addr, priv->mac_addr, ETH_ALEN);
 
-	cpsw->slaves = devm_kcalloc(&pdev->dev,
+	cpsw->slaves = devm_kcalloc(dev,
 				    data->slaves, sizeof(struct cpsw_slave),
 				    GFP_KERNEL);
 	if (!cpsw->slaves) {
@@ -3549,16 +3550,16 @@ static int cpsw_probe(struct platform_device *pdev)
 	cpsw->slaves[0].ndev = ndev;
 	priv->emac_port = 0;
 
-	clk = devm_clk_get(&pdev->dev, "fck");
+	clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(clk)) {
-		dev_err(priv->dev, "fck is not found\n");
+		dev_err(dev, "fck is not found\n");
 		ret = -ENODEV;
 		goto clean_dt_ret;
 	}
 	cpsw->bus_freq_mhz = clk_get_rate(clk) / 1000000;
 
 	ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ss_regs = devm_ioremap_resource(&pdev->dev, ss_res);
+	ss_regs = devm_ioremap_resource(dev, ss_res);
 	if (IS_ERR(ss_regs)) {
 		ret = PTR_ERR(ss_regs);
 		goto clean_dt_ret;
@@ -3568,7 +3569,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	cpsw->version = readl(&cpsw->regs->id_ver);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cpsw->wr_regs = devm_ioremap_resource(&pdev->dev, res);
+	cpsw->wr_regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cpsw->wr_regs)) {
 		ret = PTR_ERR(cpsw->wr_regs);
 		goto clean_dt_ret;
@@ -3606,7 +3607,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			(u32 __force) ss_res->start + CPSW2_BD_OFFSET;
 		break;
 	default:
-		dev_err(priv->dev, "unknown version 0x%08x\n", cpsw->version);
+		dev_err(dev, "unknown version 0x%08x\n", cpsw->version);
 		ret = -ENODEV;
 		goto clean_dt_ret;
 	}
@@ -3618,7 +3619,7 @@ static int cpsw_probe(struct platform_device *pdev)
 		sliver_offset += SLIVER_SIZE;
 	}
 
-	dma_params.dev		= &pdev->dev;
+	dma_params.dev		= dev;
 	dma_params.rxthresh	= dma_params.dmaregs + CPDMA_RXTHRESH;
 	dma_params.rxfree	= dma_params.dmaregs + CPDMA_RXFREE;
 	dma_params.rxhdp	= dma_params.txhdp + CPDMA_RXHDP;
@@ -3637,7 +3638,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	cpsw->dma = cpdma_ctlr_create(&dma_params);
 	if (!cpsw->dma) {
-		dev_err(priv->dev, "error initializing dma\n");
+		dev_err(dev, "error initializing dma\n");
 		ret = -ENOMEM;
 		goto clean_dt_ret;
 	}
@@ -3649,26 +3650,26 @@ static int cpsw_probe(struct platform_device *pdev)
 	ch = cpsw->quirk_irq ? 0 : 7;
 	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, ch, cpsw_tx_handler, 0);
 	if (IS_ERR(cpsw->txv[0].ch)) {
-		dev_err(priv->dev, "error initializing tx dma channel\n");
+		dev_err(dev, "error initializing tx dma channel\n");
 		ret = PTR_ERR(cpsw->txv[0].ch);
 		goto clean_dma_ret;
 	}
 
 	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
 	if (IS_ERR(cpsw->rxv[0].ch)) {
-		dev_err(priv->dev, "error initializing rx dma channel\n");
+		dev_err(dev, "error initializing rx dma channel\n");
 		ret = PTR_ERR(cpsw->rxv[0].ch);
 		goto clean_dma_ret;
 	}
 
-	ale_params.dev			= &pdev->dev;
+	ale_params.dev			= dev;
 	ale_params.ale_ageout		= ale_ageout;
 	ale_params.ale_entries		= data->ale_entries;
 	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
 
 	cpsw->ale = cpsw_ale_create(&ale_params);
 	if (!cpsw->ale) {
-		dev_err(priv->dev, "error initializing ale engine\n");
+		dev_err(dev, "error initializing ale engine\n");
 		ret = -ENODEV;
 		goto clean_dma_ret;
 	}
@@ -3681,7 +3682,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ndev->irq = platform_get_irq(pdev, 1);
 	if (ndev->irq < 0) {
-		dev_err(priv->dev, "error getting irq resource\n");
+		dev_err(dev, "error getting irq resource\n");
 		ret = ndev->irq;
 		goto clean_dma_ret;
 	}
@@ -3699,10 +3700,10 @@ static int cpsw_probe(struct platform_device *pdev)
 	cpsw_split_res(cpsw);
 
 	/* register the network device */
-	SET_NETDEV_DEV(ndev, &pdev->dev);
+	SET_NETDEV_DEV(ndev, dev);
 	ret = register_netdev(ndev);
 	if (ret) {
-		dev_err(priv->dev, "error registering net device\n");
+		dev_err(dev, "error registering net device\n");
 		ret = -ENODEV;
 		goto clean_dma_ret;
 	}
@@ -3731,10 +3732,10 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	cpsw->irqs_table[0] = irq;
-	ret = devm_request_irq(&pdev->dev, irq, cpsw_rx_interrupt,
-			       0, dev_name(&pdev->dev), cpsw);
+	ret = devm_request_irq(dev, irq, cpsw_rx_interrupt,
+			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
-		dev_err(priv->dev, "error attaching irq (%d)\n", ret);
+		dev_err(dev, "error attaching irq (%d)\n", ret);
 		goto clean_dma_ret;
 	}
 
@@ -3746,10 +3747,10 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	cpsw->irqs_table[1] = irq;
-	ret = devm_request_irq(&pdev->dev, irq, cpsw_tx_interrupt,
+	ret = devm_request_irq(dev, irq, cpsw_tx_interrupt,
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
-		dev_err(priv->dev, "error attaching irq (%d)\n", ret);
+		dev_err(dev, "error attaching irq (%d)\n", ret);
 		goto clean_dma_ret;
 	}
 
-- 
2.17.1
