From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 04/11] arm: omap2: timer: provide generic sync32k_timer_init function
Date: Tue, 29 Sep 2015 15:43:59 -0500
Message-ID: <1443559446-26969-5-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

instead of constantly defining a small wrapper
around __omap_sync32k_timer_init(), let's define
a generic one which can be used by all OMAPs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 10 +++++-----
 arch/arm/mach-omap2/board-ldp.c     |  2 +-
 arch/arm/mach-omap2/board-rx51.c    |  2 +-
 arch/arm/mach-omap2/common.h        |  3 +--
 arch/arm/mach-omap2/timer.c         | 20 +++-----------------
 5 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 89bf39663d61..d08191ffabd9 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -53,7 +53,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap2_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= omap242x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -70,7 +70,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap2_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= omap243x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -89,7 +89,7 @@ DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap3_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= n900_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -107,7 +107,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap3_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -123,7 +123,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.init_early	= omap3630_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap3_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= omap36xx_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c2975af4cd5d..0d3a57c6931f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -424,6 +424,6 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap3_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 2d1e5a6beb85..830256c434ec 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -136,6 +136,6 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap3_sync32k_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 92e92cfc2775..844ad031f7f0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -88,8 +88,7 @@ static inline int omap_mux_late_init(void)
 
 extern void omap2_init_common_infrastructure(void);
 
-extern void omap2_sync32k_timer_init(void);
-extern void omap3_sync32k_timer_init(void);
+extern void omap_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 44db46ccd474..a416bcb38f2c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -612,21 +612,13 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
 		omap2_sync32k_clocksource_init();
 }
 
-#ifdef CONFIG_ARCH_OMAP2
-void __init omap2_sync32k_timer_init(void)
+void __init omap_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
 }
-#endif /* CONFIG_ARCH_OMAP2 */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
-void __init omap3_sync32k_timer_init(void)
-{
-	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck", NULL, false);
-}
-
 void __init omap3_secure_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
@@ -644,15 +636,9 @@ void __init omap3_gptimer_timer_init(void)
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-static void __init omap4_sync32k_timer_init(void)
-{
-	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck", NULL, false);
-}
-
 void __init omap4_local_timer_init(void)
 {
-	omap4_sync32k_timer_init();
+	omap_sync32k_timer_init();
 	clocksource_of_init();
 }
 #endif
@@ -660,7 +646,7 @@ void __init omap4_local_timer_init(void)
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
 {
-	omap4_sync32k_timer_init();
+	omap_sync32k_timer_init();
 	realtime_counter_init();
 
 	clocksource_of_init();
-- 
2.5.3
