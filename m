From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 11/18] I2C: OMAP: use devm_* functions
Date: Wed, 11 Apr 2012 16:42:49 +0530
Message-ID: <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54124 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758015Ab2DKLOA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:14:00 -0400
In-Reply-To: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
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
 drivers/i2c/busses/i2c-omap.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 121c52e..86be475 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -995,17 +995,17 @@ omap_i2c_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
+	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
+			resource_size(mem), pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "I2C region already claimed\n");
 		return -EBUSY;
 	}
 
-	dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!dev) {
-		r = -ENOMEM;
-		goto err_release_region;
+		dev_err(&pdev->dev, "Menory allocation failed\n");
+		return -ENOMEM;
 	}
 
 	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
@@ -1029,11 +1029,10 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (!dev->base) {
-		r = -ENOMEM;
-		goto err_free_mem;
-	}
+	dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
+	if (!dev->base)
+		return -ENOMEM;
+
 
 	platform_set_drvdata(pdev, dev);
 
@@ -1121,13 +1120,8 @@ err_free_irq:
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
@@ -1135,7 +1129,6 @@ err_release_region:
 static int __devexit omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
-	struct resource		*mem;
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -1143,10 +1136,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
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

