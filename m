From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/11] arm: omap2: timer: get rid of obfuscating macros
Date: Fri, 16 Oct 2015 11:22:01 -0500
Message-ID: <1445012530-14126-3-git-send-email-balbi@ti.com>
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

those macros just make it a lot more difficult
to grep around and actually find similarities.

In this patch, we will simply remove them and
replace with actual functions and later commits
will come to further clean this up.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 70 ++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 548d922cb107..23e58ea6a171 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -592,53 +592,69 @@ static inline void __init realtime_counter_init(void)
 {}
 #endif
 
-#define OMAP_SYS_GP_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-			       clksrc_nr, clksrc_src, clksrc_prop)	\
-void __init omap##name##_gptimer_timer_init(void)			\
-{									\
-	omap_clk_init();					\
-	omap_dmtimer_init();						\
-	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
-					clksrc_prop);			\
+static void __init __omap_gptimer_init(int clkev_nr, const char *clkev_src,
+		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
+		const char *clksrc_prop)
+{
+	omap_clk_init();
+	omap_dmtimer_init();
+	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
+	omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src, clksrc_prop);
 }
 
-#define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-				clksrc_nr, clksrc_src, clksrc_prop)	\
-void __init omap##name##_sync32k_timer_init(void)		\
-{									\
-	omap_clk_init();					\
-	omap_dmtimer_init();						\
-	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
-	if (use_gptimer_clksrc)						\
-		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,	\
-						clksrc_prop);		\
-	else								\
-		omap2_sync32k_clocksource_init();			\
+static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
+		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
+		const char *clksrc_prop)
+{
+	omap_clk_init();
+	omap_dmtimer_init();
+	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
+
+	/* Enable the use of clocksource="gp_timer" kernel parameter */
+	if (use_gptimer_clksrc)
+		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
+						clksrc_prop);
+	else
+		omap2_sync32k_clocksource_init();
 }
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_32K_TIMER_INIT(2, 1, "timer_32k_ck", "ti,timer-alwon",
+void __init omap2_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL);
+}
 #endif /* CONFIG_ARCH_OMAP2 */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
-OMAP_SYS_32K_TIMER_INIT(3, 1, "timer_32k_ck", "ti,timer-alwon",
+void __init omap3_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL);
-OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
+}
+
+void __init omap3_secure_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
+void __init omap3_gptimer_timer_init(void)
+{
+	__omap_gptimer_init(2, "timer_sys_ck", NULL,
 		       1, "timer_sys_ck", "ti,timer-alwon");
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
+static void __init omap4_sync32k_timer_init(void)
+{
+	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			       2, "sys_clkin_ck", NULL);
+}
 
 void __init omap4_local_timer_init(void)
 {
-- 
2.5.3
