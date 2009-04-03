From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 09/10] OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE
Date: Fri, 3 Apr 2009 21:39:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47601 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936116AbZDCQJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:09:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33G9QCK014444
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:09:32 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33G9PtF014963
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:39:25 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

This patch has some cleanup , replacing SR_PASS/FAIL,SR_TRUE/FALSE
with standard kernel values.

Signed-off-by: Teerth Reddy <teerth@ti.com>

---
 arch/arm/mach-omap2/smartreflex.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
@@ -410,7 +410,7 @@ static int sr_reset_voltage(int srid)
 		if (retries_cnt > 10) {
 			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
-			return SR_FAIL;
+			return 1;
 		}
 		if (loop_cnt > 50) {
 			retries_cnt++;
@@ -420,7 +420,7 @@ static int sr_reset_voltage(int srid)
 		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
 					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
 	}
-	return SR_PASS;
+	return 0;
 }
 
 static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
@@ -475,7 +475,7 @@ static int sr_enable(struct omap_sr *sr,
 	if (nvalue_reciprocal == 0) {
 		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
-		return SR_FALSE;
+		return false;
 	}
 
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
@@ -525,7 +525,7 @@ static int sr_enable(struct omap_sr *sr,
 
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
-	return SR_TRUE;
+	return true;
 }
 
 static void sr_disable(struct omap_sr *sr)
@@ -590,11 +590,11 @@ int sr_stop_vddautocomap(int srid)
 		sr->is_autocomp_active = 0;
 		/* Reset the volatage for current OPP */
 		sr_reset_voltage(srid);
-		return SR_TRUE;
+		return true;
 	} else {
 		pr_warning("SR%d: VDD autocomp is not active\n",
 								srid);
-		return SR_FALSE;
+		return false;
 	}
 
 }
@@ -710,7 +710,7 @@ int sr_voltagescale_vcbypass(u32 target_
 		if (retries_cnt > 10) {
 			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
-			return SR_FAIL;
+			return 1;
 		}
 		if (loop_cnt > 50) {
 			retries_cnt++;
@@ -730,7 +730,7 @@ int sr_voltagescale_vcbypass(u32 target_
 			sr_start_vddautocomap(SR2, target_opp_no);
 	}
 
-	return SR_PASS;
+	return 0;
 }
 
 /* Sysfs interface to select SR VDD1 auto compensation */