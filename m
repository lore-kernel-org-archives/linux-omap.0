From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 08/08] OMAP3: SR: Replace SR_PASS/FAIL,SR_TRUE/FALSE with
 standard kernel values
Date: Tue, 24 Mar 2009 16:26:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58085 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbZCXK43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:56:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OAuLJp026902
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:56:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OAuLDq026714
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:26:21 +0530 (IST)
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
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:42:33.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:45:59.336965640 +0530
@@ -411,7 +411,7 @@
 		if (retries_cnt > 10) {
 			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
-			return SR_FAIL;
+			return 1;
 		}
 		if (loop_cnt > 50) {
 			retries_cnt++;
@@ -421,7 +421,7 @@
 		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
 					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
 	}
-	return SR_PASS;
+	return 0;
 }
 
 static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
@@ -476,7 +476,7 @@
 	if (nvalue_reciprocal == 0) {
 		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
-		return SR_FALSE;
+		return false;
 	}
 
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
@@ -526,7 +526,7 @@
 
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
-	return SR_TRUE;
+	return true;
 }
 
 static void sr_disable(struct omap_sr *sr)
@@ -591,11 +591,11 @@
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
@@ -711,7 +711,7 @@
 		if (retries_cnt > 10) {
 			pr_info("Loop count exceeded in check SR I2C"
 								"write\n");
-			return SR_FAIL;
+			return 1;
 		}
 		if (loop_cnt > 50) {
 			retries_cnt++;
@@ -731,7 +731,7 @@
 			sr_start_vddautocomap(SR2, target_opp_no);
 	}
 
-	return SR_PASS;
+	return 0;
 }
 
 /* Sysfs interface to select SR VDD1 auto compensation */
