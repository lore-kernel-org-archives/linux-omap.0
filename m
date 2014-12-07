From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] arch: arm: mach-omap2: dpll44xx.c:  Remove unused function
Date: Sun,  7 Dec 2014 23:30:13 +0100
Message-ID: <1417991413-20077-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Remove the function omap4_dpllmx_gatectrl_read() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-omap2/clock.h    |    1 -
 arch/arm/mach-omap2/dpll44xx.c |   20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 4592a27..88cc816 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -177,7 +177,6 @@ struct clksel {
 u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
 void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
 void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
-int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk);
 void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk);
 void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk);
 
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 4613f1e..6b6db49 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -36,26 +36,6 @@
 /* Static rate multiplier for OMAP4 REGM4XEN clocks */
 #define OMAP4430_REGM4XEN_MULT				4
 
-/* Supported only on OMAP4 */
-int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
-{
-	u32 v;
-	u32 mask;
-
-	if (!clk || !clk->clksel_reg)
-		return -EINVAL;
-
-	mask = clk->flags & CLOCK_CLKOUTX2 ?
-			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
-			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
-
-	v = omap2_clk_readl(clk, clk->clksel_reg);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
 void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
 {
 	u32 v;
-- 
1.7.10.4
