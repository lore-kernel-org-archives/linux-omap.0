From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 10/13] OMAP3+: VC: abstract out channel configuration
Date: Fri,  1 Apr 2011 16:41:08 -0700
Message-ID: <1301701271-22096-11-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49801 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753698Ab1DAXkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:53 -0400
Received: by mail-iw0-f177.google.com with SMTP id 36so4912629iwn.8
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:52 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

VC channel configuration is programmed based on settings coming from
the PMIC configuration.

Currently, the VC channel to PMIC mapping is a simple one-to-one
mapping.  Whenever a VC channel parameter is configured (i2c slave
addres, PMIC register address, on/ret/off command), the corresponding
bits are enabled in the VC channel configuration register.

If necessary, the programmability of channel configuration settings
could be extended to board/PMIC files, however, because this patch
changes the channel configuration to be programmed based on existing
values from the PMIC settings, it may not be required.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   71 ++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/vc.h          |    3 ++
 arch/arm/mach-omap2/vc3xxx_data.c |    3 ++
 arch/arm/mach-omap2/vc44xx_data.c |    4 ++
 4 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 4114909..1ce7b24 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,6 +10,53 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 
+/*
+ * Channel configuration bits, common for OMAP3 & 4
+ * OMAP3 register: PRM_VC_CH_CONF
+ * OMAP4 register: PRM_VC_CFG_CHANNEL
+ */
+#define CFG_CHANNEL_SA    BIT(0)
+#define CFG_CHANNEL_RAV   BIT(1)
+#define CFG_CHANNEL_RAC   BIT(2)
+#define CFG_CHANNEL_RACEN BIT(3)
+#define CFG_CHANNEL_CMD   BIT(4)
+#define CFG_CHANNEL_MASK 0x3f
+
+/**
+ * omap_vc_config_channel - configure VC channel to PMIC mappings
+ * @voltdm: pointer to voltagdomain defining the desired VC channel
+ *
+ * Configures the VC channel to PMIC mappings for the following
+ * PMIC settings
+ * - i2c slave address (SA)
+ * - voltage configuration address (RAV)
+ * - command configuration address (RAC) and enable bit (RACEN)
+ * - command values for ON, ONLP, RET and OFF (CMD)
+ *
+ * This function currently only allows flexible configuration of
+ * the non-default channel (e.g. non-zero channels.)  Starting with
+ * OMAP4, only the non-zero channels can be configured.  Channel zero
+ * always uses the channel zero register values.  Therefore, the
+ * same limitation is imposed on OMAP3 for consistency.
+ */
+static int omap_vc_config_channel(struct voltagedomain *voltdm)
+{
+	struct omap_vc_channel *vc = voltdm->vc;
+
+	/*
+	 * For channel zero, the only configurable bit is RACEN.
+	 * All others must stay at zero (see function comment above.)
+	 */
+	if (!vc->cfg_channel_sa_shift)
+		vc->cfg_channel &= CFG_CHANNEL_RACEN;
+
+	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
+		    vc->cfg_channel << vc->cfg_channel_sa_shift,
+		    vc->common->cfg_channel_reg);
+
+	return 0;
+}
+
 /* Voltage scale and accessory APIs */
 int omap_vc_pre_scale(struct voltagedomain *voltdm,
 		      unsigned long target_volt,
@@ -157,8 +204,6 @@ static void __init omap3_vc_init_channel(struct voltagedomain *voltdm)
 	 * Generic VC parameters init
 	 * XXX This data should be abstracted out
 	 */
-	voltdm->write(OMAP3430_CMD1_MASK | OMAP3430_RAV1_MASK,
-		       OMAP3_PRM_VC_CH_CONF_OFFSET);
 	voltdm->write(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK,
 		       OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
@@ -177,15 +222,6 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
 	if (is_initialized)
 		return;
 
-	/*
-	 * Generic VC parameters init
-	 * XXX This data should be abstracted out
-	 */
-	vc_val = (OMAP4430_RAV_VDD_MPU_L_MASK | OMAP4430_CMD_VDD_MPU_L_MASK |
-		  OMAP4430_RAV_VDD_IVA_L_MASK | OMAP4430_CMD_VDD_IVA_L_MASK |
-		  OMAP4430_RAV_VDD_CORE_L_MASK | OMAP4430_CMD_VDD_CORE_L_MASK);
-	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_CHANNEL_OFFSET);
-
 	/* XXX These are magic numbers and do not belong! */
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
 	voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
@@ -213,6 +249,8 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		return;
 	}
 
