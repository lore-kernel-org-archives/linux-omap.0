From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 6/7] OMAP2+: VC: more registers are per-channel starting with OMAP5
Date: Mon, 29 Aug 2011 11:10:48 -0700
Message-ID: <1314641449-5089-7-git-send-email-khilman@ti.com>
References: <1314641449-5089-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55054 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754286Ab1H2SKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:10:32 -0400
Received: by mail-pz0-f41.google.com with SMTP id 4so13144552pzk.28
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:10:31 -0700 (PDT)
In-Reply-To: <1314641449-5089-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Starting with OMAP5, the following registers are per-channel and not
common to a all VC channels:

 - SMPS I2C slave address
 - SMPS voltage register address offset
 - SMPS cmd/value register address offset
 - VC channel configuration register

Move these from the channel-common struct into the per-channel struct
to support OMAP5.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c          |    8 ++++----
 arch/arm/mach-omap2/vc.h          |   14 +++++++-------
 arch/arm/mach-omap2/vc3xxx_data.c |   12 ++++++++----
 arch/arm/mach-omap2/vc44xx_data.c |   16 ++++++++++++----
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 1c2bb9c..b87bdb8 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -85,7 +85,7 @@ static int omap_vc_config_channel(struct voltagedomain *voltdm)
 
 	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
 		    vc->cfg_channel << vc->cfg_channel_sa_shift,
-		    vc->common->cfg_channel_reg);
+		    vc->cfg_channel_reg);
 
 	return 0;
 }
@@ -310,7 +310,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	/* Configure the i2c slave address for this VC */
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
-		    vc->common->smps_sa_reg);
+		    vc->smps_sa_reg);
 	vc->cfg_channel |= vc_cfg_bits->sa;
 
 	/*
@@ -318,13 +318,13 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	 */
 	voltdm->rmw(vc->smps_volra_mask,
 		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
-		    vc->common->smps_volra_reg);
+		    vc->smps_volra_reg);
 	vc->cfg_channel |= vc_cfg_bits->rav;
 
 	if (vc->cmd_reg_addr) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
-			    vc->common->smps_cmdra_reg);
+			    vc->smps_cmdra_reg);
 		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
 	}
 
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index ec50643..ffa5084 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -25,9 +25,6 @@ struct voltagedomain;
  * struct omap_vc_common - per-VC register/bitfield data
  * @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
  * @valid: VALID bitmask in PRM_VC_BYPASS_VAL register
- * @smps_sa_reg: Offset of PRM_VC_SMPS_SA reg from PRM start
- * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
- * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  * @data_shift: DATA field shift in PRM_VC_BYPASS_VAL register
  * @slaveaddr_shift: SLAVEADDR field shift in PRM_VC_BYPASS_VAL register
  * @regaddr_shift: REGADDR field shift in PRM_VC_BYPASS_VAL register
