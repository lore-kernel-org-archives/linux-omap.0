From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 03/10] 34XX: PM: Workaround for missing smartreflex driver
Date: Fri, 16 May 2008 14:04:59 +0300
Message-ID: <1210935899-27958-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59210 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbYEPLFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:08 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB50CV003216
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:06 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This workaround is needed because we don't have smartreflex
driver. These configurations are taken from TI's reference code.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c     |   67 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/twl4030-core.c |    9 +++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e578503..49e2989 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,6 +346,25 @@ static struct platform_suspend_ops omap_pm_ops = {
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
 	u32 v;
@@ -360,6 +379,54 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	__raw_writel(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 		     OMAP3430_PRM_IRQENABLE_MPU);
+
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		/* XXX These are smartreflex related and are here as long as we
+		 * have working	smartreflex driver in linux-omap tree */
+		__raw_writel((R_SRI2C_SLAVE_ADDR <<
+			      OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT) |
+			     (R_SRI2C_SLAVE_ADDR <<
+			      OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT),
+			     OMAP3430_PRM_VC_SMPS_SA);
+
+		__raw_writel((R_VDD2_SR_CONTROL <<
+			      OMAP3430_VOLRA1_SHIFT) |
+			     (R_VDD1_SR_CONTROL <<
+			      OMAP3430_VOLRA0_SHIFT),
+			     OMAP3430_PRM_VC_SMPS_VOL_RA);
+
+		__raw_writel((PRM_VC_CMD_VAL0_ON <<
+			      OMAP3430_VC_CMD_ON_SHIFT) |
+			     (PRM_VC_CMD_VAL0_ONLP <<
+			      OMAP3430_VC_CMD_ONLP_SHIFT) |
+			     (PRM_VC_CMD_VAL0_RET <<
+			      OMAP3430_VC_CMD_RET_SHIFT) |
+			     (PRM_VC_CMD_VAL0_OFF <<
+			      OMAP3430_VC_CMD_OFF_SHIFT),
+			     OMAP3430_PRM_VC_CMD_VAL_0);
+
+		__raw_writel((PRM_VC_CMD_VAL1_ON <<
+			      OMAP3430_VC_CMD_ON_SHIFT) |
+			     (PRM_VC_CMD_VAL1_ONLP <<
+			      OMAP3430_VC_CMD_ONLP_SHIFT) |
+			     (PRM_VC_CMD_VAL1_RET <<
+			      OMAP3430_VC_CMD_RET_SHIFT) |
+			     (PRM_VC_CMD_VAL1_OFF <<
+			      OMAP3430_VC_CMD_OFF_SHIFT),
+			     OMAP3430_PRM_VC_CMD_VAL_1);
+
+		__raw_writel(OMAP3430_CMD1 |
+			     OMAP3430_RAV1,
+			     OMAP3430_PRM_VC_CH_CONF);
+
+		__raw_writel(OMAP3430_MCODE_SHIFT |
+			     OMAP3430_HSEN |
+			     OMAP3430_SREN,
+			     OMAP3430_PRM_VC_I2C_CFG);
+
+		__raw_writel(PRM_VOLTCTRL_AUTO_RET,
+			     OMAP3430_PRM_VOLTCTRL);
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

