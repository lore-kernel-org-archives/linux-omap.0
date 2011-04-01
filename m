From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 13/13] OMAP3+: VC: make I2C config programmable with PMIC-specific settings
Date: Fri,  1 Apr 2011 16:41:11 -0700
Message-ID: <1301701271-22096-14-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33484 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860Ab1DAXk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:59 -0400
Received: by mail-iy0-f170.google.com with SMTP id 12so8414340iyb.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:58 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Remove hard-coded I2C configuration in favor of settings that can be
configured from PMIC-specific values.  Currently only high-speed mode
and the master-code value are supported, since they were the only
fields currently used, but extending this is now trivial.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c    |    4 +++
 arch/arm/mach-omap2/vc.c          |   51 +++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/vc.h          |    8 +++++-
 arch/arm/mach-omap2/vc3xxx_data.c |    3 ++
 arch/arm/mach-omap2/vc44xx_data.c |    3 ++
 arch/arm/mach-omap2/voltage.h     |    4 +++
 6 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index feefd30..30f4323 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -159,6 +159,7 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_MPU_SR_CONTROL_REG,
+	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
@@ -179,6 +180,7 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
 	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl4030_vsel_to_uv,
 	.uv_to_vsel		= twl4030_uv_to_vsel,
 };
@@ -199,6 +201,7 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_MPU_SR_VOLT_REG,
+	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
@@ -219,6 +222,7 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
 	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
 	.volt_reg_addr		= OMAP4_VDD_IVA_SR_VOLT_REG,
+	.i2c_high_speed		= true,
 	.vsel_to_uv		= twl6030_vsel_to_uv,
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 910d02f..f8cdb87 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -200,13 +200,6 @@ static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 	if (is_initialized)
 		return;
 
-	/*
-	 * Generic VC parameters init
-	 * XXX This data should be abstracted out
-	 */
-	voltdm->write(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK,
-		       OMAP3_PRM_VC_I2C_CFG_OFFSET);
-
 	omap3_vfsm_init(voltdm);
 
 	is_initialized = true;
@@ -229,6 +222,48 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 	is_initialized = true;
 }
 
+/**
+ * omap_vc_i2c_init - initialize I2C interface to PMIC
+ * @voltdm: voltage domain containing VC data
+ *
+ * Use PMIC supplied seetings for I2C high-speed mode and
+ * master code (if set) and program the VC I2C configuration
+ * register.
+ *
+ * The VC I2C configuration is common to all VC channels,
+ * so this function only configures I2C for the first VC
+ * channel registers.  All other VC channels will use the
+ * same configuration.
+ */
+void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
+{
+	struct omap_vc_channel *vc = voltdm->vc;
+	static bool initialized;
+	static bool i2c_high_speed;
+	u8 mcode;
+
+	if (initialized) {
+		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
+			pr_warn("%s: I2C config for all channels must match.",
+				__func__);
+		return;
+	}
+
+	i2c_high_speed = voltdm->pmic->i2c_high_speed;
+	if (i2c_high_speed)
+		voltdm->rmw(vc->common->i2c_cfg_hsen_shift,
+			    vc->common->i2c_cfg_hsen_shift,
+			    vc->common->i2c_cfg_reg);
+
+	mcode = voltdm->pmic->i2c_mcode;
+	if (mcode)
+		voltdm->rmw(vc->common->i2c_mcode_mask,
+			    mcode << __ffs(vc->common->i2c_mcode_mask),
+			    vc->common->i2c_cfg_reg);
+
+	initialized = true;
+}
+
 void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
@@ -297,6 +332,8 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		    vc->setup_time << __ffs(voltdm->vfsm->voltsetup_mask),
 		    voltdm->vfsm->voltsetup_reg);
 
+	omap_vc_i2c_init(voltdm);
+
 	if (cpu_is_omap34xx())
 		omap3_vc_init_channel(voltdm);
 	else if (cpu_is_omap44xx())
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index e0d2931..85f13f1 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -35,6 +35,9 @@ struct voltagedomain;
  * @cmd_onlp_shift: ONLP field shift in PRM_VC_CMD_VAL_* register
  * @cmd_ret_shift: RET field shift in PRM_VC_CMD_VAL_* register
  * @cmd_off_shift: OFF field shift in PRM_VC_CMD_VAL_* register
+ * @i2c_cfg_reg: I2C configuration register offset
+ * @i2c_cfg_hsen_shift: high-speed mode bit field shift in I2C config register
+ * @i2c_mcode_mask: MCODE field mask for I2C config register
  *
  * XXX One of cmd_on_mask and cmd_on_shift are not needed
  * XXX VALID should probably be a shift, not a mask
@@ -54,6 +57,9 @@ struct omap_vc_common {
 	u8 cmd_ret_shift;
 	u8 cmd_off_shift;
 	u8 cfg_channel_reg;
+	u8 i2c_cfg_reg;
+	u8 i2c_cfg_hsen_shift;
+	u8 i2c_mcode_mask;
 };
 
 /**
@@ -69,6 +75,7 @@ struct omap_vc_channel {
 	u8 cmd_reg_addr;
 	u8 cfg_channel;
 	u16 setup_time;
+	bool i2c_high_speed;
 
 	/* register access data */
 	const struct omap_vc_common *common;
@@ -95,6 +102,5 @@ void omap_vc_post_scale(struct voltagedomain *voltdm,
 			u8 target_vsel, u8 current_vsel);
 int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 				 unsigned long target_volt);
-
 #endif
 
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index f4449eb..688d55d 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -44,6 +44,9 @@ static struct omap_vc_common omap3_vc_common = {
 	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
 	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
 	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
+	.i2c_cfg_hsen_shift = OMAP3430_HSEN_MASK,
+	.i2c_cfg_reg	 = OMAP3_PRM_VC_I2C_CFG_OFFSET,
+	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index f933f98..8aee1fe 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -45,6 +45,9 @@ static const struct omap_vc_common omap4_vc_common = {
 	.cmd_ret_shift = OMAP4430_RET_SHIFT,
 	.cmd_off_shift = OMAP4430_OFF_SHIFT,
 	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
+	.i2c_cfg_reg = OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
+	.i2c_cfg_hsen_shift = OMAP4430_HSMODEEN_SHIFT,
+	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
 };
 
 /* VC instance data for each controllable voltage line */
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 8b2d951..d2c965e 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -101,6 +101,8 @@ struct omap_volt_data {
  * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
  * @step_size:	PMIC voltage step size (in uv)
+ * @i2c_high_speed: whether VC uses I2C high-speed mode to PMIC
+ * @i2c_mcode: master code value for I2C high-speed preamble transmission
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
  * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
  */
@@ -121,6 +123,8 @@ struct omap_voltdm_pmic {
 	u8 i2c_slave_addr;
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
+	bool i2c_high_speed;
+	u8 i2c_mcode;
 	unsigned long (*vsel_to_uv) (const u8 vsel);
 	u8 (*uv_to_vsel) (unsigned long uV);
 };
-- 
1.7.4

