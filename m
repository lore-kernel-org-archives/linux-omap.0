From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP2+: VC: add SoC-specific op for PMIC register addresses
Date: Thu, 24 Mar 2011 17:09:55 -0700
Message-ID: <1301011795-6754-2-git-send-email-khilman@ti.com>
References: <87lj04xe2t.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51769 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173Ab1CYAJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 20:09:34 -0400
Received: by iwl42 with SMTP id 42so517441iwl.28
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 17:09:32 -0700 (PDT)
In-Reply-To: <87lj04xe2t.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Add a new SoC-specific operation for setting PMIC register addresses
in the VC for the voltage configuration register and command
configuration register.

Some PMICs use a single register for voltage configuration and
on/retention/off commands, others use separate registers.  This patch
adds a VC operation for setting these registers.  The voltage
configuration register is required, and the command register may
optionally be zero, meaning it is not used.  The command register
address is only written to the VC if it is non-zero.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm.h          |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   38 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c      |   43 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc.c           |    9 +------
 arch/arm/mach-omap2/vc.h           |    6 -----
 arch/arm/mach-omap2/vc3xxx_data.c  |    5 ----
 arch/arm/mach-omap2/vc44xx_data.c  |    7 ------
 7 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 4daee4a..49f9e78 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -32,6 +32,7 @@
  */
 struct omap_prm_vc_ops {
 	int (*set_i2c_slave_addr)(u8 vc_id, u8 addr);
+	int (*set_pmic_reg_addrs)(u8 vc_id, u8 volt_addr, u8 cmd_addr);
 };
 
 extern struct omap_prm_vc_ops omap3_prm_vc_ops;
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index b0cc855..4d7fe1a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -162,14 +162,20 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
  */
 struct omap3_prm_vc {
 	u32 smps_sa_mask;
+	u32 smps_vol_ra_mask;
+	u32 smps_cmd_ra_mask;
 };
 
 static struct omap3_prm_vc vc_channels[] = {
 	[OMAP3_PRM_VC_VDD_MPU_ID] = {
 		.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
+		.smps_vol_ra_mask = OMAP3430_VOLRA0_MASK,
+		.smps_cmd_ra_mask = OMAP3430_CMDRA0_MASK,
 	},
 	[OMAP3_PRM_VC_VDD_CORE_ID] = {
 		.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
+		.smps_vol_ra_mask = OMAP3430_VOLRA1_MASK,
+		.smps_cmd_ra_mask = OMAP3430_CMDRA1_MASK,
 	},
 };
 
@@ -190,6 +196,38 @@ int omap3_prm_vc_set_i2c_slave_addr(u8 vc_id, u8 slave_addr)
 	return 0;
 }
 
+/**
+ * omap3_prm_vc_set_pmic_reg_addrs - set PMIC register addresses used by VC
+ * @vc: pointer to VC channel
+ * @volt_addr: voltage configuration register address
+ * @cmd_addr: on/retention/off command configuration register address
+ *
+ * Programs @volt_addr to the voltage register address (VOL_RA)
+ * register for the VDD channnel @vc_id.  If @cmd_addr is
+ * non-zero (for PMICs that use different registers for voltage and
+ * command), write that value to the command configuration register
+ * address (CMD_RA) register.
+ */
+static int omap3_prm_vc_set_pmic_reg_addrs(u8 vc_id, u8 volt_addr, u8 cmd_addr)
+{
+	struct omap3_prm_vc *vc = &vc_channels[vc_id];
+
+	omap2_prm_rmw_mod_reg_bits(vc->smps_vol_ra_mask, 
+				   volt_addr << ffs(vc->smps_vol_ra_mask),
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
+
+	if (cmd_addr)
+		omap2_prm_rmw_mod_reg_bits(vc->smps_cmd_ra_mask, 
+					cmd_addr << ffs(vc->smps_cmd_ra_mask),
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET);
+	
+	return 0;
+}
+
+
 struct omap_prm_vc_ops omap3_prm_vc_ops = {
 	.set_i2c_slave_addr = omap3_prm_vc_set_i2c_slave_addr,
+	.set_pmic_reg_addrs = omap3_prm_vc_set_pmic_reg_addrs,
 };
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 2e4bdf5..2758b75 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -202,17 +202,25 @@ void omap4_prm_global_warm_sw_reset(void)
  */
 struct omap4_prm_vc {
 	u32 smps_sa_mask;
+	u32 smps_vol_ra_mask;
+	u32 smps_cmd_ra_mask;
 };
 
 static struct omap4_prm_vc vc_channels[] = {
 	[OMAP4_PRM_VC_VDD_MPU_ID] = {
 		.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
+		.smps_vol_ra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
+		.smps_cmd_ra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 	},
 	[OMAP4_PRM_VC_VDD_IVA_ID] = {
 		.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
+		.smps_vol_ra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
+		.smps_cmd_ra_mask = OMAP4430_CMDRA_VDD_IVA_L_MASK,
 	},
 	[OMAP4_PRM_VC_VDD_CORE_ID] = {
 		.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
+		.smps_vol_ra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
+		.smps_cmd_ra_mask = OMAP4430_CMDRA_VDD_CORE_L_MASK,
 	},
 };
 
@@ -234,6 +242,41 @@ int omap4_prm_vc_set_i2c_slave_addr(u8 vc_id, u8 slave_addr)
 	return 0;
 }
 
