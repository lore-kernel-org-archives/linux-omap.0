From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 8/12] OMAP: dmtimer: platform driver
Date: Wed, 15 Dec 2010 09:35:06 +0530
Message-ID: <1292385910-5234-9-git-send-email-tarun.kanti@ti.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310Ab0LNRBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:01:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1fj9008826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:43 -0600
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add dmtimer platform driver functions which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  169 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    4 +
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1bfaf09..f3eb032 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,8 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
@@ -257,7 +259,8 @@ static struct omap_dm_timer *dm_timers;
 static const char **dm_source_names;
 static struct clk **dm_source_clocks;
 
-static spinlock_t dm_timer_lock;
+static LIST_HEAD(omap_timer_list);
+static DEFINE_SPINLOCK(dm_timer_lock);
 
 /*
  * Reads timer registers in posted and non-posted mode. The posted mode bit
@@ -689,6 +692,168 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
+/**
+ * omap_dm_timer_probe - probe function called for every registered device
+ * @pdev:	pointer to current timer platform device
+ *
+ * Called by driver framework at the end of device registration for all
+ * timer devices.
+ */
+static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
+{
+	int ret;
+	unsigned long flags;
+	struct omap_dm_timer *timer;
+	struct resource *mem, *irq, *ioarea;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+
+	dev_dbg(&pdev->dev, "%s: +\n", __func__);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node)
+		if (!pdata->is_early_init && timer->id == pdev->id) {
+			timer->pdev = pdev;
+			spin_unlock_irqrestore(&dm_timer_lock, flags);
+			dev_dbg(&pdev->dev, "Regular Probed\n");
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
+	/*
+	 * Following func pointers are required by OMAP1's reset code
+	 * in mach-omap1/dmtimer.c to access to low level read/write.
+	 */
+	if (cpu_is_omap16xx()) {
+		pdata->dm_timer_read_reg = omap_dm_timer_read_reg;
+		pdata->dm_timer_write_reg = omap_dm_timer_write_reg;
+	}
+
+	timer->id = pdev->id;
+	timer->irq = irq->start;
+	timer->pdev = pdev;
+	timer->reserved = 0;
+
+	/* add the timer element to the list */
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_add_tail(&timer->node, &omap_timer_list);
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
+
+	dev_dbg(&pdev->dev, "Early Probed\n");
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
+	kfree(pdata);
+	platform_device_unregister(pdev);
+
+	return ret;
+}
+
+/**
+ * omap_dm_timer_remove - cleanup a registered timer device
+ * @pdev:	pointer to current timer platform device
+ *
+ * Called by driver framework whenever a timer device is unregistered.
+ * In addition to freeing platform resources it also deletes the timer
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
+		if (timer->pdev->id == pdev->id) {
+			kfree(timer->pdev->dev.platform_data);
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
+static struct platform_driver omap_dm_timer_driver = {
+	.probe  = omap_dm_timer_probe,
+	.remove = omap_dm_timer_remove,
+	.driver = {
+		.name   = "omap_timer",
+	},
+};
+
+static int __init omap_dm_timer_driver_init(void)
+{
+	return platform_driver_register(&omap_dm_timer_driver);
+}
+
+static void __exit omap_dm_timer_driver_exit(void)
+{
+	platform_driver_unregister(&omap_dm_timer_driver);
+}
+
+early_platform_init("earlytimer", &omap_dm_timer_driver);
+module_init(omap_dm_timer_driver_init);
+module_exit(omap_dm_timer_driver_exit);
+
+MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
+
 int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
@@ -697,8 +862,6 @@ int __init omap_dm_timer_init(void)
 	if (!cpu_class_is_omap2())
 		return -ENODEV;
 
-	spin_lock_init(&dm_timer_lock);
-
 	if (cpu_is_omap24xx()) {
 		dm_timers = omap2_dm_timers;
 		dm_timer_count = omap2_dm_timer_count;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 7b089b0..20c64f4 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -35,6 +35,8 @@
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
 
+#include <linux/platform_device.h>
+
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK			0x00
 #define OMAP_TIMER_SRC_32_KHZ			0x01
@@ -59,6 +61,7 @@
 
 struct omap_dm_timer {
 	unsigned long phys_base;
+	int id;
 	int irq;
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
@@ -68,6 +71,7 @@ struct omap_dm_timer {
 	unsigned enabled:1;
 	unsigned posted:1;
 	struct platform_device *pdev;
+	struct list_head node;
 };
 
 extern struct omap_dm_timer *gptimer_wakeup;
-- 
1.6.0.4

