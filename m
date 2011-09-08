From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 05/12] OMAP: dmtimer: platform driver
Date: Fri, 9 Sep 2011 02:38:11 +0530
Message-ID: <1315516098-29761-6-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add dmtimer platform driver functions which include:
(1) platform driver initialization
(2) driver probe function
(3) driver remove function

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |  143 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |   11 ++
 2 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c11073d..7cee4fb 100644
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
@@ -544,6 +540,141 @@ int omap_dm_timers_active(void)
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
+		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
+		return -ENODEV;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!irq)) {
+		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
+		return -ENODEV;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!mem)) {
+		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
+		return -ENODEV;
+	}
+
+	ioarea = request_mem_region(mem->start, resource_size(mem),
+			pdev->name);
+	if (!ioarea) {
+		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
+		return -EBUSY;
+	}
+
+	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
+	if (!timer) {
+		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_free_ioregion;
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
+	}
+
+	timer->id = pdev->id;
+	timer->irq = irq->start;
+	timer->pdev = pdev;
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
+err_free_ioregion:
+	release_mem_region(mem->start, resource_size(mem));
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
+	struct omap_dm_timer *timer;
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node)
+		if (timer->pdev->id == pdev->id) {
+			list_del(&timer->node);
+			kfree(timer);
+			ret = 0;
+			break;
+		}
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
 static int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 3495dec..46f6e7f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -62,6 +62,13 @@
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
@@ -226,6 +233,7 @@ int omap_dm_timers_active(void);
 
 struct omap_dm_timer {
 	unsigned long phys_base;
+	int id;
 	int irq;
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
@@ -235,7 +243,10 @@ struct omap_dm_timer {
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
1.7.0.4
