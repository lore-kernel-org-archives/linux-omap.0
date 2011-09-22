From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 05/12] OMAP: dmtimer: switch-over to platform
 device driver
Date: Wed, 21 Sep 2011 18:00:55 -0700
Message-ID: <20110922010055.GT2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37624 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1IVBA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:57 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-6-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> @@ -347,15 +346,16 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
>  	if (l & OMAP_TIMER_CTRL_ST) {
>  		l &= ~0x1;
>  		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -		/* Readback to make sure write has completed */
> -		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
> -		/*
> -		 * Wait for functional clock period x 3.5 to make sure that
> -		 * timer is stopped
> -		 */
> -		udelay(3500000 / rate + 1);
> -#endif
> +		if (is_omap2) {
> +			/* Readback to make sure write has completed */
> +			__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG,
> +								posted);
> +			/*
> +			 * Wait for functional clock period x 3.5 to make sure
> +			 * that timer is stopped
> +			 */
> +			udelay(3500000 / rate + 1);
> +		}
>  	}
>  
>  	/* Ack possibly pending interrupt */

I've left out this is_omap2 change as it really does not improve anything.
Instead it just makes __omap_dm_timer_stop inline function more complex.

I've also folded in the spinlock fixes in patch 10 into this patch.

Updated patch below.

Tony


From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Tue, 20 Sep 2011 17:00:20 +0530
Subject: [PATCH] ARM: OMAP: dmtimer: switch-over to platform device driver

Register timer devices by going through hwmod database using
hwmod API. The driver probes each of the registered devices.
Functionality which are already performed by hwmod framework
are removed from timer code. New set of timers present on
OMAP4 are now supported.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
[tony@atomide.com: folded in spinlock changes, left out is_omap2]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b2829ee..9c2f588 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -478,3 +478,23 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 
 	return ret;
 }
+
+/**
+ * omap2_dm_timer_init - top level regular device initialization
+ *
+ * Uses dedicated hwmod api to parse through hwmod database for
+ * given class name and then build and register the timer device.
+ */
+static int __init omap2_dm_timer_init(void)
+{
+	int ret;
+
+	ret = omap_hwmod_for_each_by_class("timer", omap_timer_init, NULL);
+	if (unlikely(ret)) {
+		pr_err("%s: device registration failed.\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+arch_initcall(omap2_dm_timer_init);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 92d5aff..6019208 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -36,120 +36,22 @@
  */
 
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/slab.h>
-#include <mach/hardware.h>
-#include <plat/dmtimer.h>
-#include <mach/irqs.h>
-
-static int dm_timer_count;
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct omap_dm_timer omap2_dm_timers[] = {
-	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
-};
-
-static const char *omap2_dm_source_names[] __initdata = {
-	"sys_ck",
-	"func_32k_ck",
-	"alt_ck",
-	NULL
-};
-
-static struct clk *omap2_dm_source_clocks[3];
-static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
-
-#else
-#define omap2_dm_timers			NULL
-#define omap2_dm_timer_count		0
-#define omap2_dm_source_names		NULL
-#define omap2_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP2 */
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct omap_dm_timer omap3_dm_timers[] = {
-	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
-};
-
-static const char *omap3_dm_source_names[] __initdata = {
-	"sys_ck",
-	"omap_32k_fck",
-	NULL
-};
-
-static struct clk *omap3_dm_source_clocks[2];
-static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
-
-#else
-#define omap3_dm_timers			NULL
-#define omap3_dm_timer_count		0
-#define omap3_dm_source_names		NULL
-#define omap3_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP3 */
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
-	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
-	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
-	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
-	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
-	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
-	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
-	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
-	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
-	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
-};
-static const char *omap4_dm_source_names[] __initdata = {
-	"sys_clkin_ck",
-	"sys_32k_ck",
-	NULL
-};
-static struct clk *omap4_dm_source_clocks[2];
-static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
+#include <linux/err.h>
 
-#else
-#define omap4_dm_timers			NULL
-#define omap4_dm_timer_count		0
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP4 */
-
-static struct omap_dm_timer *dm_timers;
-static const char **dm_source_names;
-static struct clk **dm_source_clocks;
+#include <plat/dmtimer.h>
 
-static spinlock_t dm_timer_lock;
 static LIST_HEAD(omap_timer_list);
+static DEFINE_SPINLOCK(dm_timer_lock);
 
-/*
- * Reads timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode write pending bit must be
- * checked. Otherwise a read of a non completed write will produce an error.
+/**
+ * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which read operation to perform
+ * @reg:        lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
  */
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
@@ -157,11 +59,15 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 	return __omap_dm_timer_read(timer, reg, timer->posted);
 }
 
-/*
- * Writes timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode the write pending bit must be
- * checked. Otherwise a write on a register which has a pending write will be
- * lost.
+/**
+ * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
  */
 static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
@@ -189,53 +95,65 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	int autoidle = 0, wakeup = 0;
-
-	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
+	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
-	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-
-	/* Enable autoidle on OMAP2+ */
-	if (cpu_class_is_omap2())
-		autoidle = 1;
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		wakeup = 1;
 
-	__omap_dm_timer_reset(timer, autoidle, wakeup);
+	__omap_dm_timer_reset(timer, 0, 0);
 	timer->posted = 1;
 }
 
