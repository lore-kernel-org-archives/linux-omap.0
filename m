From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH v2 1/3] OMAP4: PM: VC: fix channel bit offset for MPU
Date: Sun, 29 May 2011 16:19:38 -0700
Message-ID: <1306711180-8631-2-git-send-email-nm@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37879 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111Ab1E2XTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 19:19:47 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so1547608gyh.36
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 16:19:46 -0700 (PDT)
In-Reply-To: <1306711180-8631-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Patch "OMAP3+: VC: abstract out channel configuration" abstracts out
VC channel configuration. However, TRM has it's little surprises such
as the following for channel_cfg:
CFG_CHANNEL_SA    BIT(0)
CFG_CHANNEL_RAV   BIT(1)
CFG_CHANNEL_RAC   BIT(2)
CFG_CHANNEL_RACEN BIT(3)
CFG_CHANNEL_CMD   BIT(4)
is valid for core and iva, *but* for mpu, the channel offsets are as follows:
CFG_CHANNEL_SA    BIT(0)
CFG_CHANNEL_CMD   BIT(1)
CFG_CHANNEL_RAV   BIT(2)
CFG_CHANNEL_RAC   BIT(3)
CFG_CHANNEL_RACEN BIT(4)

To handle this on the fly, add a structure to describe this and use the
structure for vc definition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   30 ++++++++++++++----------------
 arch/arm/mach-omap2/vc.h          |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc3xxx_data.c |   11 +++++++++++
 arch/arm/mach-omap2/vc44xx_data.c |   21 +++++++++++++++++++++
 4 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index fba352d..6437460 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,18 +10,6 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 
-/*
- * Channel configuration bits, common for OMAP3 & 4
- * OMAP3 register: PRM_VC_CH_CONF
- * OMAP4 register: PRM_VC_CFG_CHANNEL
- */
-#define CFG_CHANNEL_SA    BIT(0)
-#define CFG_CHANNEL_RAV   BIT(1)
-#define CFG_CHANNEL_RAC   BIT(2)
-#define CFG_CHANNEL_RACEN BIT(3)
-#define CFG_CHANNEL_CMD   BIT(4)
-#define CFG_CHANNEL_MASK 0x3f
-
 /**
  * omap_vc_config_channel - configure VC channel to PMIC mappings
  * @voltdm: pointer to voltagdomain defining the desired VC channel
@@ -249,6 +237,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 	u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
+	struct omap_vc_channel_cfg *cfg_channel_data;
 	u32 val;
 
 	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
@@ -264,6 +253,14 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		return;
 	}
 
+	/* Ensure we have VC channel data */
+	if (!vc->cfg_ch_bits) {
+		pr_err("%s: No CFG Channel data for vdd_%s regs\n",
+			__func__, voltdm->name);
+		return;
+	}
+	cfg_channel_data = vc->cfg_ch_bits;
+
 	vc->cfg_channel = 0;
 
 	/* get PMIC/board specific settings */
@@ -276,7 +273,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
 		    vc->common->smps_sa_reg);
-	vc->cfg_channel |= CFG_CHANNEL_SA;
+	vc->cfg_channel |= cfg_channel_data->sa;
 
 	/*
 	 * Configure the PMIC register addresses.
@@ -284,13 +281,14 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_volra_mask,
 		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
 		    vc->common->smps_volra_reg);
-	vc->cfg_channel |= CFG_CHANNEL_RAV;
+	vc->cfg_channel |= cfg_channel_data->rav;
 
 	if (vc->cmd_reg_addr) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
-		vc->cfg_channel |= CFG_CHANNEL_RAC | CFG_CHANNEL_RACEN;
+		vc->cfg_channel |= cfg_channel_data->rac |
+					cfg_channel_data->racen;
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
@@ -303,7 +301,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	       (ret_vsel << vc->common->cmd_ret_shift) |
 	       (off_vsel << vc->common->cmd_off_shift));
 	voltdm->write(val, vc->cmdval_reg);
-	vc->cfg_channel |= CFG_CHANNEL_CMD;
+	vc->cfg_channel |= cfg_channel_data->cmd;
 
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index f0fb61f..2538089 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -62,11 +62,39 @@ struct omap_vc_common {
 	u8 i2c_mcode_mask;
 };
 
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
+/**
+ * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
+ * @sa:	SA_VDD_xxx_L
+ * @rav:	RAV_VDD_xxx_L
+ * @rac:	RAC_VDD_xxx_L
+ * @racen:	RACEN_VDD_xxx_L
+ * @cmd:	CMD_VDD_xxx_L
+ */
+struct omap_vc_channel_cfg {
+	u8 sa;
+	u8 rav;
+	u8 rac;
+	u8 racen;
+	u8 cmd;
+};
+
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
  * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
