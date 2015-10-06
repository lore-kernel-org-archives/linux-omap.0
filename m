From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/11] arm: omap2: timer: remove omap4_local_timer_init
Date: Tue, 6 Oct 2015 12:02:03 -0500
Message-ID: <1444150927-14771-8-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

We're now always calling clocksource_of_init()
whenever booting with DT, so we can use the
generic omap_sync32k_timer_init() (which will
be renamed in a follow-up patch) for OMAP4
as well.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 4 ++--
 arch/arm/mach-omap2/common.h        | 1 -
 arch/arm/mach-omap2/timer.c         | 8 --------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 871db0f0fa66..20d5e82ab6ee 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -228,7 +228,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
-	.init_time	= omap4_local_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= omap4_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
@@ -272,7 +272,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap4_local_timer_init,
+	.init_time	= omap_sync32k_timer_init,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 844ad031f7f0..bf42fc4e78f4 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -91,7 +91,6 @@ extern void omap2_init_common_infrastructure(void);
 extern void omap_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
-extern void omap4_local_timer_init(void);
 #ifdef CONFIG_CACHE_L2X0
 int omap_l2_cache_init(void);
 #define OMAP_L2C_AUX_CTRL	(L2C_AUX_CTRL_SHARED_OVERRIDE | \
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b523426f38a5..f41e526ffa46 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -517,14 +517,6 @@ void __init omap3_gptimer_timer_init(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-void __init omap4_local_timer_init(void)
-{
-	omap_sync32k_timer_init();
-}
-#endif
-
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 
 /*
-- 
2.5.3
