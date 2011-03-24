From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 19/19] OMAP2+: VC: add SoC-specific op for PMIC register addresses
Date: Wed, 23 Mar 2011 17:00:33 -0700
Message-ID: <1300924833-26745-20-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36353 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933394Ab1CXAAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:52 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so12212422iwn.39
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:51 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
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
 arch/arm/mach-omap2/vc.c          |    8 ++------
 arch/arm/mach-omap2/vc.h          |   11 ++++-------
 arch/arm/mach-omap2/vc3xxx.c      |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc3xxx_data.c |    5 ++---
 arch/arm/mach-omap2/vc44xx.c      |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc44xx_data.c |    7 +++----
 6 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index c561cfc..94f2008 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -247,12 +247,8 @@ void __init omap_vc_init(struct voltagedomain *voltdm)
 	vc->ops->set_i2c_slave_addr(vc, vdd->pmic_info->i2c_slave_addr);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
-	vc_val = vdd->read_reg(vc->common->prm_mod,
-			       vc->common->smps_volra_reg);
-	vc_val &= ~vc->smps_volra_mask;
-	vc_val |= vdd->pmic_info->volt_reg_addr << vc->smps_volra_shift;
-	vdd->write_reg(vc_val, vc->common->prm_mod,
-		       vc->common->smps_volra_reg);
+	vc->ops->set_pmic_reg_addrs(vc, vdd->pmic_info->volt_reg_addr,
+				    vdd->pmic_info->cmd_reg_addr);
 
 	/* Configure the setup times */
 	vc_val = vdd->read_reg(vc->common->prm_mod, vdd->vfsm->voltsetup_reg);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index a29e117..7e74683 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -28,6 +28,8 @@ struct omap_vc_channel;
  */
 struct omap_vc_ops {
 	int (*set_i2c_slave_addr)(struct omap_vc_channel *vc, u8 addr);
+	int (*set_pmic_reg_addrs)(struct omap_vc_channel *vc,
+				  u8 volt_addr, u8 cmd_addr);
 };
 
 /**
@@ -35,7 +37,6 @@ struct omap_vc_ops {
  * @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
  * @valid: VALID bitmask in PRM_VC_BYPASS_VAL register
  * @prm_mod: PRM module id used for PRM register access
- * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
  * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  * @data_shift: DATA field shift in PRM_VC_BYPASS_VAL register
  * @slaveaddr_shift: SLAVEADDR field shift in PRM_VC_BYPASS_VAL register
@@ -52,7 +53,6 @@ struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
 	s16 prm_mod;
-	u8 smps_volra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
 	u8 slaveaddr_shift;
@@ -67,19 +67,16 @@ struct omap_vc_common {
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
  * @smps_sa_mask: slave address field mask in the PRM_VC_SMPS_SA register
- * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
+ * @smps_volra_mask: VOLRA bitmask in the PRM_VC_VOL_RA register
  * @ops: SoC-specific implementations of VC operations
  *
- * XXX It is not necessary to have both a *_mask and a *_shift -
- *     remove one
  */
 struct omap_vc_channel {
 	const struct omap_vc_common *common;
 	u32 smps_sa_mask;
 	u32 smps_volra_mask;
+	u32 cmdra_mask;
 	u8 cmdval_reg;
-	u8 smps_volra_shift;
 
 	struct omap_vc_ops *ops;
 };
diff --git a/arch/arm/mach-omap2/vc3xxx.c b/arch/arm/mach-omap2/vc3xxx.c
index 020d148..c30c841 100644
--- a/arch/arm/mach-omap2/vc3xxx.c
+++ b/arch/arm/mach-omap2/vc3xxx.c
@@ -40,6 +40,34 @@ static int omap3_vc_set_i2c_slave_addr(struct omap_vc_channel *vc,
 	return 0;
 }
 
+/**
+ * omap3_vc_set_pmic_reg_addrs - set PMIC register addresses used by VC
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
+static int omap3_vc_set_pmic_reg_addrs(struct omap_vc_channel *vc,
+				       u8 volt_addr, u8 cmd_addr)
+{
+	omap3_vc_rmw(vc->smps_volra_mask, 
+		     volt_addr << ffs(vc->smps_volra_mask),
+		     OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
+
+	if (cmd_addr)
+		omap3_vc_rmw(vc->cmdra_mask, 
+			     cmd_addr << ffs(vc->cmdra_mask),
+			     OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET);
+
+	return 0;
+}
+
 struct omap_vc_ops omap3_vc_ops = {
 	.set_i2c_slave_addr = omap3_vc_set_i2c_slave_addr,
+	.set_pmic_reg_addrs = omap3_vc_set_pmic_reg_addrs,
 };
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 51aa2b6..de6c7bb 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -31,7 +31,6 @@
  */
 static struct omap_vc_common omap3_vc_common = {
 	.prm_mod         = OMAP3430_GR_MOD,
-	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT,
@@ -48,8 +47,8 @@ struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
-	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
+	.cmdra_mask = OMAP3430_CMDRA0_MASK,
 	.ops = &omap3_vc_ops,
 };
 
@@ -57,7 +56,7 @@ struct omap_vc_channel omap3_vc_core = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
-	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
+	.cmdra_mask = OMAP3430_CMDRA1_MASK,
 	.ops = &omap3_vc_ops,
 };
diff --git a/arch/arm/mach-omap2/vc44xx.c b/arch/arm/mach-omap2/vc44xx.c
index f53a6c7..e4a8c8a 100644
--- a/arch/arm/mach-omap2/vc44xx.c
+++ b/arch/arm/mach-omap2/vc44xx.c
@@ -40,6 +40,34 @@ static int omap4_vc_set_i2c_slave_addr(struct omap_vc_channel *vc,
 	return 0;
 }
 
+/**
+ * omap4_vc_set_pmic_reg_addrs - set PMIC register addresses used by VC
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
+static int omap4_vc_set_pmic_reg_addrs(struct omap_vc_channel *vc,
+				       u8 volt_addr, u8 cmd_addr)
+{
+	omap4_vc_rmw(vc->smps_volra_mask, 
+		     volt_addr << ffs(vc->smps_volra_mask),
+		     OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET);
+
+	if (cmd_addr)
+		omap4_vc_rmw(vc->cmdra_mask, 
+			     cmd_addr << ffs(vc->cmdra_mask),
+			     OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET);
+
+	return 0;
+}
+
 struct omap_vc_ops omap4_vc_ops = {
 	.set_i2c_slave_addr = omap4_vc_set_i2c_slave_addr,
+	.set_pmic_reg_addrs = omap4_vc_set_pmic_reg_addrs,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 9dbf307..e15d170 100644
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
@@ -50,8 +49,8 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
+	.cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 	.ops = &omap4_vc_ops,
 };
 
@@ -59,8 +58,8 @@ struct omap_vc_channel omap4_vc_iva = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
+	.cmdra_mask = OMAP4430_CMDRA_VDD_IVA_L_MASK,
 	.ops = &omap4_vc_ops,
 };
 
@@ -68,7 +67,7 @@ struct omap_vc_channel omap4_vc_core = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
+	.cmdra_mask = OMAP4430_CMDRA_VDD_CORE_L_MASK,
 	.ops = &omap4_vc_ops,
 };
-- 
1.7.4

