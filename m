From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Fix VDD2 OPP determining logic
Date: Fri, 22 May 2009 15:48:49 +0300
Message-ID: <1242996529-8655-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33727 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZEVMtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 08:49:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org

The VDD2 OPP table is as per L3 clock rates and not on DPLL2 rate.
So, we use the correct clock rate to calculate the current OPP
for VDD2.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/resource34xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 9908e52..d55cc51 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -172,6 +172,7 @@ static unsigned short get_opp(struct omap_opp *opp_freq_table,
  */
 void init_opp(struct shared_resource *resp)
 {
+	struct clk *l3_clk;
 	resp->no_of_users = 0;
 
 	if (!mpu_opps || !dsp_opps || !l3_opps)
@@ -190,8 +191,9 @@ void init_opp(struct shared_resource *resp)
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
+		l3_clk = clk_get(NULL, "l3_ick");
 		resp->curr_level = get_opp(l3_opps + MAX_VDD2_OPP,
-				dpll2_clk->rate);
+				l3_clk->rate);
 		curr_vdd2_opp = resp->curr_level;
 	}
 	return;
-- 
1.6.0.4

