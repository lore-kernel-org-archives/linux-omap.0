From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 13/17] dmtimer: switch-over to platform device driver with hwmod
Date: Tue, 21 Sep 2010 14:25:26 +0530
Message-ID: <1285059326-26618-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0ITVyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 17:54:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch makes dmtimer switch-over to platform device driver
through following changes:
(1) call to dmtimer initialization routine from timer-gp.c is
removed.
(2) initiate dmtimer early initialization from omap2_init_common_hw
in io.c
(3) modify plat-omap/dmtimer routines to use new register map and
platform data.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    6 +-
 arch/arm/mach-omap2/clock2430_data.c |    6 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    6 +-
 arch/arm/mach-omap2/clock44xx_data.c |    6 +-
 arch/arm/mach-omap2/io.c             |    2 +
 arch/arm/mach-omap2/timer-gp.c       |    1 -
 arch/arm/plat-omap/dmtimer.c         |  192 +++++++++++++++-------------------
 7 files changed, 92 insertions(+), 127 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 6378e6d..7722da5 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1765,11 +1765,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
-	/*
-	 * gpt1 will be modified in subsequent patch when dmtimers
-	 * will be fully converted to platform device
-	 */
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_242X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
 	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index ae9b44e..a81d071 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1851,11 +1851,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
