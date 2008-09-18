From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/7] OMAP3 clock: convert dpll_data.idlest_bit to
	idlest_mask
Date: Thu, 18 Sep 2008 10:29:58 -0600
Message-ID: <20080918162953.9452.28686.stgit@localhost.localdomain>
References: <20080918162835.9452.71873.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58230 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYIRQ4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 12:56:18 -0400
In-Reply-To: <20080918162835.9452.71873.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert struct dpll_data.idlest_bit field to idlest_mask.  Needed since
later patches are converting the DPLL bypass state test to use the IDLEST
registers, and OMAP2 uses two bits for DPLL IDLEST rather than one.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c         |    6 ++----
 arch/arm/mach-omap2/clock34xx.h         |    8 ++++----
 arch/arm/plat-omap/include/mach/clock.h |    4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 152d095..c5765bf 100644
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
index 41f91f8..044a3ff 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -310,7 +310,7 @@ static struct dpll_data dpll1_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_MPU_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -382,7 +382,7 @@ static struct dpll_data dpll2_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_IVA2_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -628,7 +628,7 @@ static struct dpll_data dpll4_dd = {
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.idlest_bit	= OMAP3430_ST_PERIPH_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -968,7 +968,7 @@ static struct dpll_data dpll5_dd = {
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
 


