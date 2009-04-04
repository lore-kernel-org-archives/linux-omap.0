From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed
	in board-*.c files
Date: Sat, 04 Apr 2009 14:54:09 -0600
Message-ID: <20090404205408.12269.87596.stgit@localhost.localdomain>
References: <20090404205333.12269.76287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38005 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046AbZDDUzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 16:55:07 -0400
In-Reply-To: <20090404205333.12269.76287.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Add a function omap2_gp_clockevent_set_gptimer() for board-*.c files
to use in .init_irq functions to configure the system tick GPTIMER.
Practical choices at this point are GPTIMER1 or GPTIMER12.  Both of
these timers are in the WKUP powerdomain, and so are unaffected by
chip power management.  GPTIMER1 can use sys_clk as a source, for
applications where a high-resolution timer is more important than
power management.  GPTIMER12 has the special property that it has the
secure 32kHz oscillator as its source clock, which may be less prone
to glitches than the off-chip 32kHz oscillator.  But on HS devices, it
may not be available for Linux use.

It appears that most boards are fine with GPTIMER1, but BeagleBoard
should use GPTIMER12 when using a 32KiHz timer source, due to hardware bugs
in revisions B4 and below.  Modify board-omap3beagle.c to use GPTIMER12.

This patch originally used a Kbuild config option to select the GPTIMER,
but was changed to allow this to be specified in board-*.c files, per
Tony's request.

Tested on Beagle rev B4 ES2.1, with and without CONFIG_OMAP_32K_TIMER, and
3430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c    |    4 ++
 arch/arm/mach-omap2/clock24xx.c            |    1 +
 arch/arm/mach-omap2/clock24xx.h            |   10 +++++-
 arch/arm/mach-omap2/clock34xx.h            |    1 -
 arch/arm/mach-omap2/timer-gp.c             |   48 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/dmtimer.c               |   20 ++++++++----
 arch/arm/plat-omap/include/mach/dmtimer.h  |    2 +
 arch/arm/plat-omap/include/mach/timer-gp.h |   17 ++++++++++
 8 files changed, 91 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 744740a..3a7a29d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -42,6 +42,7 @@
 #include <mach/nand.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
+#include <mach/timer-gp.h>
 
 #include "mmc-twl4030.h"
 
@@ -186,6 +187,9 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
 	omap_init_irq();
