From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v8 4/5] can: m_can: Add PM Support
Date: Tue, 16 Jan 2018 17:07:13 +0530
Message-ID: <1516102634-6771-5-git-send-email-faiz_abbas@ti.com>
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

Add support for CONFIG_PM which is the new way to handle managing clocks.

Move the clock management to pm_runtime_resume() and pm_runtime_suspend()
callbacks for the driver.

CONFIG_PM is required by OMAP based devices to handle clock management.
Therefore, this allows future Texas Instruments SoCs that have the MCAN IP
to work with this driver.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 100 ++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ebb74de..95c5594 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
 
@@ -625,21 +626,16 @@ static int m_can_clk_start(struct m_can_priv *priv)
 {
 	int err;
 
-	err = clk_prepare_enable(priv->hclk);
+	err = pm_runtime_get_sync(priv->device);
 	if (err)
-		return err;
-
-	err = clk_prepare_enable(priv->cclk);
-	if (err)
-		clk_disable_unprepare(priv->hclk);
+		pm_runtime_put_noidle(priv->device);
 
 	return err;
 }
 
 static void m_can_clk_stop(struct m_can_priv *priv)
 {
-	clk_disable_unprepare(priv->cclk);
-	clk_disable_unprepare(priv->hclk);
+	pm_runtime_put_sync(priv->device);
 }
 
 static int m_can_get_berr_counter(const struct net_device *dev,
@@ -1559,37 +1555,26 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto failed_ret;
 	}
 
-	/* Enable clocks. Necessary to read Core Release in order to determine
-	 * M_CAN version
-	 */
-	ret = clk_prepare_enable(hclk);
-	if (ret)
-		goto disable_hclk_ret;
-
-	ret = clk_prepare_enable(cclk);
-	if (ret)
-		goto disable_cclk_ret;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
 	irq = platform_get_irq_byname(pdev, "int0");
 
 	if (IS_ERR(addr) || irq < 0) {
 		ret = -EINVAL;
-		goto disable_cclk_ret;
+		goto failed_ret;
 	}
 
 	/* message ram could be shared */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
 	if (!res) {
 		ret = -ENODEV;
-		goto disable_cclk_ret;
+		goto failed_ret;
 	}
 
 	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!mram_addr) {
 		ret = -ENOMEM;
-		goto disable_cclk_ret;
+		goto failed_ret;
 	}
 
 	/* get message ram configuration */
@@ -1598,7 +1583,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 					 sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
-		goto disable_cclk_ret;
+		goto failed_ret;
 	}
 
 	/* Get TX FIFO size
@@ -1610,13 +1595,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
 	if (!dev) {
 		ret = -ENOMEM;
-		goto disable_cclk_ret;
+		goto failed_ret;
 	}
 
-	ret = setup_m_can_dev(pdev, dev, addr);
-	if (ret)
-		goto failed_free_dev;
-
 	priv = netdev_priv(dev);
 	dev->irq = irq;
 	priv->device = &pdev->dev;
@@ -1630,11 +1611,23 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
+	/* Enable clocks. Necessary to read Core Release in order to determine
+	 * M_CAN version
+	 */
+	pm_runtime_enable(&pdev->dev);
+	ret = m_can_clk_start(priv);
+	if (ret)
+		goto pm_runtime_fail;
+
+	ret = setup_m_can_dev(pdev, dev, addr);
+	if (ret)
+		goto clk_disable;
+
 	ret = register_m_can_dev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			KBUILD_MODNAME, ret);
-		goto failed_free_dev;
+		goto clk_disable;
 	}
 
 	devm_can_led_init(dev);
@@ -1647,15 +1640,13 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
 	 */
-
-	goto disable_cclk_ret;
-
-failed_free_dev:
-	free_m_can_dev(dev);
-disable_cclk_ret:
-	clk_disable_unprepare(cclk);
-disable_hclk_ret:
-	clk_disable_unprepare(hclk);
+clk_disable:
+	m_can_clk_stop(priv);
+pm_runtime_fail:
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		free_m_can_dev(dev);
+	}
 failed_ret:
 	return ret;
 }
@@ -1713,6 +1704,9 @@ static int m_can_plat_remove(struct platform_device *pdev)
 	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_m_can_dev(dev);
+
+	pm_runtime_disable(&pdev->dev);
+
 	platform_set_drvdata(pdev, NULL);
 
 	free_m_can_dev(dev);
@@ -1720,7 +1714,37 @@ static int m_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
+int m_can_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_priv *priv = netdev_priv(ndev);
+
+	clk_disable_unprepare(priv->cclk);
+	clk_disable_unprepare(priv->hclk);
+
+	return 0;
+}
+
+int m_can_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_priv *priv = netdev_priv(ndev);
+	int err;
+
+	err = clk_prepare_enable(priv->hclk);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->cclk);
+	if (err)
+		clk_disable_unprepare(priv->hclk);
+
+	return err;
+}
+
 static const struct dev_pm_ops m_can_pmops = {
+	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
+			   m_can_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
 };
 
-- 
2.7.4
