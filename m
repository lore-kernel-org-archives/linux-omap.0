From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Wed, 11 Nov 2009 23:45:17 -0600
Message-ID: <1258004721-7315-6-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
 <1258004721-7315-2-git-send-email-nm@ti.com>
 <1258004721-7315-3-git-send-email-nm@ti.com>
 <1258004721-7315-4-git-send-email-nm@ti.com>
 <1258004721-7315-5-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbZKLFpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:45:47 -0500
In-Reply-To: <1258004721-7315-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

SmartReflex implements a get_opp to search through the opp table,
replace it with the accessor function as it is a duplicate of
freq_to_opp

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   36 ++++++++----------------------------
 1 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index be3a1da..d34224d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -146,49 +146,29 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
 		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT);
 }
 
-/* determine the current OPP from the frequency
- * we need to give this function last element of OPP rate table
- * and the frequency
- */
-static u16 get_opp(struct omap_opp *opp_freq_table,
-					unsigned long freq)
-{
-	struct omap_opp *prcm_config;
-
-	prcm_config = opp_freq_table;
-
-	if (prcm_config->rate <= freq)
-		return prcm_config->opp_id; /* Return the Highest OPP */
-	for (; prcm_config->rate; prcm_config--)
-		if (prcm_config->rate < freq)
-			return (prcm_config+1)->opp_id;
-		else if (prcm_config->rate == freq)
-			return prcm_config->opp_id;
-	/* Return the least OPP */
-	return (prcm_config+1)->opp_id;
-}
-
-static u16 get_vdd1_opp(void)
+static u8 get_vdd1_opp(void)
 {
-	u16 opp;
+	u8 opp;
 
 	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
 							mpu_opps == NULL)
 		return 0;
 
-	opp = get_opp(mpu_opps + MAX_VDD1_OPP, sr1.vdd_opp_clk->rate);
+	/* Not expected to fail.. */
+	BUG_ON(freq_to_opp(&opp, mpu_opps, sr1.vdd_opp_clk->rate));
 	return opp;
 }
 
-static u16 get_vdd2_opp(void)
+static u8 get_vdd2_opp(void)
 {
-	u16 opp;
+	u8 opp;
 
 	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
 							l3_opps == NULL)
 		return 0;
 
-	opp = get_opp(l3_opps + MAX_VDD2_OPP, sr2.vdd_opp_clk->rate);
+	/* Not expected to fail.. */
+	BUG_ON(freq_to_opp(&opp, l3_opps, sr2.vdd_opp_clk->rate));
 	return opp;
 }
 
-- 
1.6.3.3