-void omap_dm_timer_prepare(struct omap_dm_timer *timer)
+int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int ret;
+
+	timer->fclk = clk_get(&timer->pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+		return -EINVAL;
+	}
+
 	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
+
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(timer);
+
+	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	timer->posted = 1;
+	return ret;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	struct omap_dm_timer *timer = NULL;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
-	int i;
+	int ret = 0;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	for (i = 0; i < dm_timer_count; i++) {
-		if (dm_timers[i].reserved)
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->reserved)
 			continue;
 
-		timer = &dm_timers[i];
+		timer = t;
 		timer->reserved = 1;
 		break;
 	}
+
+	if (timer) {
+		ret = omap_dm_timer_prepare(timer);
+		if (ret) {
+			timer->reserved = 0;
+			timer = NULL;
+		}
+	}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (timer != NULL)
-		omap_dm_timer_prepare(timer);
+	if (!timer)
+		pr_debug("%s: timer request failed!\n", __func__);
 
 	return timer;
 }
@@ -243,23 +161,30 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
-		spin_unlock_irqrestore(&dm_timer_lock, flags);
-		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
-		       __FILE__, __LINE__, __func__, id);
-		dump_stack();
-		return NULL;
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->pdev->id == id && !t->reserved) {
+			timer = t;
+			timer->reserved = 1;
+			break;
+		}
 	}
 
-	timer = &dm_timers[id-1];
-	timer->reserved = 1;
+	if (timer) {
+		ret = omap_dm_timer_prepare(timer);
+		if (ret) {
+			timer->reserved = 0;
+			timer = NULL;
+		}
+	}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	omap_dm_timer_prepare(timer);
+	if (!timer)
+		pr_debug("%s: timer%d request failed!\n", __func__, id);
 
 	return timer;
 }
@@ -267,9 +192,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
 	omap_dm_timer_disable(timer);
+	clk_put(timer->fclk);
 
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
@@ -278,15 +202,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
+	if (!pdata->needs_manual_reset) {
 		clk_enable(timer->fclk);
 		clk_enable(timer->iclk);
 	}
-#endif
 
 	timer->enabled = 1;
 }
@@ -294,15 +218,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (!timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
+	if (!pdata->needs_manual_reset) {
 		clk_disable(timer->iclk);
 		clk_disable(timer->fclk);
 	}
-#endif
 
 	timer->enabled = 0;
 }
@@ -322,24 +246,29 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
  */
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
-	int i;
+	int i = 0;
+	struct omap_dm_timer *timer = NULL;
+	unsigned long flags;
 
 	/* If ARMXOR cannot be idled this function call is unnecessary */
 	if (!(inputmask & (1 << 1)))
 		return inputmask;
 
 	/* If any active timer is using ARMXOR return modified mask */
-	for (i = 0; i < dm_timer_count; i++) {
+	spin_lock_irqsave(&dm_timer_lock, flags);
+	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
 
-		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
 			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
 			else
 				inputmask &= ~(1 << 2);
 		}
+		i++;
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	return inputmask;
 }
