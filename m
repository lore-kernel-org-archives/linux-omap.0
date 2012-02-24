From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 2/6] gpio/omap: Use devm_ API and add request_mem_region
Date: Fri, 24 Feb 2012 23:21:27 +0100
Message-ID: <1330122091-28113-3-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38331 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758163Ab2BXWWR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 17:22:17 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Replace the regular kzalloc and ioremap with the devm_ equivalent
to simplify error handling.

Add the missing devm_request_mem_region to reserve the region used
by the driver.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a0c3e03..c3a9dc8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 
@@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	struct gpio_bank *bank;
 	int ret = 0;
 
-	if (!dev->platform_data) {
-		ret = -EINVAL;
-		goto err_exit;
-	}
+	if (!dev->platform_data)
+		return -EINVAL;
 
-	bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
+	bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
 	if (!bank) {
 		dev_err(dev, "Memory alloc failed\n");
-		ret = -ENOMEM;
-		goto err_exit;
+		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
 		dev_err(dev, "Invalid IRQ resource\n");
-		ret = -ENODEV;
-		goto err_free;
+		return -ENODEV;
 	}
 
 	bank->irq = res->start;
@@ -1096,15 +1092,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
 		dev_err(dev, "Invalid mem resource\n");
-		ret = -ENODEV;
-		goto err_free;
+		return -ENODEV;
+	}
+
+	if (!devm_request_mem_region(dev, res->start, resource_size(res),
+				     pdev->name)) {
+		dev_err(dev, "Region already claimed\n");
+		return -EBUSY;
 	}
 
-	bank->base = ioremap(res->start, resource_size(res));
+	bank->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!bank->base) {
 		dev_err(dev, "Could not ioremap\n");
-		ret = -ENOMEM;
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(pdev, bank);
@@ -1125,11 +1125,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	list_add_tail(&bank->node, &omap_gpio_list);
 
 	return ret;
-
-err_free:
-	kfree(bank);
-err_exit:
-	return ret;
 }
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.0.4

