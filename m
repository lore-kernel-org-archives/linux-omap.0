From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: dmtimer: Use devm_ API and do some cleanup in probe()
Date: Mon, 16 Apr 2012 17:55:23 +0530
Message-ID: <1334579125-15566-2-git-send-email-tarun.kanti@ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52438 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab2DPMZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 08:25:37 -0400
In-Reply-To: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Replace the regular kzalloc and ioremap with the devm_ equivalent
to simplify error handling. We don't need kree() anymore in
omap_dm_timer_remove().

Also added *dev* pointer to reference pdev->dev which makes the
usage shorter in code.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   51 +++++++++++++++--------------------------
 1 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 652139c..549a811 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -37,7 +37,7 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 
@@ -628,49 +628,45 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
  */
 static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 {
-	int ret;
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *mem, *irq, *ioarea;
+	struct resource *mem, *irq;
+	struct device *dev = &pdev->dev;
 	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
 
 	if (!pdata) {
-		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
+		dev_err(dev, "%s: no platform data.\n", __func__);
 		return -ENODEV;
 	}
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!irq)) {
-		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
+		dev_err(dev, "%s: no IRQ resource.\n", __func__);
 		return -ENODEV;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!mem)) {
-		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
+		dev_err(dev, "%s: no memory resource.\n", __func__);
 		return -ENODEV;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
+	if (!devm_request_mem_region(dev, mem->start, resource_size(mem),
+					pdev->name)) {
+		dev_err(dev, "%s: region already claimed.\n", __func__);
 		return -EBUSY;
 	}
 
-	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
+	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
 	if (!timer) {
-		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
-			__func__);
-		ret = -ENOMEM;
-		goto err_free_ioregion;
+		dev_err(dev, "%s: memory alloc failed!\n", __func__);
+		return  -ENOMEM;
 	}
 
-	timer->io_base = ioremap(mem->start, resource_size(mem));
+	timer->io_base = devm_ioremap(dev, mem->start, resource_size(mem));
 	if (!timer->io_base) {
-		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
-		ret = -ENOMEM;
-		goto err_free_mem;
+		dev_err(dev, "%s: ioremap failed.\n", __func__);
+		return -ENOMEM;
 	}
 
 	timer->id = pdev->id;
@@ -682,12 +678,12 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!pdata->needs_manual_reset) {
-		pm_runtime_enable(&pdev->dev);
-		pm_runtime_irq_safe(&pdev->dev);
+		pm_runtime_enable(dev);
+		pm_runtime_irq_safe(dev);
 	}
 
 	if (!timer->reserved) {
-		pm_runtime_get_sync(&pdev->dev);
+		pm_runtime_get_sync(dev);
 		__omap_dm_timer_init_regs(timer);
 		pm_runtime_put(&pdev->dev);
 	}
@@ -697,17 +693,9 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	list_add_tail(&timer->node, &omap_timer_list);
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	dev_dbg(&pdev->dev, "Device Probed.\n");
+	dev_dbg(dev, "Device Probed.\n");
 
 	return 0;
-
-err_free_mem:
-	kfree(timer);
-
-err_free_ioregion:
-	release_mem_region(mem->start, resource_size(mem));
-
-	return ret;
 }
 
 /**
@@ -728,7 +716,6 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (timer->pdev->id == pdev->id) {
 			list_del(&timer->node);
-			kfree(timer);
 			ret = 0;
 			break;
 		}
-- 
1.7.0.4

