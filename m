From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/4] OMAP SR/SRF: use OPP API for OPP ID, find by index
Date: Fri, 18 Dec 2009 09:46:00 -0800
Message-ID: <1261158361-28974-4-git-send-email-khilman@deeprootsystems.com>
References: <1261158361-28974-1-git-send-email-khilman@deeprootsystems.com>
 <1261158361-28974-2-git-send-email-khilman@deeprootsystems.com>
 <1261158361-28974-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47294 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbZLRRqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:46:12 -0500
Received: by yxe17 with SMTP id 17so3116246yxe.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:46:09 -0800 (PST)
In-Reply-To: <1261158361-28974-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

SR and SRF currenly direclty access OPP struct internals.  Use new
accessor functions so OPP layer details can be further hidden.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/resource34xx.c |   14 +++++++++++---
 arch/arm/mach-omap2/smartreflex.c  |    4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 05e70b7..b80ee88 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -204,7 +204,7 @@ static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
 	opp = opp_find_freq_ceil(opps, &freq);
 	if (IS_ERR(opp))
 		return -EINVAL;
-	*opp_id = opp->opp_id;
+	*opp_id = opp_get_opp_id(opp);
 	return 0;
 }
 
@@ -336,9 +336,17 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 	unsigned long freq;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 	unsigned long t_opp, c_opp;
+	int t_id, c_id;
+	struct omap_opp *opp_target, *opp_current;
 
-	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
-	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
+	opp_target = opp_find_by_index(opp, target_level);
+	t_id = opp_get_opp_id(opp_target);
+
+	opp_current = opp_find_by_index(opp, current_level);
+	c_id = opp_get_opp_id(opp_current);
+
+	t_opp = ID_VDD(res) | ID_OPP_NO(t_id);
+	c_opp = ID_VDD(res) | ID_OPP_NO(c_id);
 #endif
 
 	/* See if have a freq associated, if not, invalid opp */
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9c0d5bf..d341857 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -159,7 +159,7 @@ static u8 get_vdd1_opp(void)
 	if (IS_ERR(opp))
 		return 0;
 
-	return opp->opp_id;
+	return opp_get_opp_id(opp);
 }
 
 static u8 get_vdd2_opp(void)
@@ -174,7 +174,7 @@ static u8 get_vdd2_opp(void)
 	if (IS_ERR(opp))
 		return 0;
 
-	return opp->opp_id;
+	return opp_get_opp_id(opp);
 }
 
 
-- 
1.6.6.rc2.1.g42108

