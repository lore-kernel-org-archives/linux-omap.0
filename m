From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 06/13] OMAP3+: VC: cleanup PMIC register address configuration
Date: Fri,  1 Apr 2011 16:41:04 -0700
Message-ID: <1301701271-22096-7-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33322 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753517Ab1DAXkp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:45 -0400
Received: by mail-iw0-f177.google.com with SMTP id 36so6210283iwn.22
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:44 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- support both voltage register address and command register address
  for each VC channel
- add fields for voltage register address (volra) and command register
  address (cmdra) to struct omap_vc_channel
- use VC/VP register access read/modify/write helper
- remove volra_shift field (use __ffs(mask) for shift value)

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   17 ++++++++++++-----
 arch/arm/mach-omap2/vc.h          |    9 ++++-----
 arch/arm/mach-omap2/vc3xxx_data.c |    5 +++--
 arch/arm/mach-omap2/vc44xx_data.c |    7 ++++---
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 0824904..7829861 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -234,17 +234,24 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 
 	/* get PMIC/board specific settings */
 	vc->i2c_slave_addr = vdd->pmic_info->i2c_slave_addr;
+	vc->volt_reg_addr = vdd->pmic_info->volt_reg_addr;
+	vc->cmd_reg_addr = vdd->pmic_info->cmd_reg_addr;
 
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
 		    vc->common->smps_sa_reg);
 
-	/* Setup the VOLRA(pmic reg addr) in VC */
-	vc_val = voltdm->read(vc->common->smps_volra_reg);
-	vc_val &= ~vc->smps_volra_mask;
-	vc_val |= vdd->pmic_info->volt_reg_addr << vc->smps_volra_shift;
-	voltdm->write(vc_val, vc->common->smps_volra_reg);
+	/*
+	 * Configure the PMIC register addresses.
+	 */
+	voltdm->rmw(vc->smps_volra_mask,
+		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
+		    vc->common->smps_volra_reg);
+	if (vc->cmd_reg_addr)
+		voltdm->rmw(vc->smps_cmdra_mask,
+			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
+			    vc->common->smps_cmdra_reg);
 
 	/* Configure the setup times */
 	vc_val = voltdm->read(vdd->vfsm->voltsetup_reg);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index ca8479e..72c4ee2 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -44,6 +44,7 @@ struct omap_vc_common {
 	u32 valid;
 	u8 smps_sa_reg;
 	u8 smps_volra_reg;
+	u8 smps_cmdra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
 	u8 slaveaddr_shift;
@@ -59,21 +60,19 @@ struct omap_vc_common {
  * @common: pointer to VC common data for this platform
  * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
- *
- * XXX It is not necessary to have both a *_mask and a *_shift -
- *     remove one
  */
 struct omap_vc_channel {
 	/* channel state */
 	u8 i2c_slave_addr;
+	u8 volt_reg_addr;
+	u8 cmd_reg_addr;
 
 	/* register access data */
 	const struct omap_vc_common *common;
 	u32 smps_sa_mask;
 	u32 smps_volra_mask;
+	u32 smps_cmdra_mask;
 	u8 cmdval_reg;
-	u8 smps_volra_shift;
 };
 
 extern struct omap_vc_channel omap3_vc_mpu;
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 86be50c..df8bd5e 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -32,6 +32,7 @@
 static struct omap_vc_common omap3_vc_common = {
 	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
+	.smps_cmdra_reg	 = OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT,
@@ -48,14 +49,14 @@ struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
-	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
+	.smps_cmdra_mask = OMAP3430_CMDRA0_MASK,
 };
 
 struct omap_vc_channel omap3_vc_core = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
-	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
+	.smps_cmdra_mask = OMAP3430_CMDRA1_MASK,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index af922b4..5d104ff 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -33,6 +33,7 @@
 static const struct omap_vc_common omap4_vc_common = {
 	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
+	.smps_cmdra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET,
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
 	.data_shift = OMAP4430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP4430_SLAVEADDR_SHIFT,
@@ -50,23 +51,23 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
+	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
+	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_IVA_L_MASK,
 };
 
 struct omap_vc_channel omap4_vc_core = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
-	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
+	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_CORE_L_MASK,
 };
 
-- 
1.7.4