@@ -384,10 +313,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	rate = clk_get_rate(timer->fclk);
-#endif
+	if (!pdata->needs_manual_reset)
+		rate = clk_get_rate(timer->fclk);
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 }
@@ -395,15 +324,17 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
+	int ret;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	return __omap_dm_timer_set_source(timer->fclk,
-						dm_source_clocks[source]);
-#else
-	return 0;
-#endif
+	omap_dm_timer_disable(timer);
+	ret = pdata->set_timer_src(timer->pdev, source);
+	omap_dm_timer_enable(timer);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
@@ -526,13 +457,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
 int omap_dm_timers_active(void)
 {
-	int i;
-
-	for (i = 0; i < dm_timer_count; i++) {
-		struct omap_dm_timer *timer;
-
-		timer = &dm_timers[i];
+	struct omap_dm_timer *timer;
 
+	list_for_each_entry(timer, &omap_timer_list, node) {
 		if (!timer->enabled)
 			continue;
 
@@ -602,7 +529,6 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 	timer->id = pdev->id;
 	timer->irq = irq->start;
 	timer->pdev = pdev;
-	__omap_dm_timer_init_regs(timer);
 
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
@@ -675,73 +601,3 @@ MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-
-static int __init omap_dm_timer_init(void)
-{
-	struct omap_dm_timer *timer;
-	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-
-	if (!cpu_class_is_omap2())
-		return -ENODEV;
-
-	spin_lock_init(&dm_timer_lock);
-
-	if (cpu_is_omap24xx()) {
-		dm_timers = omap2_dm_timers;
-		dm_timer_count = omap2_dm_timer_count;
-		dm_source_names = omap2_dm_source_names;
-		dm_source_clocks = omap2_dm_source_clocks;
-	} else if (cpu_is_omap34xx()) {
-		dm_timers = omap3_dm_timers;
-		dm_timer_count = omap3_dm_timer_count;
-		dm_source_names = omap3_dm_source_names;
-		dm_source_clocks = omap3_dm_source_clocks;
-	} else if (cpu_is_omap44xx()) {
-		dm_timers = omap4_dm_timers;
-		dm_timer_count = omap4_dm_timer_count;
-		dm_source_names = omap4_dm_source_names;
-		dm_source_clocks = omap4_dm_source_clocks;
-
-		pr_err("dmtimers disabled for omap4 until hwmod conversion\n");
-		return -ENODEV;
-	}
-
-	if (cpu_class_is_omap2())
-		for (i = 0; dm_source_names[i] != NULL; i++)
-			dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
-
-	if (cpu_is_omap243x())
-		dm_timers[0].phys_base = 0x49018000;
-
-	for (i = 0; i < dm_timer_count; i++) {
-		timer = &dm_timers[i];
-
-		/* Static mapping, never released */
-		timer->io_base = ioremap(timer->phys_base, map_size);
-		BUG_ON(!timer->io_base);
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if (cpu_class_is_omap2()) {
-			char clk_name[16];
-			sprintf(clk_name, "gpt%d_ick", i + 1);
-			timer->iclk = clk_get(NULL, clk_name);
-			sprintf(clk_name, "gpt%d_fck", i + 1);
-			timer->fclk = clk_get(NULL, clk_name);
-		}
-
-		/* One or two timers may be set up early for sys_timer */
-		if (sys_timer_reserved & (1  << i)) {
-			timer->reserved = 1;
-			timer->posted = 1;
-			continue;
-		}
-#endif
-		omap_dm_timer_enable(timer);
-		__omap_dm_timer_init_regs(timer);
-		omap_dm_timer_disable(timer);
-	}
-
-	return 0;
-}
-
-arch_initcall(omap_dm_timer_init);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 98f186e..2ac7538 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -231,9 +231,8 @@ struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
 	int irq;
-#ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
-#endif
+
 	void __iomem	*io_base;
 	void __iomem	*sys_stat;	/* TISTAT timer status */
 	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
@@ -251,7 +250,7 @@ struct omap_dm_timer {
 };
 
 extern u32 sys_timer_reserved;
-void omap_dm_timer_prepare(struct omap_dm_timer *timer);
+int omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
