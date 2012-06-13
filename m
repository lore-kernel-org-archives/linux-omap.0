From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 15/22] i2c: omap: switch to devm_* API
Date: Wed, 13 Jun 2012 18:51:04 +0300
Message-ID: <1339602671-8431-16-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46217 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab2FMPx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:56 -0400
Received: by lbbgj10 with SMTP id gj10so1764287lbb.23
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:54 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that helps deleting some boiler plate code
and lets driver-core manage our resources
for us.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   50 +++++++++++++----------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f30eb45..5e9e165 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1071,7 +1071,7 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq, *ioarea;
+	struct resource		*mem, *irq;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
@@ -1083,23 +1083,17 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no mem resource?\n");
 		return -ENODEV;
 	}
+
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "no irq resource?\n");
 		return -ENODEV;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "I2C region already claimed\n");
-		return -EBUSY;
-	}
-
-	dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!dev) {
-		r = -ENOMEM;
-		goto err_release_region;
+		dev_err(&pdev->dev, "not enough memory\n");
+		return -ENOMEM;
 	}
 
 	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
@@ -1122,10 +1116,10 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = ioremap(mem->start, resource_size(mem));
+	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
 	if (!dev->base) {
-		r = -ENOMEM;
-		goto err_free_mem;
+		dev_err(&pdev->dev, "ioremap failed\n");
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(pdev, dev);
@@ -1175,11 +1169,12 @@ omap_i2c_probe(struct platform_device *pdev)
 	omap_i2c_init(dev);
 
 	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
-		r = request_irq(dev->irq, omap_i2c_omap1_isr, 0,
-				pdev->name, dev);
+		r = devm_request_irq(&pdev->dev, dev->irq, omap_i2c_omap1_isr,
+				0, pdev->name, dev);
 	else
-		r = request_threaded_irq(dev->irq, omap_i2c_isr,
-				omap_i2c_threaded_isr, 0, pdev->name, dev);
+		r = devm_request_threaded_irq(&pdev->dev, dev->irq,
+				omap_i2c_isr, omap_i2c_threaded_isr, 0,
+				pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
@@ -1205,24 +1200,16 @@ omap_i2c_probe(struct platform_device *pdev)
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(dev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		goto err_unuse_clocks;
 	}
 
 	of_i2c_register_devices(adap);
 
 	return 0;
 
-err_free_irq:
-	free_irq(dev->irq, dev);
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
-	iounmap(dev->base);
-err_free_mem:
-	platform_set_drvdata(pdev, NULL);
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
 
 	return r;
 }
@@ -1231,17 +1218,10 @@ static int
 omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
-	struct resource		*mem;
-
-	platform_set_drvdata(pdev, NULL);
 
-	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-	iounmap(dev->base);
-	kfree(dev);
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
+
 	return 0;
 }
 
-- 
1.7.10.4

