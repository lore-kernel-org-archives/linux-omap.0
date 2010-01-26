From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/14] omap2/3: Multiboot compile fixes to compile in omap2
	and omap3
Date: Tue, 26 Jan 2010 12:12:46 -0800
Message-ID: <20100126201246.15382.42379.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57971 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0AZUM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:26 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Allows compiling in omap2 and omap3.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile         |    8 ++++++++
 arch/arm/mach-omap2/clock.c          |   26 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h          |   35 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock2xxx.c      |    4 ++--
 arch/arm/mach-omap2/clock2xxx_data.c |    4 ++--
 arch/arm/mach-omap2/clock34xx.c      |    4 ++--
 arch/arm/mach-omap2/clock34xx_data.c |    4 ++--
 arch/arm/mach-omap2/clock44xx.c      |    4 ++--
 arch/arm/mach-omap2/clock44xx_data.c |    4 ++--
 arch/arm/mach-omap2/opp2xxx.h        |    5 +++++
 arch/arm/plat-omap/Kconfig           |   16 ++++++++++++----
 arch/arm/plat-omap/gpio.c            |    2 +-
 12 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b32678b..c48b3f4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -26,6 +26,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
+AFLAGS_sram242x.o			:=-Wa,-march=armv6
+AFLAGS_sram243x.o			:=-Wa,-march=armv6
+AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
+
 # Pin multiplexing
 obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
 
@@ -39,6 +43,10 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+
+AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
+AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
+
 endif
 
 # PRCM
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 759c72a..839aca4 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1092,3 +1092,29 @@ void omap2_clk_disable_unused(struct clk *clk)
 		pwrdm_clkdm_state_switch(clk->clkdm);
 }
 #endif
+
+int __init omap2_clk_init(void)
+{
+	if (cpu_is_omap24xx())
+		return omap2xxx_clk_init();
+	else if (cpu_is_omap34xx())
+		return omap3_clk_init();
+	else if (cpu_is_omap44xx())
+		return omap4_clk_init();
+	else
+		WARN_ON(1);
+
+	return -ENODEV;
+}
+
+void omap2_clk_prepare_for_reboot(void)
+{
+	if (cpu_is_omap24xx())
+		omap2xxx_clk_prepare_for_reboot();
+	else if (cpu_is_omap34xx())
+		omap3_clk_prepare_for_reboot();
+	else if (cpu_is_omap44xx())
+		omap3_clk_prepare_for_reboot();
+	else
+		BUG();
+}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 93c48df..fee5e84 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -48,6 +48,10 @@
 #define DPLL_LOCKED		0x7
 
 int omap2_clk_init(void);
