From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP3: PM: quickly hack fix up init_opp
Date: Sat,  1 May 2010 10:43:09 -0500
Message-ID: <1272728589-5313-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55945 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab0EAPnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 11:43:21 -0400
Received: by gyg13 with SMTP id 13so563129gyg.19
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 08:43:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Peter Tseng <tsenpet09@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>

init_opp is seen to crash, in resource34xx.c BUG() causes
a kernel oops when OPP layer is not registered!

Original Report:
http://marc.info/?l=linux-omap&m=127268352116119&w=2

Cc: Peter Tseng <tsenpet09@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by: Peter Tseng <tsenpet09@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
IMPORTANT: Completely untested!! just for a dry-run and
srf is going to go away in a month, so this is more or
less a curio..

 arch/arm/mach-omap2/resource34xx.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..ae8bd09 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -226,14 +226,36 @@ void init_opp(struct shared_resource *resp)
 		dpll1_clk = clk_get(NULL, "dpll1_ck");
 		dpll2_clk = clk_get(NULL, "dpll2_ck");
 		ret = freq_to_opp(&opp_id, OPP_MPU, dpll1_clk->rate);
-		BUG_ON(ret); /* TBD Cleanup handling */
+		if (ret) {
+			pr_err("%s: initializing %s failed! !match for %ld\n",
+				__func__, resp->name, dpll1_clk->rate);
+			if (dpll1_clk)
+				clk_put(dpll1_clk);
+			if (dpll2_clk)
+				clk_put(dpll2_clk);
+			dpll1_clk = NULL;
+			dpll2_clk = NULL;
+			vdd1_resp = NULL;
+			return;
+		}
 		curr_vdd1_opp = opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
 		l3_clk = clk_get(NULL, "l3_ick");
 		ret = freq_to_opp(&opp_id, OPP_L3, l3_clk->rate);
-		BUG_ON(ret); /* TBD Cleanup handling */
+		if (ret) {
+			pr_err("%s: initializing %s failed! !match for %ld\n",
+				__func__, resp->name, l3_clk->rate);
+			if (l3_clk)
+				clk_put(l3_clk);
+			if (dpll3_clk)
+				clk_put(dpll3_clk);
+			l3_clk = NULL;
+			dpll3_clk = NULL;
+			vdd2_resp = NULL;
+			return;
+		}
 		curr_vdd2_opp = opp_id;
 	}
 	resp->curr_level = opp_id;
-- 
1.7.0.4