+/**
+ * omap4_prm_vc_set_pmic_reg_addrs - set PMIC register addresses used by VC
+ * @vc: pointer to VC channel
+ * @volt_addr: voltage configuration register address
+ * @cmd_addr: on/retention/off command configuration register address
+ *
+ * Programs @volt_addr to the voltage register address (VOL_RA)
+ * register for the VDD channnel represented by @vc.  If @cmd_addr is
+ * non-zero (for PMICs that use different registers for voltage and
+ * command), write that value to the command configuration register
+ * address (CMD_RA) register.
+ */
+static int omap4_prm_vc_set_pmic_reg_addrs(u8 vc_id,
+					   u8 volt_addr, u8 cmd_addr)
+{
+	struct omap4_prm_vc *vc = &vc_channels[vc_id];
+
+	omap4_prminst_rmw_inst_reg_bits(vc->smps_vol_ra_mask, 
+					volt_addr << ffs(vc->smps_vol_ra_mask),
+					OMAP4430_PRM_PARTITION,
+					OMAP4430_PRM_DEVICE_INST,
+					OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET);
+
+	if (cmd_addr)
+		omap4_prminst_rmw_inst_reg_bits(vc->smps_cmd_ra_mask, 
+					cmd_addr << ffs(vc->smps_cmd_ra_mask),
+					OMAP4430_PRM_PARTITION,
+					OMAP4430_PRM_DEVICE_INST,
+					OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET);
+
+	return 0;
+}
+
+
 struct omap_prm_vc_ops omap4_prm_vc_ops = {
 	.set_i2c_slave_addr = omap4_prm_vc_set_i2c_slave_addr,
+	.set_pmic_reg_addrs = omap4_prm_vc_set_pmic_reg_addrs,
 };
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index dd3b8a0..1ae42609 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -249,13 +249,8 @@ void __init omap_vc_init(struct voltagedomain *voltdm)
 	/* Set up the SMPS i2c slave address in VC */
 	vc->ops->set_i2c_slave_addr(vc->id, vdd->pmic_info->i2c_slave_addr);
 
-	/* Setup the VOLRA(pmic reg addr) in VC */
-	vc_val = vdd->read_reg(vc->common->prm_mod,
-			       vc->common->smps_volra_reg);
-	vc_val &= ~vc->smps_volra_mask;
-	vc_val |= vdd->pmic_info->volt_reg_addr << vc->smps_volra_shift;
-	vdd->write_reg(vc_val, vc->common->prm_mod,
-		       vc->common->smps_volra_reg);
+	vc->ops->set_pmic_reg_addrs(vc->id, vdd->pmic_info->volt_reg_addr,
+				    vdd->pmic_info->cmd_reg_addr);
 
 	/* Configure the setup times */
 	vc_val = vdd->read_reg(vc->common->prm_mod, vdd->vfsm->voltsetup_reg);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 4770117..1c34b39 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -26,7 +26,6 @@ struct voltagedomain;
  * @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
  * @valid: VALID bitmask in PRM_VC_BYPASS_VAL register
  * @prm_mod: PRM module id used for PRM register access
- * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
  * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  * @data_shift: DATA field shift in PRM_VC_BYPASS_VAL register
  * @slaveaddr_shift: SLAVEADDR field shift in PRM_VC_BYPASS_VAL register
@@ -43,7 +42,6 @@ struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
 	s16 prm_mod;
-	u8 smps_volra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
 	u8 slaveaddr_shift;
@@ -57,17 +55,13 @@ struct omap_vc_common {
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
- * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
  *
  * XXX It is not necessary to have both a *_mask and a *_shift -
  *     remove one
  */
 struct omap_vc_channel {
 	const struct omap_vc_common *common;
-	u32 smps_volra_mask;
 	u8 cmdval_reg;
-	u8 smps_volra_shift;
 
 	u8 id;
 	struct omap_prm_vc_ops *ops;
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 6d40453..e0cf693 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -32,7 +32,6 @@
  */
 static struct omap_vc_common omap3_vc_common = {
 	.prm_mod         = OMAP3430_GR_MOD,
-	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT,
@@ -49,8 +48,6 @@ struct omap_vc_channel omap3_vc_mpu = {
 	.id = OMAP3_PRM_VC_VDD_MPU_ID,
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
-	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
-	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
 	.ops = &omap3_prm_vc_ops,
 };
 
@@ -58,7 +55,5 @@ struct omap_vc_channel omap3_vc_core = {
 	.id = OMAP3_PRM_VC_VDD_CORE_ID,
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
-	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
-	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
 	.ops = &omap3_prm_vc_ops,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 5badd08..4dfdcb7 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -32,7 +32,6 @@
  */
 static const struct omap_vc_common omap4_vc_common = {
 	.prm_mod = OMAP4430_PRM_DEVICE_INST,
-	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
 	.data_shift = OMAP4430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP4430_SLAVEADDR_SHIFT,
@@ -50,8 +49,6 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.id = OMAP4_PRM_VC_VDD_MPU_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
-	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
 	.ops = &omap4_prm_vc_ops,
 };
 
@@ -59,8 +56,6 @@ struct omap_vc_channel omap4_vc_iva = {
 	.id = OMAP4_PRM_VC_VDD_IVA_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
-	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
 	.ops = &omap4_prm_vc_ops,
 };
 
@@ -68,8 +63,6 @@ struct omap_vc_channel omap4_vc_core = {
 	.id = OMAP4_PRM_VC_VDD_CORE_ID,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
-	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
 	.ops = &omap4_prm_vc_ops,
 };
 
-- 
1.7.4

