From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 1/2] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Sun, 18 Nov 2012 17:06:40 +0200
Message-ID: <1353251201-10990-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:48778 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab2KRPGw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Nov 2012 10:06:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

CONFIG_OMAP_32K_TIMER is kind of standing on the single zImage way.
Make OMAP2+ timer code independant from the CONFIG_OMAP_32K_TIMER
setting.
To remove the dependancy, several conversions/additions had to be done:
1) Timer initialization functions are named by the platform
   name and the clock source in use.
   This also makes it possible to define and use the GPTIMER as the
   clock source instead of the 32K timer on platforms that do not have
   the 32K timer ip block or the 32K timer is not wired on the board.
   Cirrently, the the timer is chosen in the machine_desc structure on
   per board basis. Later, DT should be used to choose the timer.
2) Settings under the CONFIG_OMAP_32K_TIMER option are used as defaults
   and those under !CONFIG_OMAP_32K_TIMER are removed.
   This removes the CONFIG_OMAP_32K_TIMER on OMAP2+ timer code.
3) Since we have all the timers defined inside machine_desc structure
   and we no longer need the fallback to gp_timer clock source in case
   32k_timer clock source is unavailable (namely on AM33xx), we no
   longer need the #ifdef around __omap2_sync32k_clocksource_init()
   function. Remove the #ifdef CONFIG_OMAP_32K_TIMER around the
   __omap2_sync32k_clocksource_init() function.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
Compile tested on omap2plus_defconfig + crane board enabled.
This patch conflicts slightly with the:
ARM: OMAP2+: Fix compiler warning for 32k timer (From Jon)
(or its future versions) available at:
http://www.spinics.net/lists/linux-omap/msg82465.html
With this patch applied, there will be no need for the above patch.

v2:  1)	Do not change the default timer name to avoid multiple
	renaming in the board files (Tony).
     2)	Inline the DT timer property (Jon).
     3)	Do not rename actual timer initialization functions and get rid of the
	wrapper function for omap2_sync32k_clocksource_init() function.
     4) Remove the oddness around omap2_##clksrc_name##_clocksource_init()
	function by introducing a separate macro for gptimer case.
     5)	Avoid having two timer_init functions for each OMAP generation and
	add only those necessary (Jon).

 arch/arm/mach-omap2/timer.c |  128 +++++++++++++++++-------------------------
 arch/arm/plat-omap/Kconfig  |    6 ++
 2 files changed, 58 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 099e406..418753f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -64,20 +64,6 @@
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
 
-#ifdef CONFIG_OMAP_32K_TIMER
-#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
-#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
-#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
-#define OMAP3_SECURE_TIMER	12
-#define TIMER_PROP_SECURE	"ti,timer-secure"
-#else
-#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
-#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
-#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
-#define OMAP3_SECURE_TIMER	1
-#define TIMER_PROP_SECURE	"ti,timer-alwon"
-#endif
-
 #define REALTIME_COUNTER_BASE				0x48243200
 #define INCREMENTER_NUMERATOR_OFFSET			0x10
 #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
@@ -407,7 +393,6 @@ static u32 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
 
-#ifdef CONFIG_OMAP_32K_TIMER
 /* Setup free-running counter for clocksource */
 static int __init omap2_sync32k_clocksource_init(void)
 {
@@ -468,12 +453,6 @@ static int __init omap2_sync32k_clocksource_init(void)
 
 	return ret;
 }
-#else
-static inline int omap2_sync32k_clocksource_init(void)
-{
-	return -ENODEV;
-}
-#endif
 
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
@@ -499,25 +478,6 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 			gptimer_id, clksrc.rate);
 }
 
