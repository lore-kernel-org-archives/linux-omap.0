From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Wed,  9 Mar 2011 05:15:45 +0530
Message-ID: <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51429 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740Ab1CHXnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 18:43:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28NhRID025331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 17:43:30 -0600
In-Reply-To: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

switch-over to platform device driver through following changes:
(a) initiate dmtimer early initialization from omap2_gp_timer_init()
in timer-gp.c. This is equivalent of timer_init()->timer->init().
(b) modify plat-omap/dmtimer routines to use new register map and
platform data.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c      |    2 +-
 arch/arm/mach-omap2/clock2430_data.c      |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c      |    2 +-
 arch/arm/mach-omap2/dmtimer.c             |   89 ++++++++-
 arch/arm/mach-omap2/timer-gp.c            |   12 +-
 arch/arm/plat-omap/dmtimer.c              |  336 +++++++++--------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    5 +-
 8 files changed, 198 insertions(+), 252 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index ee93d3c..31373ab 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1801,7 +1801,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
+	CLK("omap_timer.1",	"gpt1_fck",	&gpt1_fck,	CK_242X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
 	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 899a3f6..a0a7f51 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1905,7 +1905,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
+	CLK("omap_timer.1",	"gpt1_fck",	&gpt1_fck,	CK_243X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
 	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_243X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f84a649..cf973ca 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3374,7 +3374,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("ehci-omap.0",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK("omap_timer.1",	"fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 0a6d80c..74de632 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3181,7 +3181,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
+	CLK("omap_timer.1",	"fck",			&timer1_fck,	CK_443X),
 	CLK("omap_timer.10",	"fck",			&timer10_fck,	CK_443X),
 	CLK("omap_timer.11",	"fck",			&timer11_fck,	CK_443X),
 	CLK("omap_timer.2",	"fck",			&timer2_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
index 60c410b..abd48e9 100755
--- a/arch/arm/mach-omap2/dmtimer.c
+++ b/arch/arm/mach-omap2/dmtimer.c
@@ -167,6 +167,71 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 }
 
 /**
+ * omap2_system_timer_init - top level system timer initialization
+ * called from omap2_gp_timer_init() in timer-gp.c
+ * @id	: system timer id
+ *
+ * This function does hwmod setup for the system timer entry needed
+ * prior to building and registering the device. After the device is
+ * registered early probe initiated.
+ */
+int __init omap2_system_timer_init(u8 id)
+{
+	int ret = 0;
+	char *name = "omap_timer";
+	struct dmtimer_platform_data *pdata;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	char system_timer_name[8]; /* 8 = sizeof("timerXX0") */
+
+	system_timer_id = id;
+
+	sprintf(system_timer_name, "timer%d", id);
+	ret = omap_hwmod_setup_one(system_timer_name);
+	if (ret) {
+		pr_err("%s: omap_hwmod_setup_one(%s) failed.\n",
+				__func__, system_timer_name);
+		return ret;
+	}
+	oh = omap_hwmod_lookup(system_timer_name);
+	if (!oh) {
+		pr_debug("%s: could not find (%s) in omap_hwmod_list!\n",
+			__func__, system_timer_name);
+		return -EINVAL;
+	}
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+	pdata->is_early_init = 1;
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+	pdata->timer_ip_type = oh->class->rev;
+	pdata->needs_manual_reset = 0;
+
+	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency),
+			pdata->is_early_init);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Can't build omap_device for %s: %s.\n",
+			__func__, name, oh->name);
+		ret = -EINVAL;
+	}
+
+	kfree(pdata);
+
+	if (!ret) {
+		early_platform_driver_register_all("earlytimer");
+		early_platform_driver_probe("earlytimer", 1, 0);
+	}
+
+	return 0;
+}
+
+/**
  * omap2_system_timer_set_src - change the timer input clock source
  * Allow system timer to program clock source before pm_runtime
  * framework is available during system boot.
@@ -177,10 +242,8 @@ int __init omap2_system_timer_set_src(struct omap_dm_timer *timer, int source)
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(timer)) {
-		pr_warning("%s: invalid timer pointer.\n", __func__);
+	if (IS_ERR_OR_NULL(timer) || IS_ERR_OR_NULL(timer->fclk))
 		return -EINVAL;
-	}
 
 	clk_disable(timer->fclk);
 	ret = omap2_dm_timer_set_src(timer->pdev, source);
@@ -188,3 +251,23 @@ int __init omap2_system_timer_set_src(struct omap_dm_timer *timer, int source)
 
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
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 3b9cf85..bb5b3c5 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -44,7 +44,7 @@
 #include <plat/omap_hwmod.h>
 
 #include "timer-gp.h"
-
+#include "dmtimer.h"
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
@@ -134,13 +134,9 @@ static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
 	int src;
-	char clockevent_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
 
 	inited = 1;
 
-	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
-	omap_hwmod_setup_one(clockevent_hwmod_name);
-
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 	gptimer_wakeup = gptimer;
@@ -154,8 +150,8 @@ static void __init omap2_gp_clockevent_init(void)
 #endif
 
 	if (gptimer_id != 12)
-		WARN(IS_ERR_VALUE(omap_dm_timer_set_source(gptimer, src)),
-		     "timer-gp: omap_dm_timer_set_source() failed\n");
+		WARN(IS_ERR_VALUE(omap2_system_timer_set_src(gptimer, src)),
+		     "timer-gp: omap2_system_timer_set_src() failed\n");
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
@@ -255,7 +251,7 @@ static void __init omap2_gp_timer_init(void)
 		BUG_ON(!twd_base);
 	}
 #endif
-	omap_dm_timer_init();
+	omap2_system_timer_init(gptimer_id);
 
 	omap2_gp_clockevent_init();
 	omap2_gp_clocksource_init();
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 51dc0b6..6ac6ce7 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,7 +43,6 @@
 #include <linux/platform_device.h>
 
 #include <plat/dmtimer.h>
-#include <mach/irqs.h>
 
 /* register offsets */
 #define _OMAP_TIMER_ID_OFFSET		0x00
