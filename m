From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [RFC] net: ethernet: davinci_emac: add pm_runtime support
Date: Fri, 11 May 2012 14:18:45 -0700
Message-ID: <20120511211845.GA10670@animalcreek.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:44814 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021Ab2EKVSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 17:18:46 -0400
Content-Disposition: inline
In-Reply-To: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add pm_runtime support to the TI Davinci EMAC driver.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---

This patch is RFC only since it will break emac support
for mach-davinci platforms.  Hopefully, mach-davinci will
be fixed soon and this can be submitted.

 drivers/net/ethernet/ti/davinci_emac.c |   43 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 174a334..15c84e4 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -57,6 +57,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
 #include <linux/davinci_emac.h>
 
 #include <asm/irq.h>
@@ -346,10 +347,6 @@ struct emac_priv {
 	void (*int_disable) (void);
 };
 
-/* clock frequency for EMAC */
-static struct clk *emac_clk;
-static unsigned long emac_bus_frequency;
-
 /* EMAC TX Host Error description strings */
 static char *emac_txhost_errcodes[16] = {
 	"No error", "SOP error", "Ownership bit not set in SOP buffer",
@@ -1534,6 +1531,8 @@ static int emac_dev_open(struct net_device *ndev)
 	int k = 0;
 	struct emac_priv *priv = netdev_priv(ndev);
 
+	pm_runtime_get(&priv->pdev->dev);
+
 	netif_carrier_off(ndev);
 	for (cnt = 0; cnt < ETH_ALEN; cnt++)
 		ndev->dev_addr[cnt] = priv->mac_addr[cnt];
@@ -1603,7 +1602,7 @@ static int emac_dev_open(struct net_device *ndev)
 				priv->phy_id);
 			ret = PTR_ERR(priv->phydev);
 			priv->phydev = NULL;
-			return ret;
+			goto err;
 		}
 
 		priv->link = 0;
@@ -1644,7 +1643,11 @@ rollback:
 		res = platform_get_resource(priv->pdev, IORESOURCE_IRQ, k-1);
 		m = res->end;
 	}
-	return -EBUSY;
+
+	ret = -EBUSY;
+err:
+	pm_runtime_put(&priv->pdev->dev);
+	return ret;
 }
 
 /**
@@ -1686,6 +1689,7 @@ static int emac_dev_stop(struct net_device *ndev)
 	if (netif_msg_drv(priv))
 		dev_notice(emac_dev, "DaVinci EMAC: %s stopped\n", ndev->name);
 
+	pm_runtime_put(&priv->pdev->dev);
 	return 0;
 }
 
@@ -1779,6 +1783,9 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 	struct emac_platform_data *pdata;
 	struct device *emac_dev;
 	struct cpdma_params dma_params;
+	struct clk *emac_clk;
+	unsigned long emac_bus_frequency;
+
 
 	/* obtain emac clock from kernel */
 	emac_clk = clk_get(&pdev->dev, NULL);
@@ -1787,12 +1794,14 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 	emac_bus_frequency = clk_get_rate(emac_clk);
+	clk_put(emac_clk);
+
 	/* TODO: Probe PHY here if possible */
 
 	ndev = alloc_etherdev(sizeof(struct emac_priv));
 	if (!ndev) {
 		rc = -ENOMEM;
-		goto free_clk;
+		goto no_ndev;
 	}
 
 	platform_set_drvdata(pdev, ndev);
@@ -1908,15 +1917,13 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 	SET_ETHTOOL_OPS(ndev, &ethtool_ops);
 	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
 
-	clk_enable(emac_clk);
-
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	rc = register_netdev(ndev);
 	if (rc) {
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc = -ENODEV;
-		goto netdev_reg_err;
+		goto no_irq_res;
 	}
 
 
@@ -1925,10 +1932,12 @@ static int __devinit davinci_emac_probe(struct platform_device *pdev)
 			   "(regs: %p, irq: %d)\n",
 			   (void *)priv->emac_base_phys, ndev->irq);
 	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
+
 	return 0;
 
-netdev_reg_err:
-	clk_disable(emac_clk);
 no_irq_res:
 	if (priv->txchan)
 		cpdma_chan_destroy(priv->txchan);
@@ -1942,8 +1951,7 @@ no_dma:
 
 probe_quit:
 	free_netdev(ndev);
-free_clk:
-	clk_put(emac_clk);
+no_ndev:
 	return rc;
 }
 
@@ -1977,9 +1985,6 @@ static int __devexit davinci_emac_remove(struct platform_device *pdev)
 	iounmap(priv->remap_addr);
 	free_netdev(ndev);
 
-	clk_disable(emac_clk);
-	clk_put(emac_clk);
-
 	return 0;
 }
 
@@ -1991,8 +1996,6 @@ static int davinci_emac_suspend(struct device *dev)
 	if (netif_running(ndev))
 		emac_dev_stop(ndev);
 
-	clk_disable(emac_clk);
-
 	return 0;
 }
 
@@ -2001,8 +2004,6 @@ static int davinci_emac_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
-	clk_enable(emac_clk);
-
 	if (netif_running(ndev))
 		emac_dev_open(ndev);
 
-- 
1.7.9.4

