From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/2] Add early init for voltage controller configuration and off mode polarity.
Date: Thu, 31 Jul 2008 16:37:38 +0300
Message-ID: <1217511458-9950-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
 <1217511458-9950-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23176 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYGaNit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 09:38:49 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6VDbAYl012484
	for <linux-omap@vger.kernel.org>; Thu, 31 Jul 2008 08:38:48 -0500
In-Reply-To: <1217511458-9950-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   71 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8b6b09e..06eae7e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -46,6 +46,8 @@
 #define OMAP3430_PRM_RSTST      \
 	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
 
+#define OFFMODE_POL	(1 << 3)
+
 u32 context_mem[128];
 
 struct power_state {
@@ -707,6 +709,64 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
+static void __init configure_vc(void)
+{
+	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
+			(R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
+			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
+
+	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
+			(R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
+			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
+
+	prm_write_mod_reg((OMAP3430_VC_CMD_VAL0_ON <<
+		OMAP3430_VC_CMD_ON_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+
+	prm_write_mod_reg((OMAP3430_VC_CMD_VAL1_ON <<
+		OMAP3430_VC_CMD_ON_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1,
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_CH_CONF_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_I2C_CFG_OFFSET);
+
+	/* Setup voltctrl and other setup times */
+
+#ifdef CONFIG_OMAP_SYSOFFMODE
+	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
+			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTCTRL_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
+			OMAP3_PRM_CLKSETUP_OFFSET);
+	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
+			OMAP3430_SETUP_TIME2_SHIFT) |
+			(OMAP3430_VOLTSETUP_TIME1 <<
+			OMAP3430_SETUP_TIME1_SHIFT),
+			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTSETUP2_OFFSET);
+#else
+	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTCTRL_OFFSET);
+#endif
+
+}
+
 void omap3_save_per_ctx(void)
 {
 	omap_gpio_save();
@@ -1009,3 +1069,14 @@ void save_scratchpad_contents(void)
 	*(scratchpad_address++) = (u32) sdram_context_address;
 }
 
+static int __init omap3_pm_early_init(void)
+{
+	prm_clear_mod_reg_bits(OFFMODE_POL, OMAP3430_GR_MOD,
+				OMAP3_PRM_POLCTRL_OFFSET);
+
+	configure_vc();
+
+	return 0;
+}
+
+arch_initcall(omap3_pm_early_init);
-- 
1.5.6.3

