From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 09/10] OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE
Date: Wed, 15 Apr 2009 18:25:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251815@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39291 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758914AbZDOMz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:55:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3FCtoYM008101
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 07:55:56 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3FCtn1E021755
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 18:25:49 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

This patch has some cleanup , replacing SR_PASS/FAIL,SR_TRUE/FALSE
with standard kernel values.

Signed-off-by: Teerth Reddy <teerth@ti.com>

---
 arch/arm/mach-omap2/smartreflex.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-04-15 11:46:15.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-04-15 11:46:15.000000000 +0530
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
