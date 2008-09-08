From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/12] OMAP2/3 clock: annotate PRM clocks that are missing
	clockdomains
Date: Mon, 08 Sep 2008 10:57:42 -0600
Message-ID: <20080908165741.2540.51185.stgit@localhost.localdomain>
References: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49056 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbYIIIU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:20:57 -0400
In-Reply-To: <20080908164444.2540.98619.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Some PRM clocks are missing clockdomain assignments; add them.

Also, in OMAP2xxx clock tree, standardize the name for wdt1_osc_ck.


References for the OMAP2xxx clocks:

OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 TRM Version Q
  Table 18-41:
      - wdt1_osc_ck

References for the OMAP3xxx clocks:

OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
  Figure 4-13:
      - sys_clkout1,
  Table 4-37:
      - sys_ck
  Table 4-38:
      - omap_32k_fck, osc_sys_ck,
  Figure 4-56:
      - sr1_fck, sr2_fck
  Figure 4-57:
      - omap_96m_alwon_fck
  Section 4.7.7.13:
      - sr1_fck, sr2_fck

OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.0 Security
Addendum Version B TRM
  Table 2-5:
      - usim_fck
  Figure 3-29:
      - secure_32k_fck, gpt12_fck, wdt1_fck

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |    3 ++-
 arch/arm/mach-omap2/clock34xx.h |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 7224450..8915b52 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -852,9 +852,10 @@ static struct clk func_12m_ck = {
 
 /* Secure timer, only available in secure mode */
 static struct clk wdt1_osc_ck = {
-	.name		= "ck_wdt1_osc",
+	.name		= "wdt1_osc_ck",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index c825a37..7bd6f56 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -74,6 +74,7 @@ static struct clk omap_32k_fck = {
 	.rate		= 32768,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -82,6 +83,7 @@ static struct clk secure_32k_fck = {
 	.rate		= 32768,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -91,6 +93,7 @@ static struct clk virt_12m_ck = {
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -99,6 +102,7 @@ static struct clk virt_13m_ck = {
 	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -107,6 +111,7 @@ static struct clk virt_16_8m_ck = {
 	.rate		= 16800000,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -115,6 +120,7 @@ static struct clk virt_19_2m_ck = {
 	.rate		= 19200000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -123,6 +129,7 @@ static struct clk virt_26m_ck = {
 	.rate		= 26000000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -131,6 +138,7 @@ static struct clk virt_38_4m_ck = {
 	.rate		= 38400000,
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -185,6 +193,7 @@ static struct clk osc_sys_ck = {
 	/* REVISIT: deal with autoextclkmode? */
 	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
 				ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -209,6 +218,7 @@ static struct clk sys_ck = {
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -222,6 +232,7 @@ static struct clk sys_altclk = {
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -233,6 +244,7 @@ static struct clk sys_clkout1 = {
 	.enable_reg	= (__force void __iomem *)OMAP3430_PRM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -678,6 +690,7 @@ static struct clk omap_96m_alwon_fck = {
 	.clksel		= omap_96m_alwon_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2310,6 +2323,7 @@ static struct clk usim_fck = {
 	.clksel_mask	= OMAP3430ES2_CLKSEL_USIMOCP_MASK,
 	.clksel		= usim_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3036,6 +3050,7 @@ static struct clk sr1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -3046,6 +3061,7 @@ static struct clk sr2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -3064,6 +3080,7 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &secure_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -3071,6 +3088,7 @@ static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
 	.parent		= &secure_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 