+int omap2xxx_clk_init(void);
+int omap3_clk_init(void);
+int omap4_clk_init(void);
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
@@ -84,7 +88,33 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
 void omap2_init_dpll_parent(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
+
 void omap2_clk_prepare_for_reboot(void);
+
+#ifdef CONFIG_ARCH_OMAP2
+void omap2xxx_clk_prepare_for_reboot(void);
+#else
+static inline void omap2xxx_clk_prepare_for_reboot(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+void omap3_clk_prepare_for_reboot(void);
+#else
+static inline void omap3_clk_prepare_for_reboot(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+void omap4_clk_prepare_for_reboot(void);
+#else
+static inline void omap4_clk_prepare_for_reboot(void)
+{
+}
+#endif
+
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
 void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
@@ -97,7 +127,10 @@ extern u8 cpu_mask;
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_omap2_dflt;
 
-extern struct clk_functions omap2_clk_functions;
+extern struct clk_functions omap2xxx_clk_functions;
+extern struct clk_functions omap3_clk_functions;
+extern struct clk_functions omap4_clk_functions;
+
 extern struct clk *vclk, *sclk;
 
 extern const struct clksel_rate gpt_32k_rates[];
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 5420356..43e7404 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -523,7 +523,7 @@ void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 
 #endif
 
-struct clk_functions omap2_clk_functions = {
+struct clk_functions omap2xxx_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
@@ -578,7 +578,7 @@ unsigned long omap2_sys_clk_recalc(struct clk *clk)
 /*
  * Set clocks for bypass mode for reboot to work.
  */
-void omap2_clk_prepare_for_reboot(void)
+void omap2xxx_clk_prepare_for_reboot(void)
 {
 	u32 rate;
 
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 97dc7cf..21da56e 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -2238,7 +2238,7 @@ static struct omap_clk omap24xx_clks[] = {
  * init code
  */
 
-int __init omap2_clk_init(void)
+int __init omap2xxx_clk_init(void)
 {
 	const struct prcm_config *prcm;
 	struct omap_clk *c;
@@ -2257,7 +2257,7 @@ int __init omap2_clk_init(void)
 		rate_table = omap2430_rate_table;
 	}
 
-	clk_init(&omap2_clk_functions);
+	clk_init(&omap2xxx_clk_functions);
 
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
 		clk_preinit(c->lk.clk);
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d4217b9..f485a89 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -258,7 +258,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
  */
 #if defined(CONFIG_ARCH_OMAP3)
 
-struct clk_functions omap2_clk_functions = {
+struct clk_functions omap3_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
@@ -270,7 +270,7 @@ struct clk_functions omap2_clk_functions = {
 /*
  * Set clocks for bypass mode for reboot to work.
  */
-void omap2_clk_prepare_for_reboot(void)
+void omap3_clk_prepare_for_reboot(void)
 {
 	/* REVISIT: Not ready for 343x */
 #if 0
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 74930e3..63030bc 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3211,7 +3211,7 @@ static struct omap_clk omap34xx_clks[] = {
 };
 
 
-int __init omap2_clk_init(void)
+int __init omap3_clk_init(void)
 {
 	/* struct prcm_config *prcm; */
 	struct omap_clk *c;
@@ -3235,7 +3235,7 @@ int __init omap2_clk_init(void)
 		}
 	}
 
-	clk_init(&omap2_clk_functions);
+	clk_init(&omap3_clk_functions);
 
 	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
 		clk_preinit(c->lk.clk);
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index e370868..ea28a8f 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -13,7 +13,7 @@
 #include <linux/errno.h>
 #include "clock.h"
 
-struct clk_functions omap2_clk_functions = {
+struct clk_functions omap4_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
 	.clk_round_rate		= omap2_clk_round_rate,
@@ -27,7 +27,7 @@ const struct clkops clkops_noncore_dpll_ops = {
 	.disable	= &omap3_noncore_dpll_disable,
 };
 
-void omap2_clk_prepare_for_reboot(void)
+void omap4_clk_prepare_for_reboot(void)
 {
 	return;
 }
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 9d882bc..3ae0aa2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2726,7 +2726,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
 };
 
-int __init omap2_clk_init(void)
+int __init omap4_clk_init(void)
 {
 	/* struct prcm_config *prcm; */
 	struct omap_clk *c;
@@ -2738,7 +2738,7 @@ int __init omap2_clk_init(void)
 		cpu_clkflg = CK_443X;
 	}
 
-	clk_init(&omap2_clk_functions);
+	clk_init(&omap4_clk_functions);
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
 									  c++)
diff --git a/arch/arm/mach-omap2/opp2xxx.h b/arch/arm/mach-omap2/opp2xxx.h
index ed6df04..38b7305 100644
--- a/arch/arm/mach-omap2/opp2xxx.h
+++ b/arch/arm/mach-omap2/opp2xxx.h
@@ -417,7 +417,12 @@ struct prcm_config {
 
 
 extern const struct prcm_config omap2420_rate_table[];
+
+#ifdef CONFIG_ARCH_OMAP2430
 extern const struct prcm_config omap2430_rate_table[];
+#else
+#define omap2430_rate_table	NULL
+#endif
 extern const struct prcm_config *rate_table;
 extern const struct prcm_config *curr_prcm_set;
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 484d6a9..f195457 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -7,27 +7,35 @@ config ARCH_OMAP_OTG
 
 choice
 	prompt "OMAP System Type"
-	default ARCH_OMAP1
+	default ARCH_OMAP2PLUS
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	select COMMON_CLKDEV
+	help
+	  "Systems based on omap7xx, omap15xx or omap16xx"
+
+config ARCH_OMAP2PLUS
+	bool "TI OMAP2/3/4"
+	select COMMON_CLKDEV
+	help
+	  "Systems based on omap24xx, omap34xx or omap44xx"
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
+	depends on ARCH_OMAP2PLUS
 	select CPU_V6
-	select COMMON_CLKDEV
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
+	depends on ARCH_OMAP2PLUS
 	select CPU_V7
-	select COMMON_CLKDEV
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
+	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
-	select COMMON_CLKDEV
 
 endchoice
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d17620c..14b1907 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1630,7 +1630,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 /*---------------------------------------------------------------------*/
 
 static int initialized;
-#if !(defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4))
+#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
 static struct clk * gpio_ick;
 #endif
 