-static void __init omap2_clocksource_init(int gptimer_id,
-						const char *fck_source)
-{
-	/*
-	 * First give preference to kernel parameter configuration
-	 * by user (clocksource="gp_timer").
-	 *
-	 * In case of missing kernel parameter for clocksource,
-	 * first check for availability for 32k-sync timer, in case
-	 * of failure in finding 32k_counter module or registering
-	 * it as clocksource, execution will fallback to gp-timer.
-	 */
-	if (use_gptimer_clksrc == true)
-		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
-	else if (omap2_sync32k_clocksource_init())
-		/* Fall back to gp-timer code */
-		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
-}
-
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 /*
  * The realtime counter also called master counter, is a free-running
@@ -596,52 +556,62 @@ static inline void __init realtime_counter_init(void)
 {}
 #endif
 
-#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
+#define OMAP_SYS_GP_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
+			       clksrc_nr, clksrc_src)			\
+static void __init omap##name##_gptimer_timer_init(void)		\
+{									\
+	omap_dmtimer_init();						\
+	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
+	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);	\
+}
+
+#define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
 				clksrc_nr, clksrc_src)			\
-static void __init omap##name##_timer_init(void)			\
+static void __init omap##name##_sync32k_timer_init(void)		\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	omap2_clocksource_init((clksrc_nr), clksrc_src);		\
+	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
+	if (use_gptimer_clksrc)						\
+		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);\
+	else								\
+		omap2_sync32k_clocksource_init();			\
 }
 
-#define OMAP_SYS_TIMER(name)						\
+#define OMAP_SYS_TIMER(name, clksrc)					\
 struct sys_timer omap##name##_timer = {					\
-	.init	= omap##name##_timer_init,				\
+	.init	= omap##name##_##clksrc##_timer_init,			\
 };
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, "ti,timer-alwon",
-		    2, OMAP2_MPU_SOURCE)
-OMAP_SYS_TIMER(2)
-#endif
+OMAP_SYS_32K_TIMER_INIT(2, 1, OMAP2_32K_SOURCE, "ti,timer-alwon",
+			2, OMAP2_MPU_SOURCE);
+OMAP_SYS_TIMER(2, sync32k);
+#endif /* CONFIG_ARCH_OMAP2 */
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, "ti,timer-alwon",
-		    2, OMAP3_MPU_SOURCE)
-OMAP_SYS_TIMER(3)
-OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
-			TIMER_PROP_SECURE, 2, OMAP3_MPU_SOURCE)
-OMAP_SYS_TIMER(3_secure)
-#endif
+OMAP_SYS_32K_TIMER_INIT(3, 1, OMAP3_32K_SOURCE, "ti,timer-alwon",
+			2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3, sync32k);
+OMAP_SYS_32K_TIMER_INIT(3_secure, 12, OMAP3_32K_SOURCE, "ti,timer-secure",
+			2, OMAP3_MPU_SOURCE);
+OMAP_SYS_TIMER(3_secure, sync32k);
+#endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, "ti,timer-alwon",
-		    2, OMAP4_MPU_SOURCE)
-OMAP_SYS_TIMER(3_am33xx)
-#endif
+OMAP_SYS_GP_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, "ti,timer-alwon",
+		       2, OMAP4_MPU_SOURCE);
+OMAP_SYS_TIMER(3_am33xx, gptimer);
+#endif /* CONFIG_SOC_AM33XX */
 
 #ifdef CONFIG_ARCH_OMAP4
+OMAP_SYS_32K_TIMER_INIT(4, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
+			2, OMAP4_MPU_SOURCE);
 #ifdef CONFIG_LOCAL_TIMERS
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-			      OMAP44XX_LOCAL_TWD_BASE, 29);
-#endif
-
-static void __init omap4_timer_init(void)
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
+static void __init omap4_local_timer_init(void)
 {
-	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE, "ti,timer-alwon");
-	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
-#ifdef CONFIG_LOCAL_TIMERS
+	omap4_sync32k_timer_init();
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
 		int err;
@@ -655,26 +625,32 @@ static void __init omap4_timer_init(void)
 		if (err)
 			pr_err("twd_local_timer_register failed %d\n", err);
 	}
-#endif
 }
-OMAP_SYS_TIMER(4)
-#endif
+#else /* CONFIG_LOCAL_TIMERS */
+static inline void omap4_local_timer_init(void)
+{
+	omap4_sync32_timer_init();
+}
+#endif /* CONFIG_LOCAL_TIMERS */
+OMAP_SYS_TIMER(4, local);
+#endif /* CONFIG_ARCH_OMAP4 */
 
 #ifdef CONFIG_SOC_OMAP5
-static void __init omap5_timer_init(void)
+OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
+			2, OMAP4_MPU_SOURCE);
+static void __init omap5_realtime_timer_init(void)
 {
 	int err;
 
-	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE, "ti,timer-alwon");
-	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
+	omap5_sync32k_timer_init();
 	realtime_counter_init();
 
 	err = arch_timer_of_register();
 	if (err)
 		pr_err("%s: arch_timer_register failed %d\n", __func__, err);
 }
-OMAP_SYS_TIMER(5)
-#endif
+OMAP_SYS_TIMER(5, realtime);
+#endif /* CONFIG_SOC_OMAP5 */
 
 /**
  * omap_timer_init - build and register timer device with an
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 82fcb20..665870d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -154,6 +154,12 @@ config OMAP_32K_TIMER
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
 	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4/5.
 
+	  On OMAP2PLUS this value is only used for CONFIG_HZ and
+	  CLOCK_TICK_RATE compile time calculation.
+	  The actual timer selection is done in the board file
+	  through the (DT_)MACHINE_START structure.
+
+
 config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
 	depends on ARCH_OMAP3 && PM
-- 
1.7.3.4

