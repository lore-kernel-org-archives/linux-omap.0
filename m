From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Tue, 29 Sep 2015 15:43:58 -0500
Message-ID: <1443559446-26969-4-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

since now we can reuse __omap_sync32k_timer_init()
for OMAP3-like devices, we can safely remove
__omap_gptimer_init().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4f9cd4b2e6b0..44db46ccd474 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -596,16 +596,6 @@ static inline void __init realtime_counter_init(void)
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
@@ -647,8 +637,8 @@ void __init omap3_secure_sync32k_timer_init(void)
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