@@ -45,9 +42,6 @@ struct voltagedomain;
 struct omap_vc_common {
 	u32 cmd_on_mask;
 	u32 valid;
-	u8 smps_sa_reg;
-	u8 smps_volra_reg;
-	u8 smps_cmdra_reg;
 	u8 bypass_val_reg;
 	u8 data_shift;
 	u8 slaveaddr_shift;
@@ -56,7 +50,6 @@ struct omap_vc_common {
 	u8 cmd_onlp_shift;
 	u8 cmd_ret_shift;
 	u8 cmd_off_shift;
-	u8 cfg_channel_reg;
 	u8 i2c_cfg_reg;
 	u8 i2c_cfg_hsen_mask;
 	u8 i2c_mcode_mask;
@@ -72,6 +65,9 @@ struct omap_vc_common {
  * @common: pointer to VC common data for this platform
  * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
+ * @smps_sa_reg: Offset of PRM_VC_SMPS_SA reg from PRM start
+ * @smps_volra_reg: Offset of PRM_VC_SMPS_VOL_RA reg from PRM start
+ * @bypass_val_reg: Offset of PRM_VC_BYPASS_VAL reg from PRM start
  */
 struct omap_vc_channel {
 	u8 flags;
@@ -90,6 +86,10 @@ struct omap_vc_channel {
 	u32 smps_volra_mask;
 	u32 smps_cmdra_mask;
 	u8 cmdval_reg;
+	u8 smps_sa_reg;
+	u8 smps_volra_reg;
+	u8 smps_cmdra_reg;
+	u8 cfg_channel_reg;
 	u8 cfg_channel_sa_shift;
 };
 
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 95d7701..cfe348e 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -30,9 +30,6 @@
  * XXX This stuff presumably belongs in the vc3xxx.c or vc.c file.
  */
 static struct omap_vc_common omap3_vc_common = {
-	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
-	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
-	.smps_cmdra_reg	 = OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET,
 	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
 	.data_shift	 = OMAP3430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT,
@@ -43,7 +40,6 @@ static struct omap_vc_common omap3_vc_common = {
 	.cmd_onlp_shift	 = OMAP3430_VC_CMD_ONLP_SHIFT,
 	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
 	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
-	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
 	.i2c_cfg_hsen_mask = OMAP3430_HSEN_MASK,
 	.i2c_cfg_reg	 = OMAP3_PRM_VC_I2C_CFG_OFFSET,
 	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
@@ -51,6 +47,10 @@ static struct omap_vc_common omap3_vc_common = {
 
 struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
+	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
+	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
+	.smps_cmdra_reg	 = OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET,
+	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA0_MASK,
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
@@ -60,6 +60,10 @@ struct omap_vc_channel omap3_vc_mpu = {
 
 struct omap_vc_channel omap3_vc_core = {
 	.common = &omap3_vc_common,
+	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
+	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
+	.smps_cmdra_reg	 = OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET,
+	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
 	.smps_sa_mask = OMAP3430_PRM_VC_SMPS_SA_SA1_MASK,
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 0a4fc37..2740a96 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -31,9 +31,6 @@
  * XXX This stuff presumably belongs in the vc3xxx.c or vc.c file.
  */
 static const struct omap_vc_common omap4_vc_common = {
-	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
-	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
-	.smps_cmdra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET,
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
 	.data_shift = OMAP4430_DATA_SHIFT,
 	.slaveaddr_shift = OMAP4430_SLAVEADDR_SHIFT,
@@ -44,7 +41,6 @@ static const struct omap_vc_common omap4_vc_common = {
 	.cmd_onlp_shift = OMAP4430_ONLP_SHIFT,
 	.cmd_ret_shift = OMAP4430_RET_SHIFT,
 	.cmd_off_shift = OMAP4430_OFF_SHIFT,
-	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
 	.i2c_cfg_reg = OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
 	.i2c_cfg_hsen_mask = OMAP4430_HSMODEEN_MASK,
 	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
@@ -54,6 +50,10 @@ static const struct omap_vc_common omap4_vc_common = {
 struct omap_vc_channel omap4_vc_mpu = {
 	.flags = OMAP_VC_CHANNEL_DEFAULT | OMAP_VC_CHANNEL_CFG_MUTANT,
 	.common = &omap4_vc_common,
+	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
+	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
+	.smps_cmdra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET,
+	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
@@ -63,6 +63,10 @@ struct omap_vc_channel omap4_vc_mpu = {
 
 struct omap_vc_channel omap4_vc_iva = {
 	.common = &omap4_vc_common,
+	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
+	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
+	.smps_cmdra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET,
+	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
@@ -72,6 +76,10 @@ struct omap_vc_channel omap4_vc_iva = {
 
 struct omap_vc_channel omap4_vc_core = {
 	.common = &omap4_vc_common,
+	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
+	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
+	.smps_cmdra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_CMD_OFFSET,
+	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
-- 
1.7.6

