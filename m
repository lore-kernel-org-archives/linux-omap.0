From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/14] ARM: OMAP: Timer32K: Re-organize duplicated 32k-timer code
Date: Mon, 17 Mar 2008 11:42:33 +0200
Message-ID: <1205746958-11242-10-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
 <1205746958-11242-8-git-send-email-tony@atomide.com>
 <1205746958-11242-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62554 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbYCQJnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:41 -0400
In-Reply-To: <1205746958-11242-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

=46rom: Kevin Hilman <khilman@mvista.com>

On OMAP2/3, the gp-timer code can be used for a 32kHz timer simply by
setting the source to be the 32k clock instead of sys_clk.

This patch uses the mach-omap2/timer-gp.c code for 32kHz timer on
OMAP2, moving the logic into mach-omap2/timer-gp.c, and not using
plat-omap/timer32k.c which, for OMAP2, is redundant with the timer-gp
code.

Also, if CONFIG_OMAP_32K_TIMER is enabled, the gptimer-based
clocksource is not used.  Instead the default 32k sync counter is used
as the clocksource (see the clocksource in plat-omap/common.c.)  This
is important for sleep/suspend so there is a valid counter during
sleep.  Note that the suspend/sleep code needs fixing to check for
overflows of this counter.

In addition, the OMAP2/3 details are removed from timer32k.c leaving
that with only OMAP1 specifics.  A follow-up patch will move it from
plat-omap common code to mach-omap1.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile   |    4 +-
 arch/arm/mach-omap2/timer-gp.c |  152 ++++++++++++++++++++++++++++++++=
++++----
 arch/arm/plat-omap/Makefile    |    2 +
 arch/arm/plat-omap/timer32k.c  |   44 +-----------
 4 files changed, 141 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index b05b738..ac343ec 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,9 +4,7 @@
=20
 # Common support
 obj-y :=3D irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o dev=
ices.o \
-	 serial.o gpmc.o
-
-obj-$(CONFIG_OMAP_MPU_TIMER)		+=3D timer-gp.o
+	 serial.o gpmc.o timer-gp.o
=20
 # Power Management
 obj-$(CONFIG_PM) +=3D pm.o pm-domain.o sleep.o
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer=
-gp.c
index 3234dee..78d05f2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -3,6 +3,11 @@
  *
  * OMAP2 GP timer support.
  *
+ * Update to use new clocksource/clockevent layers
+ * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2007 MontaVista Software, Inc.
+ *
+ * Original driver:
  * Copyright (C) 2005 Nokia Corporation
  * Author: Paul Mundt <paul.mundt@nokia.com>
  *         Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
@@ -25,24 +30,23 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
=20
 #include <asm/mach/time.h>
 #include <asm/arch/dmtimer.h>
=20
 static struct omap_dm_timer *gptimer;
-
-static inline void omap2_gp_timer_start(unsigned long load_val)
-{
-	omap_dm_timer_set_load(gptimer, 1, 0xffffffff - load_val);
-	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
-	omap_dm_timer_start(gptimer);
-}
+static struct clock_event_device clockevent_gpt;
=20
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
-	omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
-	timer_tick();
+	struct omap_dm_timer *gpt =3D (struct omap_dm_timer *)dev_id;
+	struct clock_event_device *evt =3D &clockevent_gpt;
+
+	omap_dm_timer_write_status(gpt, OMAP_TIMER_INT_OVERFLOW);
=20
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
=20
@@ -52,20 +56,138 @@ static struct irqaction omap2_gp_timer_irq =3D {
 	.handler	=3D omap2_gp_timer_interrupt,
 };
