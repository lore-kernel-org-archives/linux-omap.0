From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 08/11] OMAP: dmtimer: platform driver
Date: Fri, 11 Feb 2011 16:47:17 +0530
Message-ID: <1297423040-19917-9-git-send-email-tarun.kanti@ti.com>
References: <1297423040-19917-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938Ab1BKLPB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 06:15:01 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1BBEwqI022274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 05:15:00 -0600
In-Reply-To: <1297423040-19917-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Thara Gopinath <thara@ti.com>

Add dmtimer platform driver functions which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  167 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 +
 2 files changed, 168 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1bfaf09..bfe6fd3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
@@ -257,7 +260,8 @@ static struct omap_dm_timer *dm_timers;
 static const char **dm_source_names;
 static struct clk **dm_source_clocks;
 
-static spinlock_t dm_timer_lock;
+static LIST_HEAD(omap_timer_list);
+static DEFINE_SPINLOCK(dm_timer_lock);
 
 /*
  * Reads timer registers in posted and non-posted mode. The posted mode bit
@@ -689,6 +693,167 @@ int omap_dm_timers_active(void)
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
+	if (pdata->is_omap16xx) {
+		pdata->dm_timer_read_reg = omap_dm_timer_read_reg;
+		pdata->dm_timer_write_reg = omap_dm_timer_write_reg;
+		pdata->is_early_init = 0;
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
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 4bfbfcc..1a080db 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -59,6 +59,7 @@
 
 struct omap_dm_timer {
 	unsigned long phys_base;
+	int id;
 	int irq;
 	struct clk *iclk, *fclk;
 	void __iomem *io_base;
@@ -66,6 +67,7 @@ struct omap_dm_timer {
 	unsigned enabled:1;
 	unsigned posted:1;
 	struct platform_device *pdev;
+	struct list_head node;
 };
 
 extern struct omap_dm_timer *gptimer_wakeup;
-- 
1.6.0.4

