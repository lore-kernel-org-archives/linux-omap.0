From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv4 8/14] OMAP: dmtimer: platform driver
Date: Sat, 20 Nov 2010 08:09:32 +0530
Message-ID: <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52658 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab0KSPgh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:36:37 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAJFaYs2021870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:36:37 -0600
In-Reply-To: <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Thara Gopinath <thara@ti.com>

Add dmtimer platform driver functions which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |  168 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 168 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 124fd21..3d7bd65 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,9 +43,11 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
+#include <linux/err.h>
 
 /* register offsets */
 #define _OMAP_TIMER_ID_OFFSET		0x00
@@ -745,6 +747,172 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
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
+	timer->fclk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR_OR_NULL(timer->fclk)) {
+		dev_dbg(&pdev->dev, "%s:%d: clk_get() FAILED\n",
+			__func__, __LINE__);
+		ret = -EINVAL;
+		goto err_free_mem;
+	}
+	timer->irq = irq->start;
+	timer->pdev = pdev;
+	timer->id = pdev->id;
+	timer->reserved = 0;
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
+
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
+		if (timer->id == pdev->id) {
+			clk_put(timer->fclk);
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
+		.name   = "omap-timer",
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
+early_platform_init("earlytimer", &omap_dmtimer_driver);
+module_init(omap_dmtimer_driver_init);
+module_exit(omap_dmtimer_driver_exit);
+
+MODULE_DESCRIPTION("OMAP DUAL MODE TIMER DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
+
 int __init omap_dm_timer_init(void)
 {
 	unsigned long flags;
-- 
1.6.0.4

