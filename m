From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 05/11] arm: omap2: timer: move realtime_counter_init() around
Date: Tue, 6 Oct 2015 12:02:01 -0500
Message-ID: <1444150927-14771-6-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

no functional changes, just moving that function
closer to its calling location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 102 ++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index d14e25b2d7a4..dcc0f032e717 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -476,7 +476,55 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 			clocksource_gpt.name, clksrc.rate);
 }
 
-#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
+static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
+		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
+		const char *clksrc_prop, bool gptimer)
+{
+	omap_clk_init();
+	omap_dmtimer_init();
+	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
+
+	/* Enable the use of clocksource="gp_timer" kernel parameter */
+	if (use_gptimer_clksrc || gptimer)
+		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
+						clksrc_prop);
+	else
+		omap2_sync32k_clocksource_init();
+}
+
+void __init omap_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
+			2, "timer_sys_ck", NULL, false);
+}
+
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
+void __init omap3_secure_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
+			2, "timer_sys_ck", NULL, false);
+}
+#endif /* CONFIG_ARCH_OMAP3 */
+
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
+void __init omap3_gptimer_timer_init(void)
+{
+	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
+			1, "timer_sys_ck", "ti,timer-alwon", true);
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
+void __init omap4_local_timer_init(void)
+{
+	omap_sync32k_timer_init();
+	clocksource_of_init();
+}
+#endif
+
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
+
 /*
  * The realtime counter also called master counter, is a free-running
  * counter, which is related to real time. It produces the count used
@@ -488,6 +536,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
  */
 static void __init realtime_counter_init(void)
 {
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 	void __iomem *base;
 	static struct clk *sys_clk;
 	unsigned long rate;
@@ -586,60 +635,9 @@ sysclk1_based:
 	set_cntfreq();
 
 	iounmap(base);
-}
-#else
-static inline void __init realtime_counter_init(void)
-{}
 #endif
-
-static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
-		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
-		const char *clksrc_prop, bool gptimer)
-{
-	omap_clk_init();
-	omap_dmtimer_init();
-	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
-
-	/* Enable the use of clocksource="gp_timer" kernel parameter */
-	if (use_gptimer_clksrc || gptimer)
-		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
-						clksrc_prop);
-	else
-		omap2_sync32k_clocksource_init();
-}
-
-void __init omap_sync32k_timer_init(void)
-{
-	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck", NULL, false);
 }
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
-void __init omap3_secure_sync32k_timer_init(void)
-{
-	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
-			2, "timer_sys_ck", NULL, false);
-}
-#endif /* CONFIG_ARCH_OMAP3 */
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-void __init omap3_gptimer_timer_init(void)
-{
-	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
-			1, "timer_sys_ck", "ti,timer-alwon", true);
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-void __init omap4_local_timer_init(void)
-{
-	omap_sync32k_timer_init();
-	clocksource_of_init();
-}
-#endif
-
-#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
 {
 	omap_sync32k_timer_init();
-- 
2.5.3
