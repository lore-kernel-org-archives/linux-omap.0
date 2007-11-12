From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/3] ARM: OMAP: re-organize duplicated 32k-timer code
Date: Mon, 12 Nov 2007 10:22:10 -0800
Message-ID: <20071112182311.176392806@mvista.com>
References: <20071112182209.262757465@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=use-dmtimer-for-32k-timer.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
---
 arch/arm/mach-omap2/Makefile   |    4 ---
 arch/arm/mach-omap2/timer-gp.c |   14 ++++++++++++
 arch/arm/plat-omap/Makefile    |    2 +
 arch/arm/plat-omap/timer32k.c  |   47 -----------------------------------------
 4 files changed, 18 insertions(+), 49 deletions(-)

Index: dev/arch/arm/mach-omap2/Makefile
===================================================================
--- dev.orig/arch/arm/mach-omap2/Makefile
+++ dev/arch/arm/mach-omap2/Makefile
@@ -4,9 +4,7 @@
 
 # Common support
 obj-y := irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o devices.o \
-	 serial.o gpmc.o
-
-obj-$(CONFIG_OMAP_MPU_TIMER)		+= timer-gp.o
+	 serial.o gpmc.o timer-gp.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
Index: dev/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/timer-gp.c
+++ dev/arch/arm/mach-omap2/timer-gp.c
@@ -104,7 +104,11 @@ static void __init omap2_gp_clockevent_i
 	gptimer = omap_dm_timer_request_specific(1);
 	BUG_ON(gptimer == NULL);
 
+#if defined(CONFIG_OMAP_32K_TIMER)
+	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
+#else
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
+#endif
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
@@ -122,6 +126,15 @@ static void __init omap2_gp_clockevent_i
 	clockevents_register_device(&clockevent_gpt);
 }
 
+#ifdef CONFIG_OMAP_32K_TIMER
+/* 
+ * When 32k-timer is enabled, don't use GPTimer for clocksource
+ * instead, just leave default clocksource which uses the 32k
+ * sync counter.  See clocksource setup in see plat-omap/common.c. 
+ */
+
+static inline void __init omap2_gp_clocksource_init(void) {}
+#else
 /*
  * clocksource
  */
@@ -167,6 +180,7 @@ static void __init omap2_gp_clocksource_
 	if (clocksource_register(&clocksource_gpt))
 		printk(err2, clocksource_gpt.name);
 }
+#endif
 
 static void __init omap2_gp_timer_init(void)
 {
Index: dev/arch/arm/plat-omap/Makefile
===================================================================
--- dev.orig/arch/arm/plat-omap/Makefile
+++ dev/arch/arm/plat-omap/Makefile
@@ -9,7 +9,9 @@ obj-m :=
 obj-n :=
 obj-  :=
 
+ifeq ($(CONFIG_ARCH_OMAP1),y)
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
+endif
 
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
Index: dev/arch/arm/plat-omap/timer32k.c
===================================================================
--- dev.orig/arch/arm/plat-omap/timer32k.c
+++ dev/arch/arm/plat-omap/timer32k.c
@@ -70,10 +70,6 @@ struct sys_timer omap_timer;
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
-#elif defined(CONFIG_ARCH_OMAP34XX)
-#define TIMER_32K_SYNCHRONIZED		0x48320010
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
@@ -95,8 +91,6 @@ struct sys_timer omap_timer;
 #define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
 				(((nr_jiffies) * (clock_rate)) / HZ)
 
-#if defined(CONFIG_ARCH_OMAP1)
-
 static inline void omap_32k_timer_write(int val, int reg)
 {
 	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
@@ -122,30 +116,6 @@ static inline void omap_32k_timer_stop(v
 
 #define omap_32k_timer_ack_irq()
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
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
-	u32 status = omap_dm_timer_read_status(gptimer);
-	omap_dm_timer_write_status(gptimer, status);
-}
-
-#endif
-
 static int omap_32k_timer_set_next_event(unsigned long delta,
 					 struct clock_event_device *dev)
 {
@@ -233,22 +203,7 @@ static struct irqaction omap_32k_timer_i
 
 static __init void omap_init_32k_timer(void)
 {
-	if (cpu_class_is_omap1())
-		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	/* REVISIT: Check 24xx TIOCP_CFG settings after idle works */
-	if (cpu_class_is_omap2()) {
-		gptimer = omap_dm_timer_request_specific(1);
-		BUG_ON(gptimer == NULL);
-
-		omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
-		setup_irq(omap_dm_timer_get_irq(gptimer), &omap_32k_timer_irq);
-		omap_dm_timer_set_int_enable(gptimer,
-			OMAP_TIMER_INT_CAPTURE | OMAP_TIMER_INT_OVERFLOW |
-			OMAP_TIMER_INT_MATCH);
-	}
-#endif
+	setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
 
 	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
 					   NSEC_PER_SEC,

--