-	/*
-	 * gpt1 will be modified in subsequent patch when dmtimers
-	 * will be fully converted to platform device
-	 */
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_243X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
 	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_243X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1cdcaf5..c140be3 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3334,11 +3334,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	/*
-	 * gpt1 will be changed in subsequent patch when dmtimer
-	 * is fully converted to platform device.
-	 */
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK("dmtimer.0",	"fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 7398158..24e4dc3 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2574,11 +2574,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	/*
-	 * gpt1 will be changed in subsequent patch when dmtimer
-	 * will be fully converted to platform device.
-	 */
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
+	CLK("dmtimer.0",	"fck",		&timer1_fck,	CK_443X),
 	CLK("dmtimer.9",	"fck",		&timer10_fck,	CK_443X),
 	CLK("dmtimer.10",	"fck",		&timer11_fck,	CK_443X),
 	CLK("dmtimer.1",	"fck",		&timer2_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 08e3a12..d6edbad 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -45,6 +45,7 @@
 #include "clockdomains.h"
 
 #include <plat/omap_hwmod.h>
+#include "dmtimer.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -350,4 +351,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
+	omap2_dm_timer_early_init();
 }
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..c2d8a0d 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,7 +231,6 @@ static void __init omap2_gp_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
 
 	omap2_gp_clockevent_init();
 	omap2_gp_clocksource_init();
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 2017b1d..360a751 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -48,6 +48,7 @@
 #include <linux/pm_runtime.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
+#include <linux/err.h>
 
 /* register offsets */
 #define _OMAP_TIMER_ID_OFFSET		0x00
@@ -84,67 +85,6 @@
 #define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
 #define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
 
-
-#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
-							| (WP_TCLR << WPSHIFT))
-
-#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
-							| (WP_TCRR << WPSHIFT))
-
-#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
-							| (WP_TLDR << WPSHIFT))
-
-#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
-							| (WP_TTGR << WPSHIFT))
-
-#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
-							| (WP_TMAR << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
-							| (WP_TPIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
-							| (WP_TNIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
-							| (WP_TCVR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
-
 struct omap_dm_timer {
 	int id;
 	unsigned long fclk_rate;
@@ -265,34 +205,48 @@ static struct clk **dm_source_clocks;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
 
-/*
- * Reads timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode write pending bit must be
- * checked. Otherwise a read of a non completed write will produce an error.
+/**
+ * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
+ * @timer:	timer pointer over which read operation to perform
+ * @reg:	lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
  */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
+static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u8 reg)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (readl(timer->io_base +
+			((pdata->reg_map[OMAP_TIMER_WRITE_PEND_REG]) & 0xff))
+				& (pdata->reg_map[reg] >> WPSHIFT))
 			cpu_relax();
-	return readl(timer->io_base + (reg & 0xff));
+	return readl(timer->io_base + (pdata->reg_map[reg] & 0xff));
 }
 
-/*
- * Writes timer registers in posted and non-posted mode. The posted mode bit
- * is encoded in reg. Note that in posted mode the write pending bit must be
- * checked. Otherwise a write on a register which has a pending write will be
- * lost.
+/**
+ * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
+ * @timer:	timer pointer over which write operation is to perform
+ * @reg:	lowest byte holds the register offset
+ * @value:	data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
  */
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u8 reg,
 						u32 value)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (readl(timer->io_base +
+			((pdata->reg_map[OMAP_TIMER_WRITE_PEND_REG]) & 0xff))
+				& (pdata->reg_map[reg] >> WPSHIFT))
 			cpu_relax();
-	writel(value, timer->io_base + (reg & 0xff));
+	writel(value, timer->io_base + (pdata->reg_map[reg] & 0xff));
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -397,15 +351,18 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
+	struct clk *timer_clk;
+
 	if (timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-#endif
+	timer_clk = clk_get(&timer->pdev->dev, "fck");
+	if (IS_ERR(timer_clk)) {
+		dev_err(&timer->pdev->dev,
+		"ERROR: no clk pointer to enable\n");
+		return;
+	} else
+		clk_enable(timer_clk);
 
 	timer->enabled = 1;
 }
@@ -413,15 +370,18 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
+	struct clk *timer_clk;
+
 	if (!timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-#endif
+	timer_clk = clk_get(&timer->pdev->dev, "fck");
+	if (IS_ERR(timer_clk)) {
+		dev_err(&timer->pdev->dev,
+		"ERROR: no clk pointer to disable\n");
+		return;
+	} else
+		clk_disable(timer_clk);
 
 	timer->enabled = 0;
 }
@@ -473,7 +433,12 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
-	return timer->fclk;
+	struct clk *timer_clk = clk_get(&timer->pdev->dev, "fck");
+
+	if (IS_ERR(timer_clk))
+		return ERR_PTR((int)timer_clk);
+	else
+		return timer_clk;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
@@ -520,7 +485,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		  * Wait for functional clock period x 3.5 to make sure that
 		  * timer is stopped
 		  */
-		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
+		udelay(3500000 / timer->fclk_rate + 1);
 #endif
 	}
 	/* Ack possibly pending interrupt */
@@ -529,27 +494,41 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
-
-
-
-
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
-	int ret = -EINVAL;
+	int ret = 0;
+	struct clk *timer_clk = NULL;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
-	if (source < 0 || source >= 3)
+	if (source < 0 || source >= NR_CLK_SOURCES)
 		return -EINVAL;
 
-#ifdef CONFIG_ARCH_OMAP1
-	if (pdata->set_timer_src)
-		ret = pdata->set_timer_src(timer->pdev, source);
-#else
-	clk_disable(timer->fclk);
-	ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
-	clk_enable(timer->fclk);
-#endif
+	timer_clk = clk_get(&timer->pdev->dev, "fck");
+	if (IS_ERR(timer_clk)) {
+		dev_err(&timer->pdev->dev,
+		"ERROR: no clk pointer to disable\n");
+		return -EINVAL;
+	} else
+		clk_disable(timer_clk); /* enabled in hwmod */
 
 	/*
+	 * change the timer clock source and
+	 * store the fclk_rate of the new clock source.
+	 */
+	ret = pdata->set_timer_src(timer->pdev, source);
+	if (!ret)
+		timer->fclk_rate = clk_get_rate(omap_dm_timer_get_fclk(timer));
+
+	/* enable timer clock again after timer clock source change */
+	if (unlikely(pdata->is_early_init))
+		clk_enable(timer_clk);
+	else {
+		if (pm_runtime_get_sync(&timer->pdev->dev))
+			dev_warn(&timer->pdev->dev,
+			"%s: pm_runtime_get_sync FAILED\n",
+			 __func__);
+	}
+	/*
 	 * When the functional clock disappears, too quick writes seem
 	 * to cause an abort. XXX Is this still necessary?
 	 */
@@ -935,6 +914,7 @@ static void __exit omap_dmtimer_driver_exit(void)
 	platform_driver_unregister(&omap_dmtimer_driver);
 }
 
+early_platform_init("earlytimer", &omap_dmtimer_driver);
 module_init(omap_dmtimer_driver_init);
 module_exit(omap_dmtimer_driver_exit);
 
-- 
1.6.0.4

