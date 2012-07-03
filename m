From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 01/18] i2c: omap: switch to devm_* API
Date: Tue, 3 Jul 2012 20:07:39 +0530
Message-ID: <1341326276-25434-2-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab2GCOlM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 10:41:12 -0400
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

that helps deleting some boiler plate code
and lets driver-core manage our resources
for us.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   41 ++++++++++++-----------------------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2500f19..0946be5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -962,7 +962,7 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq, *ioarea;
+	struct resource		*mem, *irq;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
@@ -981,17 +981,16 @@ omap_i2c_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "I2C region already claimed\n");
-		return -EBUSY;
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
+	if (!dev) {
+		dev_err(&pdev->dev, "Menory allocation failed\n");
+		return -ENOMEM;
 	}
 
-	dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		r = -ENOMEM;
-		goto err_release_region;
+	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
+	if (!dev->base) {
+		dev_err(&pdev->dev, "I2C region already claimed\n");
+		return -ENOMEM;
 	}
 
 	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
@@ -1014,11 +1013,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (!dev->base) {
-		r = -ENOMEM;
-		goto err_free_mem;
-	}
 
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
@@ -1076,7 +1070,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
 								   omap_i2c_isr;
-	r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
+	r = devm_request_irq(&pdev->dev, dev->irq, isr, IRQF_NO_SUSPEND,
+			     pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
@@ -1100,7 +1095,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(dev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		goto err_unuse_clocks;
 	}
 
 	of_i2c_register_devices(adap);
@@ -1109,18 +1104,12 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_irq:
-	free_irq(dev->irq, dev);
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
-	iounmap(dev->base);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
 
 	return r;
 }
@@ -1128,12 +1117,10 @@ err_release_region:
 static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
-	struct resource		*mem;
 	int ret;
 
 	platform_set_drvdata(pdev, NULL);
 
-	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (IS_ERR_VALUE(ret))
@@ -1142,10 +1129,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	iounmap(dev->base);
-	kfree(dev);
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	return 0;
 }
 
-- 
1.7.5.4

