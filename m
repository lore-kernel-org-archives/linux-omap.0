From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 1/4] ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
Date: Fri, 20 Apr 2012 18:09:20 +0530
Message-ID: <1334925563-20768-2-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2DTMji (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 08:39:38 -0400
In-Reply-To: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Replace the regular kzalloc and ioremap with the devm_ equivalent
to simplify error handling. We don't need kree() any more in
omap_dm_timer_remove().

Also added *dev* pointer to reference pdev->dev which makes the
usage shorter in code.

Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   51 +++++++++++++----------------------------
 1 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 652139c..8a8768b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -37,7 +37,7 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 
@@ -628,49 +628,39 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
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
-		return -EBUSY;
-	}
-
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
+	timer->io_base = devm_request_and_ioremap(dev, mem);
 	if (!timer->io_base) {
-		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
-		ret = -ENOMEM;
-		goto err_free_mem;
+		dev_err(dev, "%s: region already claimed.\n", __func__);
+		return -ENOMEM;
 	}
 
 	timer->id = pdev->id;
@@ -682,12 +672,12 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
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
@@ -697,17 +687,9 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
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
@@ -728,7 +710,6 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (timer->pdev->id == pdev->id) {
 			list_del(&timer->node);
-			kfree(timer);
 			ret = 0;
 			break;
 		}
-- 
1.7.0.4

