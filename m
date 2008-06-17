From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 3/8] 34XX: PM: Workaround for missing smartreflex driver
Date: Tue, 17 Jun 2008 10:30:59 +0300
Message-ID: <1213687859-29951-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63888 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbYFQHbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:31:05 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5H7V2AI018314
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 02:31:03 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5H7Ux4q013552
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:30:59 +0300
In-Reply-To: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This workaround is needed because we don't have smartreflex
driver. These configurations are taken from TI's reference code.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c     |   74 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/twl4030-core.c |    9 +++++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index be3c74f..1476597 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -357,6 +357,25 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+/* PRM_VC_CMD_VAL_0 specific bits */
+#define PRM_VC_CMD_VAL0_ON		0x30
+#define PRM_VC_CMD_VAL0_ONLP		0x18
+#define PRM_VC_CMD_VAL0_RET		0x18
+#define PRM_VC_CMD_VAL0_OFF		0x18
+
+/* PRM_VC_CMD_VAL_1 specific bits */
+#define PRM_VC_CMD_VAL1_ON		0x2C
+#define PRM_VC_CMD_VAL1_ONLP		0x18
+#define PRM_VC_CMD_VAL1_RET		0x18
+#define PRM_VC_CMD_VAL1_OFF		0x18
+
+/* PRM_VOLTCTRL */
+#define PRM_VOLTCTRL_AUTO_RET		0x2
+
+/* T2 SMART REFLEX */
+#define R_SRI2C_SLAVE_ADDR		0x12
+#define R_VDD1_SR_CONTROL		0x00
+#define R_VDD2_SR_CONTROL		0x01
 static void __init prcm_setup_regs(void)
 {
 	/* setup wakup source */
@@ -369,6 +388,61 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
+
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		/* XXX These are smartreflex related and are here as long as we
+		 * have working	smartreflex driver in linux-omap tree */
+		prm_write_mod_reg((R_SRI2C_SLAVE_ADDR <<
+				    OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT) |
+				   (R_SRI2C_SLAVE_ADDR <<
+				    OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_SMPS_SA_OFFSET);
+
+		prm_write_mod_reg((R_VDD2_SR_CONTROL <<
+				    OMAP3430_VOLRA1_SHIFT) |
+				   (R_VDD1_SR_CONTROL <<
+				    OMAP3430_VOLRA0_SHIFT),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
+
+		prm_write_mod_reg((PRM_VC_CMD_VAL0_ON <<
+				    OMAP3430_VC_CMD_ON_SHIFT) |
+				   (PRM_VC_CMD_VAL0_ONLP <<
+				    OMAP3430_VC_CMD_ONLP_SHIFT) |
+				   (PRM_VC_CMD_VAL0_RET <<
+				    OMAP3430_VC_CMD_RET_SHIFT) |
+				   (PRM_VC_CMD_VAL0_OFF <<
+				    OMAP3430_VC_CMD_OFF_SHIFT),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+
+		prm_write_mod_reg((PRM_VC_CMD_VAL1_ON <<
+				    OMAP3430_VC_CMD_ON_SHIFT) |
+				   (PRM_VC_CMD_VAL1_ONLP <<
+				    OMAP3430_VC_CMD_ONLP_SHIFT) |
+				   (PRM_VC_CMD_VAL1_RET <<
+				    OMAP3430_VC_CMD_RET_SHIFT) |
+				   (PRM_VC_CMD_VAL1_OFF <<
+				    OMAP3430_VC_CMD_OFF_SHIFT),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+
+		prm_write_mod_reg(OMAP3430_CMD1 |
+				   OMAP3430_RAV1,
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_CH_CONF_OFFSET);
+
+		prm_write_mod_reg(OMAP3430_MCODE_SHIFT |
+				   OMAP3430_HSEN |
+				   OMAP3430_SREN,
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_I2C_CFG_OFFSET);
+
+		prm_write_mod_reg(PRM_VOLTCTRL_AUTO_RET,
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VOLTCTRL_OFFSET);
+	}
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 8822653..96e6216 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -119,6 +119,7 @@
 /* Few power values */
 #define R_CFG_BOOT			0x05
 #define R_PROTECT_KEY			0x0E
+#define R_DCDC_GLOBAL_CFG              0x06
 
 /* access control */
 #define KEY_UNLOCK1			0xce
@@ -709,6 +710,14 @@ static int power_companion_init(void)
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
 
+	/* XXX Enable smart reflex. Voltage scaling method should be
+	 * passed in platform data */
+	e |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER,
+				 &ctrl, R_DCDC_GLOBAL_CFG);
+	ctrl |= 0x8;
+	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				  ctrl, R_DCDC_GLOBAL_CFG);
+
 	return e;
 }
 
-- 
1.5.5

