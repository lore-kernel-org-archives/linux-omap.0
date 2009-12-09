From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 05/10 V4] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Wed,  9 Dec 2009 00:17:10 -0600
Message-ID: <1260339435-20294-6-git-send-email-nm@ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
 <1260339435-20294-5-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36538 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755736AbZLIGRY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:17:24 -0500
In-Reply-To: <1260339435-20294-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

SmartReflex implements a get_opp to search through the opp table,
replace it opp_is_valid to verify the OPPs and getting the opp_id.

NOTE: usage of opp_id is deprecated and this introduces the following
warnings:
arch/arm/mach-omap2/smartreflex.c: In function 'get_vdd1_opp':
arch/arm/mach-omap2/smartreflex.c:161: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)
arch/arm/mach-omap2/smartreflex.c: In function 'get_vdd2_opp':
arch/arm/mach-omap2/smartreflex.c:176: warning: 'opp_id' is deprecated (declared at arch/arm/plat-omap/include/plat/opp.h:33)

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   44 +++++++++++-------------------------
 1 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index be3a1da..ccc98a0 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -146,50 +146,34 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
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
+	struct omap_opp *opp;
 
 	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
 							mpu_opps == NULL)
 		return 0;
 
-	opp = get_opp(mpu_opps + MAX_VDD1_OPP, sr1.vdd_opp_clk->rate);
-	return opp;
+	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
+	if (IS_ERR(opp))
+		return 0;
+
+	return opp->opp_id;
 }
 
-static u16 get_vdd2_opp(void)
+static u8 get_vdd2_opp(void)
 {
-	u16 opp;
+	struct omap_opp *opp;
 
 	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
 							l3_opps == NULL)
 		return 0;
 
-	opp = get_opp(l3_opps + MAX_VDD2_OPP, sr2.vdd_opp_clk->rate);
-	return opp;
+	opp = opp_find_freq_exact(l3_opps, sr2.vdd_opp_clk->rate, true);
+	if (IS_ERR(opp))
+		return 0;
+
+	return opp->opp_id;
 }
 
 
-- 
1.6.3.3

