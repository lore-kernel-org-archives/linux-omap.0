From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Tue, 6 Oct 2015 12:01:59 -0500
Message-ID: <1444150927-14771-4-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

__omap_sync32k_timer_init(), now takes the clock
source as a parameter. This means we no longer need
__omap_gptimer_init().

Note that __omap_sync32k_timer_init() will be
renamed in a follow-up patch as it's not longer 32k
source specific.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f53ed049d710..976ff9fa3594 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -592,16 +592,6 @@ static inline void __init realtime_counter_init(void)
 {}
 #endif
 
-static void __init __omap_gptimer_init(int clkev_nr, const char *clkev_src,
-		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
-		const char *clksrc_prop)
-{
-	omap_clk_init();
-	omap_dmtimer_init();
-	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
-	omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src, clksrc_prop);
-}
-
 static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
 		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
 		const char *clksrc_prop, bool gptimer)
@@ -643,8 +633,8 @@ void __init omap3_secure_sync32k_timer_init(void)
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 void __init omap3_gptimer_timer_init(void)
 {
-	__omap_gptimer_init(2, "timer_sys_ck", NULL,
-		       1, "timer_sys_ck", "ti,timer-alwon");
+	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
+			1, "timer_sys_ck", "ti,timer-alwon", true);
 }
 #endif
 
-- 
2.5.3
