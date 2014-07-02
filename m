From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/13] ARM: OMAP2+: clock/dpll: add jitter correction behind clk_features
Date: Wed, 2 Jul 2014 11:47:43 +0300
Message-ID: <1404290867-6768-10-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39733 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbaGBIsH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:48:07 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Currently DPLL code uses runtime cpu_is_343x checks to see if the DPLL
has freqsel fields in its control register or not. Instead, add a new
flag to the clk_features.flags and use this during runtime. Allows
eventual move of the DPLL code under clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c    |    4 ++++
 arch/arm/mach-omap2/clock.h    |    3 +++
 arch/arm/mach-omap2/dpll3xxx.c |    4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index e438437..23b5f05 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -784,4 +784,8 @@ void __init ti_clk_init_features(void)
 			(1 << OMAP4XXX_EN_DPLL_FRBYPASS) |
 			(1 << OMAP4XXX_EN_DPLL_MNBYPASS);
 	}
+
+	/* Jitter correction only available on OMAP343X */
+	if (cpu_is_omap343x())
+		ti_clk_features.flags |= TI_CLK_DPLL_HAS_FREQSEL;
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 7b2b099..d3ef147 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -234,6 +234,9 @@ struct ti_clk_features {
 	long fint_band2_min;
 	u8 dpll_bypass_vals;
 };
+
+#define TI_CLK_DPLL_HAS_FREQSEL		(1 << 0)
+
 extern struct ti_clk_features ti_clk_features;
 
 extern const struct clkops clkops_omap2_dflt_wait;
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 6d7ba37..12ad0f5 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -310,7 +310,7 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * Set jitter correction. Jitter correction applicable for OMAP343X
 	 * only since freqsel field is no longer present on other devices.
 	 */
-	if (cpu_is_omap343x()) {
+	if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
 		v = omap2_clk_readl(clk, dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -512,7 +512,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 			return -EINVAL;
 
 		/* Freqsel is available only on OMAP343X devices */
-		if (cpu_is_omap343x()) {
+		if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			WARN_ON(!freqsel);
-- 
1.7.9.5

