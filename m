From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/12] OMAP2/3 clock: convert wkup_clkdm CM clocks to cm_clkdm
Date: Mon, 08 Sep 2008 10:57:43 -0600
Message-ID: <20080908165742.2540.54683.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49058 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbYIIIU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:20:58 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert existing wkup_clkdm clocks that should be in the CM clockdomain
to cm_clkdm.  (A later patch will add CM clockdomain associations for
unassociated clocks.)


References:

OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 TRM Version Q
   Figure 5-9
      - func_54m_ck, core_ck, func_96m_ck, func_48m_ck, func_12m_ck


OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
   Figure 4-35
      - sys_clkout2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |   16 ++++++++--------
 arch/arm/mach-omap2/clock34xx.h |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 8915b52..5845850 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -757,7 +757,7 @@ static struct clk func_54m_ck = {
 	.parent		= &apll54_ck,	/* can also be alt_clk */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
@@ -770,7 +770,7 @@ static struct clk core_ck = {
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -797,7 +797,7 @@ static struct clk func_96m_ck = {
 	.parent		= &apll96_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2430_96M_SOURCE,
@@ -830,7 +830,7 @@ static struct clk func_48m_ck = {
 	.parent		= &apll96_ck,	 /* 96M or Alt */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
@@ -846,7 +846,7 @@ static struct clk func_12m_ck = {
 	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -945,7 +945,7 @@ static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES | OFFSET_GR_MOD,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -968,7 +968,7 @@ static struct clk sys_clkout2 = {
 	.parent		= &sys_clkout2_src,
 	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK |
 				OFFSET_GR_MOD,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
@@ -981,7 +981,7 @@ static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | OFFSET_GR_MOD,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 7bd6f56..01414e2 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1023,7 +1023,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.clkdm		= { .name = "core_l4_clkdm" },
+	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 


