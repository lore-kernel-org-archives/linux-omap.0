From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: sr: Update ON voltage levels based on VSEL
Date: Mon, 23 Nov 2009 19:08:37 +0530
Message-ID: <1258983517-16169-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbZKWNig (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 08:38:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANDcd6W023930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 07:38:42 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The settings for ON voltage level in the registers
PRM_VC_CMD_VAL_0,1 was not updated based on OPP
table.

Once the MPU resumes from OFF mode (during idle OR
suspend) the VDD1 voltage always returns to 1.2V.

This patch programs the value based on current OPP.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index be3a1da..4cbbd6f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -313,6 +313,15 @@ static void sr_configure_vp(int srid)
 			PRM_VP1_CONFIG_TIMEOUTEN |
 			vsel << OMAP3430_INITVOLTAGE_SHIFT;
 
+		/*
+		 * Update the 'ON' voltage levels based on the VSEL.
+		 * (See spruf8c.pdf sec 1.5.3.1)
+		 */
+		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
+				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+
 		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP1_CONFIG_OFFSET);
 		prm_write_mod_reg(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
@@ -354,6 +363,15 @@ static void sr_configure_vp(int srid)
 		else
 			vsel = l3_opps[target_opp_no].vsel;
 
+		/*
+		 * Update the 'ON' voltage levels based on the VSEL.
+		 * (See spruf8c.pdf sec 1.5.3.1)
+		 */
+		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
+				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+
 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
 			PRM_VP2_CONFIG_ERRORGAIN |
 			PRM_VP2_CONFIG_TIMEOUTEN |
@@ -391,7 +409,6 @@ static void sr_configure_vp(int srid)
 		/* Clear force bit */
 		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
 				       OMAP3_PRM_VP2_CONFIG_OFFSET);
-
 	}
 }
 
-- 
1.6.2.2

