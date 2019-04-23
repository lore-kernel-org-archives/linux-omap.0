From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 14/19] net: ethernet: ti: cpsw: refactor probe to group common hw initialization
Date: Tue, 23 Apr 2019 16:09:05 +0300
Message-ID: <1556024950-20752-15-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Rework probe to group common hw initialization:
- group resources request at the beginning of the probe
- move net device initialization and registration at the end of the probe
- drop cpsw_slave_init
as preparation of refactoring of common hw initialization code to
separate function.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 213 +++++++++++++++------------------
 1 file changed, 97 insertions(+), 116 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index c497992f01f7..ddc11f940d66 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3181,19 +3181,6 @@ static const struct ethtool_ops cpsw_ethtool_ops = {
 	.set_ringparam = cpsw_set_ringparam,
 };
 
-static void cpsw_slave_init(struct cpsw_slave *slave, struct cpsw_common *cpsw,
-			    u32 slave_reg_ofs, u32 sliver_reg_ofs)
-{
-	void __iomem		*regs = cpsw->regs;
-	int			slave_num = slave->slave_num;
-	struct cpsw_slave_data	*data = cpsw->data.slave_data + slave_num;
-
-	slave->data	= data;
-	slave->regs	= regs + slave_reg_ofs;
-	slave->sliver	= regs + sliver_reg_ofs;
-	slave->port_vlan = data->dual_emac_res_vlan;
-}
-
 static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			 struct platform_device *pdev)
 {
@@ -3476,21 +3463,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	cpsw->dev = dev;
 
-	ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
-				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
-	if (!ndev) {
-		dev_err(dev, "error allocating net_device\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, ndev);
-	priv = netdev_priv(ndev);
-	priv->cpsw = cpsw;
-	priv->ndev = ndev;
-	priv->dev  = dev;
-	priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
-	cpsw->rx_packet_max = max(rx_packet_max, 128);
-
 	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
 	if (IS_ERR(mode)) {
 		ret = PTR_ERR(mode);
@@ -3498,6 +3470,37 @@ static int cpsw_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(mode);
+		dev_err(dev, "fck is not found %d\n", ret);
+		return ret;
+	}
+	cpsw->bus_freq_mhz = clk_get_rate(clk) / 1000000;
+
+	ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ss_regs = devm_ioremap_resource(dev, ss_res);
+	if (IS_ERR(ss_regs))
+		return PTR_ERR(ss_regs);
+	cpsw->regs = ss_regs;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cpsw->wr_regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cpsw->wr_regs))
+		return PTR_ERR(cpsw->wr_regs);
+
+	/* RX IRQ */
+	irq = platform_get_irq(pdev, 1);
+	if (irq < 0)
+		return irq;
+	cpsw->irqs_table[0] = irq;
+
+	/* TX IRQ */
+	irq = platform_get_irq(pdev, 2);
+	if (irq < 0)
+		return irq;
+	cpsw->irqs_table[1] = irq;
+
 	/*
 	 * This may be required here for child devices.
 	 */
@@ -3516,20 +3519,11 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (ret)
 		goto clean_dt_ret;
 
-	data = &cpsw->data;
-	cpsw->rx_ch_num = 1;
-	cpsw->tx_ch_num = 1;
-
-	if (is_valid_ether_addr(data->slave_data[0].mac_addr)) {
-		memcpy(priv->mac_addr, data->slave_data[0].mac_addr, ETH_ALEN);
-		dev_info(dev, "Detected MACID = %pM\n", priv->mac_addr);
-	} else {
-		eth_random_addr(priv->mac_addr);
-		dev_info(dev, "Random MACID = %pM\n", priv->mac_addr);
-	}
-
-	memcpy(ndev->dev_addr, priv->mac_addr, ETH_ALEN);
+	soc = soc_device_match(cpsw_soc_devices);
+	if (soc)
+		cpsw->quirk_irq = 1;
 
+	data = &cpsw->data;
 	cpsw->slaves = devm_kcalloc(dev,
 				    data->slaves, sizeof(struct cpsw_slave),
 				    GFP_KERNEL);
@@ -3537,37 +3531,14 @@ static int cpsw_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto clean_dt_ret;
 	}