=20
-static void __init omap2_gp_timer_init(void)
+static int omap2_gp_timer_set_next_event(unsigned long cycles,
+					 struct clock_event_device *evt)
 {
-	u32 tick_period;
+	omap_dm_timer_set_load(gptimer, 0, 0xffffffff - cycles);
+	omap_dm_timer_start(gptimer);
+
+	return 0;
+}
+
+static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	u32 period;
+
+	omap_dm_timer_stop(gptimer);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		period =3D clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
+		period -=3D 1;
+
+		omap_dm_timer_set_load(gptimer, 1, 0xffffffff - period);
+		omap_dm_timer_start(gptimer);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_gpt =3D {
+	.name		=3D "gp timer",
+	.features       =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.shift		=3D 32,
+	.set_next_event	=3D omap2_gp_timer_set_next_event,
+	.set_mode	=3D omap2_gp_timer_set_mode,
+};
+
+static void __init omap2_gp_clockevent_init(void)
+{
+	u32 tick_rate;
=20
-	omap_dm_timer_init();
 	gptimer =3D omap_dm_timer_request_specific(1);
 	BUG_ON(gptimer =3D=3D NULL);
=20
+#if defined(CONFIG_OMAP_32K_TIMER)
+	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
+#else
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
-	tick_period =3D clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
-	tick_period -=3D 1;
+#endif
+	tick_rate =3D clk_get_rate(omap_dm_timer_get_fclk(gptimer));
=20
+	omap2_gp_timer_irq.dev_id =3D (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
-	omap2_gp_timer_start(tick_period);
+	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
+
+	clockevent_gpt.mult =3D div_sc(tick_rate, NSEC_PER_SEC,
+				     clockevent_gpt.shift);
+	clockevent_gpt.max_delta_ns =3D
+		clockevent_delta2ns(0xffffffff, &clockevent_gpt);
+	clockevent_gpt.min_delta_ns =3D
+		clockevent_delta2ns(1, &clockevent_gpt);
+
+	clockevent_gpt.cpumask =3D cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_gpt);
+}
+
+#ifdef CONFIG_OMAP_32K_TIMER
+/*=20
+ * When 32k-timer is enabled, don't use GPTimer for clocksource
+ * instead, just leave default clocksource which uses the 32k
+ * sync counter.  See clocksource setup in see plat-omap/common.c.=20
+ */
+
+static inline void __init omap2_gp_clocksource_init(void) {}
+#else
+/*
+ * clocksource
+ */
+static struct omap_dm_timer *gpt_clocksource;
+static cycle_t clocksource_read_cycles(void)
+{
+	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
+}
+
+static struct clocksource clocksource_gpt =3D {
+	.name		=3D "gp timer",
+	.rating		=3D 300,
+	.read		=3D clocksource_read_cycles,
+	.mask		=3D CLOCKSOURCE_MASK(32),
+	.shift		=3D 24,
+	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/* Setup free-running counter for clocksource */
+static void __init omap2_gp_clocksource_init(void)
+{
+	static struct omap_dm_timer *gpt;
+	u32 tick_rate, tick_period;
+	static char err1[] __initdata =3D KERN_ERR
+		"%s: failed to request dm-timer\n";
+	static char err2[] __initdata =3D KERN_ERR
+		"%s: can't register clocksource!\n";
+
+	gpt =3D omap_dm_timer_request();
+	if (!gpt)
+		printk(err1, clocksource_gpt.name);
+	gpt_clocksource =3D gpt;
+
+	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
+	tick_rate =3D clk_get_rate(omap_dm_timer_get_fclk(gpt));
+	tick_period =3D (tick_rate / HZ) - 1;
+
+	omap_dm_timer_set_load(gpt, 1, 0);
+	omap_dm_timer_start(gpt);
+
+	clocksource_gpt.mult =3D
+		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
+	if (clocksource_register(&clocksource_gpt))
+		printk(err2, clocksource_gpt.name);
+}
+#endif
+
+static void __init omap2_gp_timer_init(void)
+{
+	omap_dm_timer_init();
+
+	omap2_gp_clockevent_init();
+	omap2_gp_clocksource_init();
 }
=20
 struct sys_timer omap_timer =3D {
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 8f56c25..d91424e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -9,7 +9,9 @@ obj-m :=3D
 obj-n :=3D
 obj-  :=3D
=20
+ifeq ($(CONFIG_ARCH_OMAP1),y)
 obj-$(CONFIG_OMAP_32K_TIMER)	+=3D timer32k.o
+endif
=20
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32=
k.c
index ea76f19..ce034dc 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -40,6 +40,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
@@ -93,8 +94,6 @@ struct sys_timer omap_timer;
 #define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
 				(((nr_jiffies) * (clock_rate)) / HZ)
=20
-#if defined(CONFIG_ARCH_OMAP1)
-
 static inline void omap_32k_timer_write(int val, int reg)
 {
 	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
@@ -120,30 +119,6 @@ static inline void omap_32k_timer_stop(void)
=20
 #define omap_32k_timer_ack_irq()
=20
-#elif defined(CONFIG_ARCH_OMAP2)
-
-static struct omap_dm_timer *gptimer;
-
-static inline void omap_32k_timer_start(unsigned long load_val)
-{
-	omap_dm_timer_set_load(gptimer, 1, 0xffffffff - load_val);
-	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
-	omap_dm_timer_start(gptimer);
-}
-
-static inline void omap_32k_timer_stop(void)
-{
-	omap_dm_timer_stop(gptimer);
-}
-
-static inline void omap_32k_timer_ack_irq(void)
-{
-	u32 status =3D omap_dm_timer_read_status(gptimer);
-	omap_dm_timer_write_status(gptimer, status);
-}
-
-#endif
-
 static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
@@ -222,23 +197,6 @@ static struct irqaction omap_32k_timer_irq =3D {
=20
 static __init void omap_init_32k_timer(void)
 {
-	if (cpu_class_is_omap1())
-		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-
-#ifdef CONFIG_ARCH_OMAP2
-	/* REVISIT: Check 24xx TIOCP_CFG settings after idle works */
-	if (cpu_is_omap24xx()) {
-		gptimer =3D omap_dm_timer_request_specific(1);
-		BUG_ON(gptimer =3D=3D NULL);
-
-		omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
-		setup_irq(omap_dm_timer_get_irq(gptimer), &omap_32k_timer_irq);
-		omap_dm_timer_set_int_enable(gptimer,
-			OMAP_TIMER_INT_CAPTURE | OMAP_TIMER_INT_OVERFLOW |
-			OMAP_TIMER_INT_MATCH);
-	}
-#endif
-
 	clockevent_32k_timer.mult =3D div_sc(OMAP_32K_TICKS_PER_SEC,
 					   NSEC_PER_SEC,
 					   clockevent_32k_timer.shift);
--=20
1.5.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
