From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/7] OMAP3 clock: note the bypass source clock for DPLLs
Date: Thu, 18 Sep 2008 10:30:05 -0600
Message-ID: <20080918163002.9452.75830.stgit@localhost.localdomain>
References: <20080918162835.9452.71873.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58237 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYIRQ4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 12:56:19 -0400
In-Reply-To: <20080918162835.9452.71873.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Most DPLLs use sys_clk as their bypass rate source.  But DPLL1 and DPLL2
use high-frequency bypass clocks dpll1_fclk and dpll2_fclk as their parents
during bypass.  Add a new struct dpll_data field to track the DPLL's bypass
source clock.

Kevin Hilman <khilman@deeprootsystems.com> helped catch this - thanks Kevin.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.h         |    9 +++++++++
 arch/arm/plat-omap/include/mach/clock.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 19c3881..cc4960d 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -49,6 +49,10 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
  * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
  */
 
+/* Forward declarations for DPLL bypass clocks */
+static struct clk dpll1_fck;
+static struct clk dpll2_fck;
+
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP		0x1
 #define DPLL_LOW_POWER_BYPASS		0x5
@@ -311,6 +315,7 @@ static struct dpll_data dpll1_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_MPU_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.idlest_mask	= OMAP3430_ST_MPU_CLK_MASK,
+	.bypass_clk	= &dpll1_fck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -383,6 +388,7 @@ static struct dpll_data dpll2_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_IVA2_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST_PLL),
 	.idlest_mask	= OMAP3430_ST_IVA2_CLK_MASK,
+	.bypass_clk	= &dpll2_fck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -443,6 +449,7 @@ static struct dpll_data dpll3_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
+	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -631,6 +638,7 @@ static struct dpll_data dpll4_dd = {
 	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
+	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
@@ -971,6 +979,7 @@ static struct dpll_data dpll5_dd = {
 	.autoidle_mask	= OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
 	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.idlest_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
+	.bypass_clk	= &sys_ck,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 666f52b..0fb4271 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -43,6 +43,7 @@ struct dpll_data {
 	u32			max_tolerance;
 	void __iomem		*idlest_reg;
 	u32			idlest_mask;
+	struct clk		*bypass_clk;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u32			freqsel_mask;
 	u8			modes;