+	vc->cfg_channel = 0;
+
 	/* get PMIC/board specific settings */
 	vc->i2c_slave_addr = vdd->pmic_info->i2c_slave_addr;
 	vc->volt_reg_addr = vdd->pmic_info->volt_reg_addr;
@@ -223,6 +261,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
 		    vc->common->smps_sa_reg);
+	vc->cfg_channel |= CFG_CHANNEL_SA;
 
 	/*
 	 * Configure the PMIC register addresses.
@@ -230,10 +269,14 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_volra_mask,
 		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
 		    vc->common->smps_volra_reg);
-	if (vc->cmd_reg_addr)
+	vc->cfg_channel |= CFG_CHANNEL_RAV;
+
+	if (vc->cmd_reg_addr) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
+		vc->cfg_channel |= CFG_CHANNEL_RAC | CFG_CHANNEL_RACEN;
+	}
 
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->on_volt);
@@ -245,6 +288,10 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	       (ret_vsel << vc->common->cmd_ret_shift) |
 	       (off_vsel << vc->common->cmd_off_shift));
 	voltdm->write(val, vc->cmdval_reg);
+	vc->cfg_channel |= CFG_CHANNEL_CMD;
+
+	/* Channel configuration */
+	omap_vc_config_channel(voltdm);
 
 	/* Configure the setup times */
 	voltdm->rmw(voltdm->vfsm->voltsetup_mask,
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index ade35f7..e0d2931 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -53,6 +53,7 @@ struct omap_vc_common {
 	u8 cmd_onlp_shift;
 	u8 cmd_ret_shift;
 	u8 cmd_off_shift;
+	u8 cfg_channel_reg;
 };
 
 /**
@@ -66,6 +67,7 @@ struct omap_vc_channel {
 	u8 i2c_slave_addr;
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
+	u8 cfg_channel;
 	u16 setup_time;
 
 	/* register access data */
@@ -74,6 +76,7 @@ struct omap_vc_channel {
 	u32 smps_volra_mask;
 	u32 smps_cmdra_mask;
 	u8 cmdval_reg;
+	u8 cfg_channel_sa_shift;
 };
 
 extern struct omap_vc_channel omap3_vc_mpu;
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index df8bd5e..f4449eb 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -43,6 +43,7 @@ static struct omap_vc_common omap3_vc_common = {
 	.cmd_onlp_shift	 = OMAP3430_VC_CMD_ONLP_SHIFT,
 	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
 	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
+	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
@@ -51,6 +52,7 @@ struct omap_vc_channel omap3_vc_mpu = {
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
 	.smps_cmdra_mask = OMAP3430_CMDRA0_MASK,
+	.cfg_channel_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT,
 };
 
 struct omap_vc_channel omap3_vc_core = {
@@ -59,4 +61,5 @@ struct omap_vc_channel omap3_vc_core = {
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
 	.smps_cmdra_mask = OMAP3430_CMDRA1_MASK,
+	.cfg_channel_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 5d104ff..f933f98 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -44,6 +44,7 @@ static const struct omap_vc_common omap4_vc_common = {
 	.cmd_onlp_shift = OMAP4430_ONLP_SHIFT,
 	.cmd_ret_shift = OMAP4430_RET_SHIFT,
 	.cmd_off_shift = OMAP4430_OFF_SHIFT,
+	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
 };
 
 /* VC instance data for each controllable voltage line */
@@ -53,6 +54,7 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
+	.cfg_channel_sa_shift = OMAP4430_SA_VDD_MPU_L_SHIFT,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
@@ -61,6 +63,7 @@ struct omap_vc_channel omap4_vc_iva = {
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_IVA_L_MASK,
+	.cfg_channel_sa_shift = OMAP4430_SA_VDD_IVA_L_SHIFT,
 };
 
 struct omap_vc_channel omap4_vc_core = {
@@ -69,5 +72,6 @@ struct omap_vc_channel omap4_vc_core = {
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_CORE_L_MASK,
+	.cfg_channel_sa_shift = OMAP4430_SA_VDD_CORE_L_SHIFT,
 };
 
-- 
1.7.4

