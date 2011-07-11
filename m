From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 05/12] OMAP: dmtimer: platform driver
Date: Mon, 11 Jul 2011 16:59:12 +0530
Message-ID: <1310383759-19059-6-git-send-email-tarun.kanti@ti.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab1GKMtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 08:49:13 -0400
In-Reply-To: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add dmtimer platform driver functions which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  159 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/dmtimer.h |   11 ++
 2 files changed, 163 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 995bab0..c5573c3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -35,14 +35,9 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/list.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <mach/hardware.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
@@ -149,6 +144,7 @@ static const char **dm_source_names;
 static struct clk **dm_source_clocks;
 
 static spinlock_t dm_timer_lock;
+static LIST_HEAD(omap_timer_list);
 
 /*
  * Reads timer registers in posted and non-posted mode. The posted mode bit
@@ -544,7 +540,156 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
-static int __init omap_dm_timer_init(void)
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
+		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
+		return -ENODEV;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!irq)) {
+		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!mem)) {
+		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	ioarea = request_mem_region(mem->start, resource_size(mem),
+			pdev->name);
+	if (!ioarea) {
+		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
+		ret = -EBUSY;
+		goto err_free_pdev;
+	}
+
+	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
+	if (!timer) {
+		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_release_ioregion;
+	}
+
+	timer->io_base = ioremap(mem->start, resource_size(mem));
+	if (!timer->io_base) {
+		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
+		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
+	} else {
+		timer->func_offset = 0;
+		timer->intr_offset = 0;
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
+	dev_dbg(&pdev->dev, "Device Probed.\n");
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
+int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
 	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 400fe3c..833a33b 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -61,6 +61,13 @@
 #define OMAP_TIMER_IP_VERSION_1			0x1
 #define OMAP_TIMER_IP_VERSION_2			0x2
 
+/*
+ * OMAP4 IP revision has different register offsets
+ * for interrupt registers and functional registers.
+ */
+#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET     0x14
+#define VERSION2_TIMER_STAT_REG_OFFSET          0x10
+
 /* timer capabilities used in hwmod database */
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
@@ -225,6 +232,7 @@ int omap_dm_timers_active(void);
 
 struct omap_dm_timer {
 	unsigned long phys_base;
+	int id;
 	int irq;
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
@@ -234,7 +242,10 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
+	u8 func_offset;
+	u8 intr_offset;
 	struct platform_device *pdev;
+	struct list_head node;
 };
 
 extern u32 sys_timer_reserved;
-- 
1.6.0.4

