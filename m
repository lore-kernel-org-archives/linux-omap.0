From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/2] Move voltage controller configuration to pm34xx.c
Date: Thu, 31 Jul 2008 16:37:37 +0300
Message-ID: <1217511458-9950-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45108 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYGaNiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 09:38:50 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6VDcjmu027760
	for <linux-omap@vger.kernel.org>; Thu, 31 Jul 2008 16:38:47 +0300
In-Reply-To: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   60 -------------------------------------
 1 files changed, 0 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b41fe96..7e4f9a4 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -362,64 +362,6 @@ static void sr_configure_vp(int srid)
 	}
 }
 
-static void sr_configure_vc(void)
-{
-	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
-			(R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
-			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
-
-	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
-			(R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
-			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
-
-	prm_write_mod_reg((OMAP3430_VC_CMD_VAL0_ON <<
-		OMAP3430_VC_CMD_ON_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
-		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
-
-	prm_write_mod_reg((OMAP3430_VC_CMD_VAL1_ON <<
-		OMAP3430_VC_CMD_ON_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
-		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1,
-				OMAP3430_GR_MOD,
-				OMAP3_PRM_VC_CH_CONF_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
-				OMAP3430_GR_MOD,
-				OMAP3_PRM_VC_I2C_CFG_OFFSET);
-
-	/* Setup voltctrl and other setup times */
-	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
-#ifdef CONFIG_OMAP_SYSOFFMODE
-	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
-			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTCTRL_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
-			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
-			OMAP3430_SETUP_TIME2_SHIFT) |
-			(OMAP3430_VOLTSETUP_TIME1 <<
-			OMAP3430_SETUP_TIME1_SHIFT),
-			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTOFFSET_OFFSET);
-	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTSETUP2_OFFSET);
-#else
-	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTCTRL_OFFSET);
-#endif
-
-}
-
 static void sr_configure(struct omap_sr *sr)
 {
 	u32 sr_config;
@@ -845,8 +787,6 @@ static int __init omap3_sr_init(void)
 	sr_set_nvalues(&sr2);
 	sr_configure_vp(SR2);
 
-	sr_configure_vc();
-
 	/* Enable SR on T2 */
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 					R_DCDC_GLOBAL_CFG);
-- 
1.5.6.3

