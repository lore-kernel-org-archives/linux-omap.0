From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 01/08] OMAP3: SR: Fix init voltage on OPP change
Date: Tue, 24 Mar 2009 16:23:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9AA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36460 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758239AbZCXKxl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:53:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OArX3Y019101
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:53:39 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OArXKY026091
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:23:33 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Rajendra Nayak <rnayak@ti.com>

This patch fixes a bug wherein the inital voltage was not set
correctly on a OPP change

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   42 ++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 4 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:25:28.133984580 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.c	2009-03-24 14:40:25.024122683 +0530
@@ -30,6 +30,7 @@
 #include <mach/omap34xx.h>
 #include <mach/control.h>
 #include <mach/clock.h>
+#include <mach/omap-pm.h>
 
 #include "prm.h"
 #include "smartreflex.h"
@@ -183,7 +184,6 @@
 		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR1_SENNENABLE_MASK) >>
 					OMAP343X_SR1_SENNENABLE_SHIFT;
-
 		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
 					OMAP343X_SR1_SENPENABLE_MASK) >>
 					OMAP343X_SR1_SENPENABLE_SHIFT;
@@ -364,7 +364,12 @@
 
 static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 {
-	u32 nvalue_reciprocal;
+	u32 nvalue_reciprocal, v;
+
+	if (!(mpu_opps && l3_opps)) {
+		pr_notice("VSEL values not found\n");
+		return false;
+	}
 
 	sr->req_opp_no = target_opp_no;
 
@@ -418,14 +423,43 @@
 	sr_modify_reg(sr, ERRCONFIG,
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+
 	if (sr->srid == SR1) {
+		/* set/latch init voltage */
+		v = prm_read_mod_reg(OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
+		v |= mpu_opps[target_opp_no].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
+		prm_write_mod_reg(v, OMAP3430_GR_MOD,
+				  OMAP3_PRM_VP1_CONFIG_OFFSET);
+		/* write1 to latch */
+		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+		/* write2 clear */
+		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 		/* Enable VP1 */
 		prm_set_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-				OMAP3_PRM_VP1_CONFIG_OFFSET);
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
 	} else if (sr->srid == SR2) {
+		/* set/latch init voltage */
+		v = prm_read_mod_reg(OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
+		v |= l3_opps[target_opp_no].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
+		prm_write_mod_reg(v, OMAP3430_GR_MOD,
+				  OMAP3_PRM_VP2_CONFIG_OFFSET);
+		/* write1 to latch */
+		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+		/* write2 clear */
+		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP2_CONFIG_OFFSET);
 		/* Enable VP2 */
 		prm_set_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-				OMAP3_PRM_VP2_CONFIG_OFFSET);
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
 	}
 
 	/* SRCONFIG - enable SR */