+ * @cfg_ch_bits: exception handling for unordered register bits in cfg_channel
  */
 struct omap_vc_channel {
 	/* channel state */
@@ -74,6 +102,7 @@ struct omap_vc_channel {
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
 	u8 cfg_channel;
+	struct omap_vc_channel_cfg *cfg_ch_bits;
 	u16 setup_time;
 	bool i2c_high_speed;
 
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 95d7701..0a22b1d 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -49,6 +49,15 @@ static struct omap_vc_common omap3_vc_common = {
 	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
 };
 
+/* for all channels */
+struct omap_vc_channel_cfg vc3xxx_common_cfg_channel = {
+	.sa = CFG_CHANNEL_SA,
+	.rav = CFG_CHANNEL_RAV,
+	.rac = CFG_CHANNEL_RAC,
+	.racen = CFG_CHANNEL_RACEN,
+	.cmd = CFG_CHANNEL_CMD,
+};
+
 struct omap_vc_channel omap3_vc_mpu = {
 	.common = &omap3_vc_common,
 	.cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
@@ -56,6 +65,7 @@ struct omap_vc_channel omap3_vc_mpu = {
 	.smps_volra_mask = OMAP3430_VOLRA0_MASK,
 	.smps_cmdra_mask = OMAP3430_CMDRA0_MASK,
 	.cfg_channel_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT,
+	.cfg_ch_bits = &vc3xxx_common_cfg_channel,
 };
 
 struct omap_vc_channel omap3_vc_core = {
@@ -65,4 +75,5 @@ struct omap_vc_channel omap3_vc_core = {
 	.smps_volra_mask = OMAP3430_VOLRA1_MASK,
 	.smps_cmdra_mask = OMAP3430_CMDRA1_MASK,
 	.cfg_channel_sa_shift = OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT,
+	.cfg_ch_bits = &vc3xxx_common_cfg_channel,
 };
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index fe4f4e5..3d32ab0 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -50,6 +50,24 @@ static const struct omap_vc_common omap4_vc_common = {
 	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
 };
 
+/* Handle exception case for vc44xx MPU */
+static struct omap_vc_channel_cfg vc44xx_mpu_cfg_channel = {
+	.sa = CFG_CHANNEL_SA,
+	.cmd = BIT(1),
+	.rav = BIT(2),
+	.rac = BIT(3),
+	.racen = BIT(4),
+};
+
+/* for all other */
+struct omap_vc_channel_cfg vc44xx_common_cfg_channel = {
+	.sa = CFG_CHANNEL_SA,
+	.rav = CFG_CHANNEL_RAV,
+	.rac = CFG_CHANNEL_RAC,
+	.racen = CFG_CHANNEL_RACEN,
+	.cmd = CFG_CHANNEL_CMD,
+};
+
 /* VC instance data for each controllable voltage line */
 struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
@@ -58,6 +76,7 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_MPU_L_SHIFT,
+	.cfg_ch_bits = &vc44xx_mpu_cfg_channel,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
@@ -67,6 +86,7 @@ struct omap_vc_channel omap4_vc_iva = {
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_IVA_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_IVA_L_MASK,
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_IVA_L_SHIFT,
+	.cfg_ch_bits = &vc44xx_common_cfg_channel,
 };
 
 struct omap_vc_channel omap4_vc_core = {
@@ -76,5 +96,6 @@ struct omap_vc_channel omap4_vc_core = {
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_CORE_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_CORE_L_MASK,
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_CORE_L_SHIFT,
+	.cfg_ch_bits = &vc44xx_common_cfg_channel,
 };
 
-- 
1.7.1

