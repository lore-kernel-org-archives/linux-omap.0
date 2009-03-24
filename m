From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 02/08] OMAP3: SR: Update VDD1/2 voltages at boot
Date: Tue, 24 Mar 2009 16:23:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756975AbZCXKyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:54:05 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OArv9a025181
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:54:03 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OArvBV026153
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:23:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

Currently vdd1 and vdd2 voltages are updated only after OMAP wakes up
from RET/OFF. This patch forces update according to boot OPP on boot.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   82 +++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 36 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:40:25.024122683 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:40:42.652592893 +0530
@@ -31,15 +31,12 @@
 #include <mach/control.h>
 #include <mach/clock.h>
 #include <mach/omap-pm.h>
+#include <mach/resource.h>
 
 #include "prm.h"
 #include "smartreflex.h"
 #include "prm-regbits-34xx.h"
 
-/* XXX: These should be relocated where-ever the OPP implementation will be */
-u32 current_vdd1_opp;
-u32 current_vdd2_opp;
-
 struct omap_sr {
 	int		srid;
 	int		is_sr_reset;
@@ -253,9 +250,11 @@
 	u32 vpconfig;
 
 	if (srid == SR1) {
-		vpconfig = PRM_VP1_CONFIG_ERROROFFSET | PRM_VP1_CONFIG_ERRORGAIN
-					| PRM_VP1_CONFIG_INITVOLTAGE
-					| PRM_VP1_CONFIG_TIMEOUTEN;
+		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
+			PRM_VP1_CONFIG_ERRORGAIN |
+			PRM_VP1_CONFIG_TIMEOUTEN |
+			mpu_opps[resource_get_level("vdd1_opp")].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
 
 		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP1_CONFIG_OFFSET);
@@ -277,15 +276,25 @@
 
 		/* Trigger initVDD value copy to voltage processor */
 		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+
 		/* Clear initVDD copy trigger bit */
 		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
+				       OMAP3_PRM_VP1_CONFIG_OFFSET);
+
+		/* Force update of voltage */
+		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+		/* Clear force bit */
+		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 
 	} else if (srid == SR2) {
-		vpconfig = PRM_VP2_CONFIG_ERROROFFSET | PRM_VP2_CONFIG_ERRORGAIN
-					| PRM_VP2_CONFIG_INITVOLTAGE
-					| PRM_VP2_CONFIG_TIMEOUTEN;
+		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
+			PRM_VP2_CONFIG_ERRORGAIN |
+			PRM_VP2_CONFIG_TIMEOUTEN |
+			l3_opps[resource_get_level("vdd2_opp")].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
 
 		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP2_CONFIG_OFFSET);
@@ -306,11 +315,19 @@
 					OMAP3_PRM_VP2_VLIMITTO_OFFSET);
 
 		/* Trigger initVDD value copy to voltage processor */
-		prm_set_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* Reset initVDD copy trigger bit */
-		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
+		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+
+		/* Clear initVDD copy trigger bit */
+		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP2_CONFIG_OFFSET);
+
+		/* Force update of voltage */
+		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+		/* Clear force bit */
+		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP2_CONFIG_OFFSET);
 
 	}
 }
@@ -553,9 +570,9 @@
 			sr_clk_enable(sr);
 
 			if (srid == SR1)
-				target_opp_no = get_opp_no(current_vdd1_opp);
+				target_opp_no = resource_get_level("vdd1_opp");
 			else if (srid == SR2)
-				target_opp_no = get_opp_no(current_vdd2_opp);
+				target_opp_no = resource_get_level("vdd2_opp");
 
 			sr_configure(sr);
 
@@ -687,7 +704,7 @@
 		return -EINVAL;
 	}
 
-	current_vdd1opp_no = get_opp_no(current_vdd1_opp);
+	current_vdd1opp_no = resource_get_level("vdd1_opp");
 
 	if (value == 0)
 		sr_stop_vddautocomap(SR1);
@@ -725,7 +742,7 @@
 		return -EINVAL;
 	}
 
-	current_vdd2opp_no = get_opp_no(current_vdd2_opp);
+	current_vdd2opp_no = resource_get_level("vdd2_opp");
 
 	if (value == 0)
 		sr_stop_vddautocomap(SR2);
@@ -751,13 +768,14 @@
 	int ret = 0;
 	u8 RdReg;
 
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		current_vdd1_opp = PRCM_VDD1_OPP3;
-		current_vdd2_opp = PRCM_VDD2_OPP3;
-	} else {
-		current_vdd1_opp = PRCM_VDD1_OPP1;
-		current_vdd2_opp = PRCM_VDD1_OPP1;
-	}
+	/* Enable SR on T2 */
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
+					R_DCDC_GLOBAL_CFG);
+
+	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
+	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
+					R_DCDC_GLOBAL_CFG);
+
 	if (cpu_is_omap34xx()) {
 		sr1.clk = clk_get(NULL, "sr1_fck");
 		sr2.clk = clk_get(NULL, "sr2_fck");
@@ -772,14 +790,6 @@
 	sr_set_nvalues(&sr2);
 	sr_configure_vp(SR2);
 
-	/* Enable SR on T2 */
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
-					R_DCDC_GLOBAL_CFG);
-
-	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
-	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
-					R_DCDC_GLOBAL_CFG);
-
 	printk(KERN_INFO "SmartReflex driver initialized\n");
 
 	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
