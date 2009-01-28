From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH C 03/13] OMAP3 clock: convert dpll_data.idlest_bit to
	idlest_mask
Date: Wed, 28 Jan 2009 12:08:17 -0700
Message-ID: <20090128190814.12092.3911.stgit@localhost.localdomain>
References: <20090128190724.12092.22239.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60375 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZA1UZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:25:11 -0500
In-Reply-To: <20090128190724.12092.22239.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Convert struct dpll_data.idlest_bit field to idlest_mask.  Needed since
OMAP2 uses two bits for DPLL IDLEST rather than one.

While here, add the missing idlest_* fields for DPLL3.

linux-omap source commits are 25bab0f176b0a97be18a1b38153f266c3a155784
and b0f7fd17db2aaf8e6e9a2732ae3f4de0874db01c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.c         |    6 ++----
 arch/arm/mach-omap2/clock34xx.h         |   10 ++++++----
 arch/arm/plat-omap/include/mach/clock.h |    4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ff43058..0f493f5 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -78,14 +78,12 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
 	const struct dpll_data *dd;
 	int i = 0;
 	int ret = -EINVAL;
-	u32 idlest_mask;
 
 	dd = clk->dpll_data;
 
-	state <<= dd->idlest_bit;
-	idlest_mask = 1 << dd->idlest_bit;
+	state <<= __ffs(dd->idlest_mask);
 
-	while (((__raw_readl(dd->idlest_reg) & idlest_mask) != state) &&
+	while (((__raw_readl(dd->idlest_reg) & dd->idlest_mask) != state) &&
 	       i < MAX_DPLL_WAIT_TRIES) {
 		i++;
 		udelay(1);
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 9d123c6..277b221 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -303,7 +303,7 @@ static struct dpll_data dpll1_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_MPU_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -375,7 +375,7 @@ static struct dpll_data dpll2_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_IVA2_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -434,6 +434,8 @@ static struct dpll_data dpll3_dd = {
 	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
+	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -623,7 +625,7 @@ static struct dpll_data dpll4_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.idlest_bit	= OMAP3430_ST_PERIPH_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -965,7 +967,7 @@ static struct dpll_data dpll5_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_PLL),
 	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-	.idlest_bit	= OMAP3430ES2_ST_PERIPH2_CLK_SHIFT,
+	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index c6762e9..666f52b 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -41,6 +41,8 @@ struct dpll_data {
 	u16			max_multiplier;
 	u8			max_divider;
 	u32			max_tolerance;
+	void __iomem		*idlest_reg;
+	u32			idlest_mask;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u32			freqsel_mask;
 	u8			modes;
@@ -51,8 +53,6 @@ struct dpll_data {
 	u8			recal_st_bit;
 	void __iomem		*autoidle_reg;
 	u32			autoidle_mask;
-	void __iomem		*idlest_reg;
-	u8			idlest_bit;
 #  endif
 };
 


