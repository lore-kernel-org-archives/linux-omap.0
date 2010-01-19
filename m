From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 15/18] OMAP2/3/4 clock: omap2_clk_prepare_for_reboot() is
	OMAP2xxx-only
Date: Tue, 19 Jan 2010 16:36:36 -0700
Message-ID: <20100119233633.26047.86306.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58645 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab0ASXif (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:35 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

omap2_clk_prepare_for_reboot() is only applicable to OMAP2xxx chips,
so rename it to omap2xxx_clk_prepare_for_reboot() and only call it when
running on OMAP2xxx chips.  Remove the old stub in the OMAP3 clock code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h     |    1 -
 arch/arm/mach-omap2/clock2xxx.c |    2 +-
 arch/arm/mach-omap2/clock2xxx.h |    1 +
 arch/arm/mach-omap2/clock34xx.c |   21 ++-------------------
 arch/arm/mach-omap2/clock44xx.c |    5 -----
 arch/arm/mach-omap2/prcm.c      |    8 +++++---
 6 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index dcd58cd..be5a55f 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -84,7 +84,6 @@ int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 u32 omap2_get_dpll_rate(struct clk *clk);
 void omap2_init_dpll_parent(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
-void omap2_clk_prepare_for_reboot(void);
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
 void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index e98f48b..a48b01a 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -71,7 +71,7 @@ const struct clkops clkops_omap2430_i2chs_wait = {
 /*
  * Set clocks for bypass mode for reboot to work.
  */
-void omap2_clk_prepare_for_reboot(void)
+void omap2xxx_clk_prepare_for_reboot(void)
 {
 	u32 rate;
 
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index c14061b..bed294a 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -18,6 +18,7 @@ int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
+void omap2xxx_clk_prepare_for_reboot(void);
 
 /* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 8a7db7a..34d3950 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -150,25 +150,6 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	return omap3_noncore_dpll_set_rate(clk, rate);
 }
 
-/* Common clock code */
-
-/*
- * Set clocks for bypass mode for reboot to work.
- */
-void omap2_clk_prepare_for_reboot(void)
-{
-	/* REVISIT: Not ready for 343x */
-#if 0
-	u32 rate;
-
-	if (vclk == NULL || sclk == NULL)
-		return;
-
-	rate = clk_get_rate(sclk);
-	clk_set_rate(vclk, rate);
-#endif
-}
-
 void omap3_clk_lock_dpll5(void)
 {
 	struct clk *dpll5_clk;
@@ -191,6 +172,8 @@ void omap3_clk_lock_dpll5(void)
 	return;
 }
 
+/* Common clock code */
+
 /* REVISIT: Move this init stuff out into clock.c */
 
 /*
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index 08dd642..c238717 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -17,8 +17,3 @@ const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 };
-
-void omap2_clk_prepare_for_reboot(void)
-{
-	return;
-}
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 63330d2..814376a 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -29,6 +29,7 @@
 #include <plat/control.h>
 
 #include "clock.h"
+#include "clock2xxx.h"
 #include "cm.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
@@ -136,11 +137,12 @@ EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 void omap_prcm_arch_reset(char mode)
 {
 	s16 prcm_offs;
-	omap2_clk_prepare_for_reboot();
 
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
+		omap2xxx_clk_prepare_for_reboot();
+
 		prcm_offs = WKUP_MOD;
-	else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx()) {
 		u32 l;
 
 		prcm_offs = OMAP3430_GR_MOD;


