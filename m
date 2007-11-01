From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] ARM: OMAP: re-organize duplicated 32k-timer code
Date: Thu, 01 Nov 2007 15:09:15 -0700
Message-ID: <20071101220915.594218311@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

NOTE: timer32k.c was left in plat-omap for now so the diff would be
clearer, but if folks are OK with this, I'll move it into mach-omap1
and remove the omap2 stuff from it which can now be done much simpler,
and without redundancy in timer-gp.c.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/Makefile   |    4 +---
 arch/arm/mach-omap2/timer-gp.c |   14 ++++++++++++++
 arch/arm/plat-omap/Makefile    |    2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

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
--
