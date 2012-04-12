From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 11/18] I2C: OMAP: use devm_* functions
Date: Thu, 12 Apr 2012 18:36:28 +0530
Message-ID: <1334235995-6727-12-git-send-email-shubhrajyoti@ti.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54767 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759003Ab2DLNHH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 09:07:07 -0400
In-Reply-To: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The various devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_kzalloc, devm_request_mem_region and
devm_ioremap for data that is allocated in the probe function of a platform
device and is only freed in the remove function.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   34 +++++++++-------------------------
 1 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 121c52e..76b7b62 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -976,7 +976,7 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq, *ioarea;
+	struct resource		*mem, *irq;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
@@ -995,17 +995,16 @@ omap_i2c_probe(struct platform_device *pdev)
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
@@ -1029,11 +1028,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (!dev->base) {
-		r = -ENOMEM;
-		goto err_free_mem;
-	}
 
 	platform_set_drvdata(pdev, dev);
 
@@ -1121,13 +1115,8 @@ err_free_irq:
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
-	iounmap(dev->base);
 	pm_runtime_disable(&pdev->dev);
-err_free_mem:
 	platform_set_drvdata(pdev, NULL);
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
 
 	return r;
 }
@@ -1135,7 +1124,6 @@ err_release_region:
 static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
-	struct resource		*mem;
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -1143,10 +1131,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_disable(&pdev->dev);
-	iounmap(dev->base);
-	kfree(dev);
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	return 0;
 }
 
-- 
1.7.4.1