@@ -161,117 +160,25 @@
 #define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET     0x14
 #define VERSION2_TIMER_STAT_REG_OFFSET          0x10
 
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
-
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
-
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
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
 	if (timer->posted)
 		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
 				& (reg >> WPSHIFT))
@@ -279,15 +186,24 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 	return readl(timer->io_base + (reg & 0xff));
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
 {
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
 	if (timer->posted)
 		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
 				& (reg >> WPSHIFT))
@@ -313,54 +229,67 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	u32 l;
 
-	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
+	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
-	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
 	l |= 0x02 << 3;  /* Set to smart-idle mode */
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		l |= 1 << 2;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
-
-	/* Match hardware reset default of posted mode */
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
-			OMAP_TIMER_CTRL_POSTED);
-	timer->posted = 1;
 }
 
 static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	timer->fclk = clk_get(&timer->pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+		return;
+	}
+
+	if (unlikely(pdata->is_early_init)) {
+		clk_enable(timer->fclk);
+		goto end;
+	}
+
 	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
+
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(timer);
+
+	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+end:
+	/* Match hardware reset default of posted mode */
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+			OMAP_TIMER_CTRL_POSTED);
+	timer->posted = 1;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	struct omap_dm_timer *timer = NULL;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
-	int i;
 
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
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (timer != NULL)
+	if (timer)
 		omap_dm_timer_prepare(timer);
+	else
+		pr_debug("%s: free timer not available.\n", __func__);
 
 	return timer;
 }
@@ -368,23 +297,23 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer;
+	struct omap_dm_timer *timer = NULL, *t;
 	unsigned long flags;
 
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
-
-	timer = &dm_timers[id-1];
-	timer->reserved = 1;
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	omap_dm_timer_prepare(timer);
+	if (timer)
+		omap_dm_timer_prepare(timer);
+	else
+		pr_debug("%s: timer%d not available.\n", __func__, id);
 
 	return timer;
 }
@@ -392,10 +321,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
 	omap_dm_timer_disable(timer);
 
+	clk_put(timer->fclk);
+
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 }
@@ -406,12 +335,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 	if (timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
-	}
-#endif
+	clk_enable(timer->fclk);
 
 	timer->enabled = 1;
 }
@@ -422,12 +346,7 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 	if (!timer->enabled)
 		return;
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_class_is_omap2()) {
-		clk_disable(timer->iclk);
-		clk_disable(timer->fclk);
-	}
-#endif
+	clk_disable(timer->fclk);
 
 	timer->enabled = 0;
 }
@@ -447,24 +366,30 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
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
+
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
@@ -509,20 +434,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	u32 l;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-		 /*
-		  * Wait for functional clock period x 3.5 to make sure that
-		  * timer is stopped
-		  */
-		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
-#endif
+
+		if (!pdata->needs_manual_reset) {
+			/* Readback to make sure write has completed */
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+			/*
+			 * Wait for functional clock period x 3.5 to make
+			 * sure that timer is stopped
+			 */
+			udelay(3500000 / clk_get_rate(timer->fclk) + 1);
+		}
 	}
 	/* Ack possibly pending interrupt */
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
@@ -533,13 +460,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret = -EINVAL;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	clk_disable(timer->fclk);
-	ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
-	clk_enable(timer->fclk);
+	omap_dm_timer_disable(timer);
+	/* change the timer clock source */
+	ret = pdata->set_timer_src(timer->pdev, source);
+	omap_dm_timer_enable(timer);
 
 	/*
 	 * When the functional clock disappears, too quick writes seem
@@ -676,13 +605,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
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
 
@@ -843,58 +768,3 @@ MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-
-int __init omap_dm_timer_init(void)
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
-#endif
-	}
-
-	return 0;
-}
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index c184bf0..f77d3b8 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -62,10 +62,9 @@ struct omap_secure_timer_dev_attr {
 };
 
 struct omap_dm_timer {
-	unsigned long phys_base;
 	int id;
 	int irq;
-	struct clk *iclk, *fclk;
+	struct clk *fclk;
 	void __iomem *io_base;
 	unsigned reserved:1;
 	unsigned enabled:1;
@@ -87,8 +86,6 @@ struct dmtimer_platform_data {
 	u32 needs_manual_reset:1;
 };
 
-int omap_dm_timer_init(void);
-
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 void omap_dm_timer_free(struct omap_dm_timer *timer);
-- 
1.6.0.4

