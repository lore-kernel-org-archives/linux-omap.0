From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 9/17] OMAP: dmtimer platform driver
Date: Tue, 21 Sep 2010 14:24:07 +0530
Message-ID: <1285059247-26516-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48007 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112Ab0ITVxU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:53:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds dmtimer platform driver which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |  186 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 185 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9a22623..fc3513e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,7 +43,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <mach/hardware.h>
+#include <linux/pm_runtime.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
 
@@ -780,13 +782,195 @@ int __init omap_dm_timer_init(void)
 			timer->fclk = clk_get(NULL, clk_name);
 		}
 
+#endif
 		timer->id = i;
 		/* add the timer element to the list */
 		spin_lock_irqsave(&dm_timer_lock, flags);
 		list_add_tail(&timer->node, &omap_timer_list);
 		spin_unlock_irqrestore(&dm_timer_lock, flags);
-#endif
 	}
 
 	return 0;
 }
+/**
+ * omap_dm_timer_probe - probe function called for every registered device
+ * @pdev:	pointer to current timer platform device
+ *
+ * called by driver framework at the end of device registration for all
+ * timer devices
+ */
+static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
+{
+	int ret;
+	unsigned long flags;
+	struct omap_dm_timer *timer;
+	struct resource *mem, *irq, *ioarea;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+
+	dev_dbg(&pdev->dev, "%s:+\n", __func__);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
+		return -ENODEV;
+	}
+	/*
+	 * early timers are already registered and in list.
+	 * what we need to do during second phase of probe
+	 * is to assign the newly allocated/configured pdev
+	 * to already registered timer->pdev. we also call
+	 * pm_runtime_enable() for each device because it
+	 * could not be called during early boot because
+	 * pm_runtime framework was not yet up and running.
+	 */
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node)
+		if (timer->id == pdev->id) {
+			timer->pdev = pdev;
+			spin_unlock_irqrestore(&dm_timer_lock, flags);
+			pm_runtime_enable(&pdev->dev);
+			if (timer->enabled) {
+				/*
+				 * Disable the clock and reenable via runtime
+				 * framework so that reference count at
+				 * at PM Runtime, OMAP device & clock fw are
+				 * consistent.
+				 */
+				omap_dm_timer_disable(timer);
+				pm_runtime_get_sync(&pdev->dev);
+			}
+			dev_dbg(&pdev->dev, "pm_runtime ENABLED\n");
+			return 0;
+		}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!irq)) {
+		dev_err(&pdev->dev, "%s: no IRQ resource\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!mem)) {
+		dev_err(&pdev->dev, "%s: no memory resource\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	ioarea = request_mem_region(mem->start, resource_size(mem),
+			pdev->name);
+	if (!ioarea) {
+		dev_err(&pdev->dev, "%s: region already claimed\n", __func__);
+		ret = -EBUSY;
+		goto err_free_pdev;
+	}
+
+	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
+	if (!timer) {
+		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_release_ioregion;
+	}
+
+	timer->io_base = ioremap(mem->start, resource_size(mem));
+	if (!timer->io_base) {
+		dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	timer->irq = irq->start;
+	timer->pdev = pdev;
+	timer->id = pdev->id;
+	timer->reserved = 0;
+	/*
+	 * if pm_runtime is not defined hwmod by default enables the clock.
+	 * in order to avoid back to back enabling of device clock using
+	 * omap_dm_timer_enable(), timer->enabled flag is set here.
+	 */
+#ifndef CONFIG_PM_RUNTIME
+	timer->enabled = 1;
+#endif
+
+	/* add the timer element to the list */
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_add_tail(&timer->node, &omap_timer_list);
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
+
+	dev_dbg(&pdev->dev, " bound to its driver\n");
+
+	return 0;
+
+err_free_mem:
+	kfree(timer);
+
+err_release_ioregion:
+	release_mem_region(mem->start, resource_size(mem));
+
+err_free_pdev:
+	platform_device_del(pdev);
+
+	return ret;
+}
+
+/**
+ * omap_dm_timer_remove - cleanup a registered timer device
+ * @pdev:	pointer to current timer platform device
+ *
+ * called by driver framework whenever a timer device is unregistered.
+ * it addition to freeing platform resources it also deletes the timer
+ * entry from the local list.
+ */
+static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
+{
+	struct omap_dm_timer *timer, *tmp;
+	unsigned long flags;
+	int ret = -EINVAL;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
+		if (timer->id == pdev->id) {
+			platform_device_del(timer->pdev);
+			list_del(&timer->node);
+			kfree(timer);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
+
+	return ret;
+}
+
+static struct platform_driver omap_dmtimer_driver = {
+	.probe	= omap_dm_timer_probe,
+	.remove	= omap_dm_timer_remove,
+	.driver	= {
+		.name   = "dmtimer",
+	},
+};
+
+static int __init omap_dmtimer_driver_init(void)
+{
+	return platform_driver_register(&omap_dmtimer_driver);
+}
+
+static void __exit omap_dmtimer_driver_exit(void)
+{
+	platform_driver_unregister(&omap_dmtimer_driver);
+}
+
+module_init(omap_dmtimer_driver_init);
+module_exit(omap_dmtimer_driver_exit);
+
+MODULE_DESCRIPTION("OMAP DUAL MODE TIMER DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
-- 
1.6.0.4

