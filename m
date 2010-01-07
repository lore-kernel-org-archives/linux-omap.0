From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip-opp][PATCH] omap3: pm: sr: fix get_vddx_opp to use ceil
Date: Wed,  6 Jan 2010 19:56:42 -0600
Message-ID: <1262829402-10158-1-git-send-email-nm@ti.com>
References: <[PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab0AGB4p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jan 2010 20:56:45 -0500
In-Reply-To: <[PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

commit ad248123 changed the behavior of get_vdd1_opp and get_vdd2_opp
to use exact frequencies causing a break in rx51. we re-introduce the
approximate search to maintain consistent behavior.

The DPLL frequencies are expected to be the same as the OPP frequencies,
inconsistency here should be investigated, this introduces a warning for
the same.

Discussion: http://marc.info/?t=125800503700009&r=1&w=2

Reported-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d341857..c518f9e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -150,14 +150,23 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
 static u8 get_vdd1_opp(void)
 {
 	struct omap_opp *opp;
+	unsigned long freq;
 
 	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
 							mpu_opps == NULL)
 		return 0;
 
-	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
+	freq = sr1.vdd_opp_clk->rate;
+	opp = opp_find_freq_ceil(mpu_opps, &freq);
 	if (IS_ERR(opp))
 		return 0;
+	/*
+	 * Use higher freq voltage even if an exact match is not available
+	 * we are probably masking a clock framework bug, so warn
+	 */
+	if (unlikely(freq != sr1.vdd_opp_clk->rate))
+		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
+			   __func__, freq, sr1.vdd_opp_clk->rate);
 
 	return opp_get_opp_id(opp);
 }
@@ -165,15 +174,23 @@ static u8 get_vdd1_opp(void)
 static u8 get_vdd2_opp(void)
 {
 	struct omap_opp *opp;
+	unsigned long freq;
 
 	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
 							l3_opps == NULL)
 		return 0;
-
-	opp = opp_find_freq_exact(l3_opps, sr2.vdd_opp_clk->rate, true);
+	freq = sr2.vdd_opp_clk->rate;
+	opp = opp_find_freq_ceil(l3_opps, &freq);
 	if (IS_ERR(opp))
 		return 0;
 
+	/*
+	 * Use higher freq voltage even if an exact match is not available
+	 * we are probably masking a clock framework bug, so warn
+	 */
+	if (unlikely(freq != sr2.vdd_opp_clk->rate))
+		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
+			   __func__, freq, sr2.vdd_opp_clk->rate);
 	return opp_get_opp_id(opp);
 }
 
-- 
1.6.3.3

