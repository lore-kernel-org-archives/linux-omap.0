From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/11] arm: omap2: timer: rename omap_sync32k_timer_init()
Date: Tue, 6 Oct 2015 12:02:04 -0500
Message-ID: <1444150927-14771-9-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

this function is not only about the 32k sync
timer, it's OMAP's generic init_time implementation.

Let's rename it to make that detail easier to
notice.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 14 +++++++-------
 arch/arm/mach-omap2/board-ldp.c     |  2 +-
 arch/arm/mach-omap2/board-rx51.c    |  2 +-
 arch/arm/mach-omap2/common.h        |  2 +-
 arch/arm/mach-omap2/timer.c         |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 20d5e82ab6ee..e51fb8245704 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -46,7 +46,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap242x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -63,7 +63,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap243x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -82,7 +82,7 @@ DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= n900_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -100,7 +100,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -116,7 +116,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.init_early	= omap3630_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap36xx_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -228,7 +228,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap4_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
@@ -272,7 +272,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 0d3a57c6931f..d9c3ffc39329 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -424,6 +424,6 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 830256c434ec..41161ca97d74 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -136,6 +136,6 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index bf42fc4e78f4..e1e274334290 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -88,7 +88,7 @@ static inline int omap_mux_late_init(void)
 
 extern void omap2_init_common_infrastructure(void);
 
-extern void omap_sync32k_timer_init(void);
+extern void omap_init_time(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f41e526ffa46..01452cb190cb 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -492,7 +492,7 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
 		omap2_sync32k_clocksource_init();
 }
 
-void __init omap_sync32k_timer_init(void)
+void __init omap_init_time(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
@@ -635,7 +635,7 @@ sysclk1_based:
 void __init omap5_realtime_timer_init(void)
 {
 	realtime_counter_init();
-	omap_sync32k_timer_init();
+	omap_init_time();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
-- 
2.5.3
