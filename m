From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 06/11] arm: omap2: timer: always call clocksource_of_init() when DT
Date: Tue, 29 Sep 2015 15:44:01 -0500
Message-ID: <1443559446-26969-7-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

If booting with DT, let's make sure to always
call clocksource_of_init() as this will make
it easier to move timer code to drivers/clocksource
in the future.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index deccec2d6ed8..1ae563736b12 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -500,6 +500,9 @@ void __init omap_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
+
+	if (of_have_populated_dt())
+		clocksource_of_init();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -523,7 +526,6 @@ void __init omap3_gptimer_timer_init(void)
 void __init omap4_local_timer_init(void)
 {
 	omap_sync32k_timer_init();
-	clocksource_of_init();
 }
 #endif
 
@@ -644,10 +646,8 @@ sysclk1_based:
 
 void __init omap5_realtime_timer_init(void)
 {
-	omap_sync32k_timer_init();
 	realtime_counter_init();
-
-	clocksource_of_init();
+	omap_sync32k_timer_init();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
-- 
2.5.3
