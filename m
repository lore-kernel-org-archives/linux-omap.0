From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 56/86] [ARM] OMAP3 clock: convert dpll_data.idlest_bit to idlest_mask
Date: Thu, 12 Mar 2009 11:28:06 -0700
Message-ID: <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196AbZCLSck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:40 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:38 -0700 (PDT)
In-Reply-To: <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Convert struct dpll_data.idlest_bit field to idlest_mask.  Needed since
OMAP2 uses two bits for DPLL IDLEST rather than one.

While here, add the missing idlest_* fields for DPLL3.

linux-omap source commits are 25bab0f176b0a97be18a1b38153f266c3a155784
and b0f7fd17db2aaf8e6e9a2732ae3f4de0874db01c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c         |    6 ++----
 arch/arm/mach-omap2/clock34xx.h         |   10 ++++++----
 arch/arm/plat-omap/include/mach/clock.h |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index fdfc7d5..aad77e0 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -314,14 +314,12 @@ static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
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
index f8088c0..7ee1312 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -266,7 +266,7 @@ static struct dpll_data dpll1_dd = {
 	.autoidle_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_MPU_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -339,7 +339,7 @@ static struct dpll_data dpll2_dd = {
 	.autoidle_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
-	.idlest_bit	= OMAP3430_ST_IVA2_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -397,6 +397,8 @@ static struct dpll_data dpll3_dd = {
 	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
 	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
+	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -587,7 +589,7 @@ static struct dpll_data dpll4_dd = {
 	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.idlest_bit	= OMAP3430_ST_PERIPH_CLK_SHIFT,
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -926,7 +928,7 @@ static struct dpll_data dpll5_dd = {
 	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_PLL),
 	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
 	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-	.idlest_bit	= OMAP3430ES2_ST_PERIPH2_CLK_SHIFT,
+	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 681c651..611df52 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -54,10 +54,10 @@ struct dpll_data {
 	u32			enable_mask;
 	u32			autoidle_mask;
 	u32			freqsel_mask;
+	u32			idlest_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-	u8			idlest_bit;
 #  endif
 };
 
-- 
1.6.1.2

