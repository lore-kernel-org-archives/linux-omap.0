From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 5/7] ARM: OMAP2+: Simplify system timers definitions
Date: Mon, 4 Feb 2013 11:43:04 -0600
Message-ID: <1359999786-8740-6-git-send-email-jon-hunter@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49830 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278Ab3BDRnV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 12:43:21 -0500
In-Reply-To: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

There is a lot of redundancy in the definitions for the various system
timers for OMAP2+ devices. For example, the omap3_am33xx_gptimer_timer_init()
function is the same as the omap3_gp_gptimer_timer_init() function and the
function omap4_sync32k_timer_init() can be re-used for OMAP5 devices.
Therefore, consolidate the definitions to simplify the code.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/common.h         |    3 +--
 arch/arm/mach-omap2/timer.c          |   48 ++++++++++++++++++++--------------
 4 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 6a9529a..7c1ad68 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -297,6 +297,6 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
 	.init_late	= am35xx_init_late,
-	.init_time	= omap3_gp_gptimer_timer_init,
+	.init_time	= omap3_gptimer_timer_init,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 2590463..dfd9f48 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -138,7 +138,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap3_am33xx_gptimer_timer_init,
+	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= am33xx_boards_compat,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index b435027..594ab3b 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -82,8 +82,7 @@ extern void omap2_init_common_infrastructure(void);
 extern void omap2_sync32k_timer_init(void);
 extern void omap3_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
-extern void omap3_gp_gptimer_timer_init(void);
-extern void omap3_am33xx_gptimer_timer_init(void);
+extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
 extern void omap5_realtime_timer_init(void);
 
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4213bf4..1b99b41 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -160,6 +160,12 @@ static struct device_node * __init omap_get_timer_dt(struct of_device_id *match,
 		if (property && !of_get_property(np, property, NULL))
 			continue;
 
+		if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
+				  of_get_property(np, "ti,timer-dsp", NULL) ||
+				  of_get_property(np, "ti,timer-pwm", NULL) ||
+				  of_get_property(np, "ti,timer-secure", NULL)))
+			continue;
+
 		of_add_property(np, &device_disabled);
 		return np;
 	}
@@ -435,13 +441,14 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 }
 
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
-						const char *fck_source)
+						  const char *fck_source,
+						  const char *property)
 {
 	int res;
 
 	clksrc.errata = omap_dm_timer_get_errata();
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, property,
 				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
@@ -538,49 +545,52 @@ static inline void __init realtime_counter_init(void)
 #endif
 
 #define OMAP_SYS_GP_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-			       clksrc_nr, clksrc_src)			\
+			       clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);	\
+	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
+					clksrc_prop);			\
 }
 
 #define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-				clksrc_nr, clksrc_src)			\
+				clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_sync32k_timer_init(void)		\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
 	if (use_gptimer_clksrc)						\
-		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);\
+		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,	\
+						clksrc_prop);		\
 	else								\
 		omap2_sync32k_clocksource_init();			\
 }
 
 #ifdef CONFIG_ARCH_OMAP2
 OMAP_SYS_32K_TIMER_INIT(2, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 #endif /* CONFIG_ARCH_OMAP2 */
 
 #ifdef CONFIG_ARCH_OMAP3
 OMAP_SYS_32K_TIMER_INIT(3, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
-			2, "timer_sys_ck");
-OMAP_SYS_GP_TIMER_INIT(3_gp, 1, "timer_sys_ck", "ti,timer-alwon",
-		       2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_GP_TIMER_INIT(3_am33xx, 1, "timer_sys_ck", "ti,timer-alwon",
-		       2, "timer_sys_ck");
-#endif /* CONFIG_SOC_AM33XX */
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
+OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
+		       1, "timer_sys_ck", "ti,timer-alwon");
+#endif
 
-#ifdef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck");
+			2, "sys_clkin_ck", NULL);
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
@@ -609,13 +619,11 @@ void __init omap4_local_timer_init(void)
 #endif /* CONFIG_ARCH_OMAP4 */
 
 #ifdef CONFIG_SOC_OMAP5
-OMAP_SYS_32K_TIMER_INIT(5, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck");
 void __init omap5_realtime_timer_init(void)
 {
 	int err;
 
-	omap5_sync32k_timer_init();
+	omap4_sync32k_timer_init();
 	realtime_counter_init();
 
 	err = arch_timer_of_register();
-- 
1.7.10.4

