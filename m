From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 05/13] OMAP3+: VC: cleanup i2c slave address configuration
Date: Fri,  1 Apr 2011 16:41:03 -0700
Message-ID: <1301701271-22096-6-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42724 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1DAXkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:42 -0400
Received: by mail-iw0-f182.google.com with SMTP id 33so5373948iwn.41
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:42 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- Add an i2c_slave_address field to the omap_vc_channel
- use VC/VP read/modify/write helper instead of open-coding
- remove smps_sa_shift, use __ffs(mask) for shift value

Special thanks to Shweta Gulati <shweta.gulati@ti.com> for suggesting
the use of __ffs(x) instead of ffs(x) - 1.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   12 +++++++-----
 arch/arm/mach-omap2/vc.h          |    8 +++++---
 arch/arm/mach-omap2/vc3xxx_data.c |    2 --
 arch/arm/mach-omap2/vc44xx_data.c |    3 ---
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 349b5b1..0824904 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -232,11 +232,13 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		return;
 	}
 
-	/* Set up the SMPS_SA(i2c slave address in VC */
-	vc_val = voltdm->read(vc->common->smps_sa_reg);
-	vc_val &= ~vc->smps_sa_mask;
-	vc_val |= vdd->pmic_info->i2c_slave_addr << vc->smps_sa_shift;
-	voltdm->write(vc_val, vc->common->smps_sa_reg);
+	/* get PMIC/board specific settings */
+	vc->i2c_slave_addr = vdd->pmic_info->i2c_slave_addr;
+
+	/* Configure the i2c slave address for this VC */
+	voltdm->rmw(vc->smps_sa_mask,
+		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
+		    vc->common->smps_sa_reg);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
 	vc_val = voltdm->read(vc->common->smps_volra_reg);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 553a5ac..ca8479e 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -57,20 +57,22 @@ struct omap_vc_common {
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
- * @smps_sa_mask: SA* bitmask in the PRM_VC_SMPS_SA register
+ * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
- * @smps_sa_shift: SA* field shift in the PRM_VC_SMPS_SA register
  * @smps_volra_shift: VOLRA* field shift in the PRM_VC_VOL_RA register
  *
  * XXX It is not necessary to have both a *_mask and a *_shift -
  *     remove one
  */
 struct omap_vc_channel {
+	/* channel state */
+	u8 i2c_slave_addr;
+
+	/* register access data */
 	const struct omap_vc_common *common;
 	u32 smps_sa_mask;
 	u32 smps_volra_mask;
 	u8 cmdval_reg;
-	u8 smps_sa_shift;
 	u8 smps_volra_shift;
 };
 
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 6b67203..86be50c 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -47,7 +47,6 @@ static struct omap_vc_common omap3_vc_common = {
 struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA0_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
@@ -56,7 +55,6 @@ struct omap_vc_channel omap3_vc_mpu = {
 struct omap_vc_channel omap3_vc_core = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
-	.smps_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
 	.smps_volra_shift = OMAP3430_VOLRA1_SHIFT,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index e3125a3..af922b4 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -49,7 +49,6 @@ static const struct omap_vc_common omap4_vc_common = {
 struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_MPU_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
@@ -58,7 +57,6 @@ struct omap_vc_channel omap4_vc_mpu = {
 struct omap_vc_channel omap4_vc_iva = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_IVA_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
@@ -67,7 +65,6 @@ struct omap_vc_channel omap4_vc_iva = {
 struct omap_vc_channel omap4_vc_core = {
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
-	.smps_sa_shift = OMAP4430_SA_VDD_CORE_L_0_6_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
 	.smps_volra_shift = OMAP4430_VOLRA_VDD_CORE_L_SHIFT,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
-- 
1.7.4