-	for (i = 0; i < data->slaves; i++)
-		cpsw->slaves[i].slave_num = i;
 
-	cpsw->slaves[0].ndev = ndev;
-	priv->emac_port = 0;
+	cpsw->rx_packet_max = max(rx_packet_max, CPSW_MAX_PACKET_SIZE);
 
-	clk = devm_clk_get(dev, "fck");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "fck is not found\n");
-		ret = -ENODEV;
-		goto clean_dt_ret;
-	}
-	cpsw->bus_freq_mhz = clk_get_rate(clk) / 1000000;
-
-	ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ss_regs = devm_ioremap_resource(dev, ss_res);
-	if (IS_ERR(ss_regs)) {
-		ret = PTR_ERR(ss_regs);
-		goto clean_dt_ret;
-	}
-	cpsw->regs = ss_regs;
+	cpsw->rx_ch_num = 1;
+	cpsw->tx_ch_num = 1;
 
 	cpsw->version = readl(&cpsw->regs->id_ver);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cpsw->wr_regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(cpsw->wr_regs)) {
-		ret = PTR_ERR(cpsw->wr_regs);
-		goto clean_dt_ret;
-	}
-
 	memset(&dma_params, 0, sizeof(dma_params));
 	memset(&ale_params, 0, sizeof(ale_params));
 
@@ -3604,14 +3575,33 @@ static int cpsw_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto clean_dt_ret;
 	}
+
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		struct cpsw_slave *slave = &cpsw->slaves[i];
+		void __iomem		*regs = cpsw->regs;
+
+		slave->slave_num = i;
+		slave->data	= &cpsw->data.slave_data[i];
+		slave->regs	= regs + slave_offset;
+		slave->sliver	= regs + sliver_offset;
+		slave->port_vlan = slave->data->dual_emac_res_vlan;
 
-		cpsw_slave_init(slave, cpsw, slave_offset, sliver_offset);
 		slave_offset  += slave_size;
 		sliver_offset += SLIVER_SIZE;
 	}
 
+	ale_params.dev			= dev;
+	ale_params.ale_ageout		= ale_ageout;
+	ale_params.ale_entries		= data->ale_entries;
+	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
+
+	cpsw->ale = cpsw_ale_create(&ale_params);
+	if (!cpsw->ale) {
+		dev_err(dev, "error initializing ale engine\n");
+		ret = -ENODEV;
+		goto clean_dt_ret;
+	}
+
 	dma_params.dev		= dev;
 	dma_params.rxthresh	= dma_params.dmaregs + CPDMA_RXTHRESH;
 	dma_params.rxfree	= dma_params.dmaregs + CPDMA_RXFREE;
@@ -3636,50 +3626,56 @@ static int cpsw_probe(struct platform_device *pdev)
 		goto clean_dt_ret;
 	}
 
-	soc = soc_device_match(cpsw_soc_devices);
-	if (soc)
-		cpsw->quirk_irq = 1;
+	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
+	if (IS_ERR(cpsw->cpts)) {
+		ret = PTR_ERR(cpsw->cpts);
+		goto clean_dma_ret;
+	}
 
 	ch = cpsw->quirk_irq ? 0 : 7;
 	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, ch, cpsw_tx_handler, 0);
 	if (IS_ERR(cpsw->txv[0].ch)) {
 		dev_err(dev, "error initializing tx dma channel\n");
 		ret = PTR_ERR(cpsw->txv[0].ch);
-		goto clean_dma_ret;
+		goto clean_cpts;
 	}
 
 	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
 	if (IS_ERR(cpsw->rxv[0].ch)) {
 		dev_err(dev, "error initializing rx dma channel\n");
 		ret = PTR_ERR(cpsw->rxv[0].ch);
-		goto clean_dma_ret;
+		goto clean_cpts;
 	}
+	cpsw_split_res(cpsw);
 