+#ifdef CONFIG_OMAP_32K_TIMER
+	omap2_gp_clockevent_set_gptimer(12);
+#endif
 	omap_gpio_init();
 }
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e839c5..e20cd16 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -66,6 +66,7 @@ struct omap_clk {
 static struct omap_clk omap24xx_clks[] = {
 	/* external root sources */
 	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X | CK_242X),
 	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
 	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 33c3e5b..72003f7 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -625,6 +625,14 @@ static struct clk func_32k_ck = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
+static struct clk secure_32k_fck = {
+	.name		= "secure_32k_fck",
+	.ops		= &clkops_null,
+	.rate		= 32768,
+	.flags		= RATE_FIXED,
+	.clkdm_name	= "wkup_clkdm",
+};
+
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
@@ -1790,7 +1798,7 @@ static struct clk gpt12_ick = {
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
+	.parent		= &secure_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 70ec10d..62c9305 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2901,7 +2901,6 @@ static struct clk sr_l4_ick = {
 
 /* SECURE_32K_FCK clocks */
 
-/* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 9fc13a2..7835048 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -3,6 +3,8 @@
  *
  * OMAP2 GP timer support.
  *
+ * Copyright (C) 2009 Nokia Corporation
+ *
  * Update to use new clocksource/clockevent layers
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  * Copyright (C) 2007 MontaVista Software, Inc.
@@ -36,8 +38,13 @@
 #include <asm/mach/time.h>
 #include <mach/dmtimer.h>
 
+/* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
+#define MAX_GPTIMER_ID		12
+
 static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
+static u8 __initdata gptimer_id = 1;
+static u8 __initdata inited;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
@@ -95,20 +102,53 @@ static struct clock_event_device clockevent_gpt = {
 	.set_mode	= omap2_gp_timer_set_mode,
 };
 
+/**
+ * omap2_gp_clockevent_set_gptimer - set which GPTIMER is used for clockevents
+ * @id: GPTIMER to use (1..MAX_GPTIMER_ID)
+ *
+ * Define the GPTIMER that the system should use for the tick timer.
+ * Meant to be called from board-*.c files in the event that GPTIMER1, the
+ * default, is unsuitable.  Returns -EINVAL on error or 0 on success.
+ */
+int __init omap2_gp_clockevent_set_gptimer(u8 id)
+{
+	if (id < 1 || id > MAX_GPTIMER_ID)
+		return -EINVAL;
+
+	BUG_ON(inited);
+
+	gptimer_id = id;
+
+	return 0;
+}
+
 static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
+	int src;
+
+	inited = 1;
 
-	gptimer = omap_dm_timer_request_specific(1);
+	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
 
 #if defined(CONFIG_OMAP_32K_TIMER)
-	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
+	src = OMAP_TIMER_SRC_32_KHZ;
 #else
-	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
+	src = OMAP_TIMER_SRC_SYS_CLK;
+	WARN(gptimer_id == 12, "WARNING: GPTIMER12 can only use the "
+	     "secure 32KiHz clock source\n");
 #endif
+
+	if (gptimer_id != 12)
+		WARN(IS_ERR_VALUE(omap_dm_timer_set_source(gptimer, src)),
+		     "timer-gp: omap_dm_timer_set_source() failed\n");
+
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
+	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
+		gptimer_id, tick_rate);
+
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
 	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
@@ -125,6 +165,8 @@ static void __init omap2_gp_clockevent_init(void)
 	clockevents_register_device(&clockevent_gpt);
 }
 
+/* Clocksource code */
+
 #ifdef CONFIG_OMAP_32K_TIMER
 /* 
  * When 32k-timer is enabled, don't use GPTimer for clocksource
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c99d611..bf2b8ea 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -511,7 +511,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 #ifdef CONFIG_ARCH_OMAP1
 
-void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int n = (timer - dm_timers) << 1;
 	u32 l;
@@ -519,23 +519,31 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
 	l |= source << n;
 	omap_writel(l, MOD_CONF_CTRL_1);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #else
 
-void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
+	int ret = -EINVAL;
+
 	if (source < 0 || source >= 3)
-		return;
+		return -EINVAL;
 
 	clk_disable(timer->fclk);
-	clk_set_parent(timer->fclk, dm_source_clocks[source]);
+	ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
 	clk_enable(timer->fclk);
 
-	/* When the functional clock disappears, too quick writes seem to
-	 * cause an abort. */
+	/*
+	 * When the functional clock disappears, too quick writes seem
+	 * to cause an abort. XXX Is this still necessary?
+	 */
 	__delay(150000);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
diff --git a/arch/arm/plat-omap/include/mach/dmtimer.h b/arch/arm/plat-omap/include/mach/dmtimer.h
index 6dc7031..20f1054 100644
--- a/arch/arm/plat-omap/include/mach/dmtimer.h
+++ b/arch/arm/plat-omap/include/mach/dmtimer.h
@@ -64,7 +64,7 @@ void omap_dm_timer_trigger(struct omap_dm_timer *timer);
 void omap_dm_timer_start(struct omap_dm_timer *timer);
 void omap_dm_timer_stop(struct omap_dm_timer *timer);
 
-void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
 void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
 void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
 void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
diff --git a/arch/arm/plat-omap/include/mach/timer-gp.h b/arch/arm/plat-omap/include/mach/timer-gp.h
new file mode 100644
index 0000000..c88d346
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/timer-gp.h
@@ -0,0 +1,17 @@
+/*
+ * OMAP2/3 GPTIMER support.headers
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_TIMER_GP_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_TIMER_GP_H
+
+int __init omap2_gp_clockevent_set_gptimer(u8 id);
+
+#endif
+


