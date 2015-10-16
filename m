From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/11] arm: omap2: timer: move realtime_counter_init() around
Date: Fri, 16 Oct 2015 11:22:05 -0500
Message-ID: <1445012530-14126-7-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

no functional changes, just moving that function
closer to its calling location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 114 ++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ebebe1bd7237..8f2c75911179 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -476,7 +476,61 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
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
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) ||		\
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
+static void __init omap4_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
+			2, "sys_clkin_ck", NULL, false);
+}
+
+void __init omap4_local_timer_init(void)
+{
+	omap4_sync32k_timer_init();
+	clocksource_of_init();
+}
+#endif
+
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
+
 /*
  * The realtime counter also called master counter, is a free-running
  * counter, which is related to real time. It produces the count used
@@ -488,6 +542,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
  */
 static void __init realtime_counter_init(void)
 {
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 	void __iomem *base;
 	static struct clk *sys_clk;
 	unsigned long rate;
@@ -586,66 +641,9 @@ sysclk1_based:
 	set_cntfreq();
 
 	iounmap(base);
-}
-#else
-static inline void __init realtime_counter_init(void)
-{}
-#endif
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
-}
-
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
 #endif
-
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-static void __init omap4_sync32k_timer_init(void)
-{
-	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck", NULL, false);
 }
 
-void __init omap4_local_timer_init(void)
-{
-	omap4_sync32k_timer_init();
-	clocksource_of_init();
-}
-#endif
-
-#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-- 
2.5.3