-	ale_params.dev			= dev;
-	ale_params.ale_ageout		= ale_ageout;
-	ale_params.ale_entries		= data->ale_entries;
-	ale_params.ale_ports		= CPSW_ALE_PORTS_NUM;
-
-	cpsw->ale = cpsw_ale_create(&ale_params);
-	if (!cpsw->ale) {
-		dev_err(dev, "error initializing ale engine\n");
-		ret = -ENODEV;
-		goto clean_dma_ret;
+	/* setup netdev */
+	ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
+				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
+	if (!ndev) {
+		dev_err(dev, "error allocating net_device\n");
+		goto clean_cpts;
 	}
 
-	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
-	if (IS_ERR(cpsw->cpts)) {
-		ret = PTR_ERR(cpsw->cpts);
-		goto clean_dma_ret;
-	}
+	platform_set_drvdata(pdev, ndev);
+	priv = netdev_priv(ndev);
+	priv->cpsw = cpsw;
+	priv->ndev = ndev;
+	priv->dev  = dev;
+	priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
+	priv->emac_port = 0;
 
-	ndev->irq = platform_get_irq(pdev, 1);
-	if (ndev->irq < 0) {
-		dev_err(dev, "error getting irq resource\n");
-		ret = ndev->irq;
-		goto clean_dma_ret;
+	if (is_valid_ether_addr(data->slave_data[0].mac_addr)) {
+		memcpy(priv->mac_addr, data->slave_data[0].mac_addr, ETH_ALEN);
+		dev_info(dev, "Detected MACID = %pM\n", priv->mac_addr);
+	} else {
+		eth_random_addr(priv->mac_addr);
+		dev_info(dev, "Random MACID = %pM\n", priv->mac_addr);
 	}
 
+	memcpy(ndev->dev_addr, priv->mac_addr, ETH_ALEN);
+
+	cpsw->slaves[0].ndev = ndev;
+
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
@@ -3690,7 +3686,6 @@ static int cpsw_probe(struct platform_device *pdev)
 	netif_tx_napi_add(ndev, &cpsw->napi_tx,
 			  cpsw->quirk_irq ? cpsw_tx_poll : cpsw_tx_mq_poll,
 			  CPSW_POLL_WEIGHT);
-	cpsw_split_res(cpsw);
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, dev);
@@ -3698,7 +3693,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "error registering net device\n");
 		ret = -ENODEV;
-		goto clean_dma_ret;
+		goto clean_cpts;
 	}
 
 	if (cpsw->data.dual_emac) {
@@ -3716,40 +3711,24 @@ static int cpsw_probe(struct platform_device *pdev)
 	 * If anyone wants to implement support for those, make sure to
 	 * first request and append them to irqs_table array.
 	 */
-
-	/* RX IRQ */
-	irq = platform_get_irq(pdev, 1);
-	if (irq < 0) {
-		ret = irq;
-		goto clean_dma_ret;
-	}
-
-	cpsw->irqs_table[0] = irq;
-	ret = devm_request_irq(dev, irq, cpsw_rx_interrupt,
+	ret = devm_request_irq(dev, cpsw->irqs_table[0], cpsw_rx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_dma_ret;
+		goto clean_unregister_netdev_ret;
 	}
 
-	/* TX IRQ */
-	irq = platform_get_irq(pdev, 2);
-	if (irq < 0) {
-		ret = irq;
-		goto clean_dma_ret;
-	}
 
-	cpsw->irqs_table[1] = irq;
-	ret = devm_request_irq(dev, irq, cpsw_tx_interrupt,
+	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_dma_ret;
+		goto clean_unregister_netdev_ret;
 	}
 
 	cpsw_notice(priv, probe,
 		    "initialized device (regs %pa, irq %d, pool size %d)\n",
-		    &ss_res->start, ndev->irq, dma_params.descs_pool_size);
+		    &ss_res->start, cpsw->irqs_table[0], descs_pool_size);
 
 	pm_runtime_put(&pdev->dev);
 
@@ -3757,6 +3736,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_netdev_ret:
 	unregister_netdev(ndev);
+clean_cpts:
+	cpts_release(cpsw->cpts);
 clean_dma_ret:
 	cpdma_ctlr_destroy(cpsw->dma);
 clean_dt_ret:
-- 
2.17.1
