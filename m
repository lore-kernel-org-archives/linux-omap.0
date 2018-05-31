From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH -net] net: ethernet: davinci_emac: fix error handling in
 probe()
Date: Thu, 31 May 2018 09:44:49 +0300
Message-ID: <20180531064449.y2do4kjban2hmatz@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Cyril Chemparathy <cyril@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The current error handling code has an issue where it does:

	if (priv->txchan)
		cpdma_chan_destroy(priv->txchan);

The problem is that ->txchan is either valid or an error pointer (which
would lead to an Oops).  I've changed it to use multiple error labels so
that the test can be removed.

Also there were some missing calls to netif_napi_del().

Fixes: 3ef0fdb2342c ("net: davinci_emac: switch to new cpdma layer")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index be0fec17d95d..06d7c9e4dcda 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1873,7 +1873,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->txchan)) {
 		dev_err(&pdev->dev, "error initializing tx dma channel\n");
 		rc = PTR_ERR(priv->txchan);
-		goto no_cpdma_chan;
+		goto err_free_dma;
 	}
 
 	priv->rxchan = cpdma_chan_create(priv->dma, EMAC_DEF_RX_CH,
@@ -1881,14 +1881,14 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rxchan)) {
 		dev_err(&pdev->dev, "error initializing rx dma channel\n");
 		rc = PTR_ERR(priv->rxchan);
-		goto no_cpdma_chan;
+		goto err_free_txchan;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "error getting irq res\n");
 		rc = -ENOENT;
-		goto no_cpdma_chan;
+		goto err_free_rxchan;
 	}
 	ndev->irq = res->start;
 
@@ -1914,7 +1914,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 		dev_err(&pdev->dev, "%s: failed to get_sync(%d)\n",
 			__func__, rc);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 	/* register the network device */
@@ -1924,7 +1924,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc = -ENODEV;
 		pm_runtime_put(&pdev->dev);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 
@@ -1937,11 +1937,13 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	return 0;
 
-no_cpdma_chan:
-	if (priv->txchan)
-		cpdma_chan_destroy(priv->txchan);
-	if (priv->rxchan)
-		cpdma_chan_destroy(priv->rxchan);
+err_napi_del:
+	netif_napi_del(&priv->napi);
+err_free_rxchan:
+	cpdma_chan_destroy(priv->rxchan);
+err_free_txchan:
+	cpdma_chan_destroy(priv->txchan);
+err_free_dma:
 	cpdma_ctlr_destroy(priv->dma);
 no_pdata:
 	if (of_phy_is_fixed_link(np))
