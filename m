From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 06/11] OMAP4: PM: VC: fix channel bit offset for MPU
Date: Wed, 18 May 2011 00:17:29 -0500
Message-ID: <1305695854-9638-7-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47760 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392Ab1ERFRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:39 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HdXq028652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hcax002796
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Patch "OMAP3+: VC: abstract out channel configuration" abstracts out
VC channel configuration. However, TRM has it's little surprises such
as the following for channel_cfg:
CFG_CHANNEL_SA    BIT(0)
CFG_CHANNEL_RAV   BIT(1)
CFG_CHANNEL_RAC   BIT(2)
CFG_CHANNEL_RACEN BIT(3)
CFG_CHANNEL_CMD   BIT(4)
is valid for core and iva, *but* for mpu, the channel offsets
are as follows:
CFG_CHANNEL_SA    BIT(0)
CFG_CHANNEL_CMD   BIT(1)
CFG_CHANNEL_RAV   BIT(2)
CFG_CHANNEL_RAC   BIT(3)
CFG_CHANNEL_RACEN BIT(4)

to handle this on the fly, add a structure to describe this
and use the structure for vc44xx mpu definition. use the
default for rest of the domains.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   35 +++++++++++++++++++----------------
 arch/arm/mach-omap2/vc.h          |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc44xx_data.c |   10 ++++++++++
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index f8185d2..2add945 100644
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
@@ -258,6 +246,14 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	struct omap_vc_channel *vc = voltdm->vc;
 	u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
 	u32 val;
+	struct omap_vc_channel_cfg *cfg_channel_data;
+	struct omap_vc_channel_cfg cfg_channel_common = {
+		.cfg_channel_sa = CFG_CHANNEL_SA,
+		.cfg_channel_rav = CFG_CHANNEL_RAV,
+		.cfg_channel_rac = CFG_CHANNEL_RAC,
+		.cfg_channel_racen = CFG_CHANNEL_RACEN,
+		.cfg_channel_cmd = CFG_CHANNEL_CMD,
+	};
 
 	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
 		pr_err("%s: PMIC info requried to configure vc for"
@@ -272,6 +268,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		return;
 	}
 
+	/* if there is an exception case, use the exception data */
+	if (!vc->cfg_ch_data)
+		cfg_channel_data = &cfg_channel_common;
+	else
+		cfg_channel_data = vc->cfg_ch_data;
+
 	vc->cfg_channel = 0;
 
 	/* get PMIC/board specific settings */
@@ -284,7 +286,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
 		    vc->common->smps_sa_reg);
-	vc->cfg_channel |= CFG_CHANNEL_SA;
+	vc->cfg_channel |= cfg_channel_data->cfg_channel_sa;
 
 	/*
 	 * Configure the PMIC register addresses.
@@ -292,13 +294,14 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_volra_mask,
 		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
 		    vc->common->smps_volra_reg);
-	vc->cfg_channel |= CFG_CHANNEL_RAV;
+	vc->cfg_channel |= cfg_channel_data->cfg_channel_rav;
 
 	if (vc->cmd_reg_addr) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
-		vc->cfg_channel |= CFG_CHANNEL_RAC | CFG_CHANNEL_RACEN;
+		vc->cfg_channel |= cfg_channel_data->cfg_channel_rac |
+					cfg_channel_data->cfg_channel_racen;
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
@@ -311,7 +314,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	       (ret_vsel << vc->common->cmd_ret_shift) |
 	       (off_vsel << vc->common->cmd_off_shift));
 	voltdm->write(val, vc->cmdval_reg);
-	vc->cfg_channel |= CFG_CHANNEL_CMD;
+	vc->cfg_channel |= cfg_channel_data->cfg_channel_cmd;
 
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index f0fb61f..bbd8f1f 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -62,11 +62,42 @@ struct omap_vc_common {
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
+ * @cfg_channel_sa:	SA_VDD_xxx_L
+ * @cfg_channel_rav:	RAV_VDD_xxx_L
+ * @cfg_channel_rac:	RAC_VDD_xxx_L
+ * @cfg_channel_racen:	RACEN_VDD_xxx_L
+ * @cfg_channel_cmd:	CMD_VDD_xxx_L
+ *
+ * by default it uses CFG_CHANNEL_xyz regs, but in OMAP4 MPU,
+ * there is a need for an exception case.
+ */
+struct omap_vc_channel_cfg {
+	u8 cfg_channel_sa;
+	u8 cfg_channel_rav;
+	u8 cfg_channel_rac;
+	u8 cfg_channel_racen;
+	u8 cfg_channel_cmd;
+};
+
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
  * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
+ * @cfg_ch_data: exception handling for unordered register bits in cfg_channel
  */
 struct omap_vc_channel {
 	/* channel state */
@@ -74,6 +105,7 @@ struct omap_vc_channel {
 	u8 volt_reg_addr;
 	u8 cmd_reg_addr;
 	u8 cfg_channel;
+	struct omap_vc_channel_cfg *cfg_ch_data;
 	u16 setup_time;
 	bool i2c_high_speed;
 
@@ -86,6 +118,7 @@ struct omap_vc_channel {
 	u8 cfg_channel_sa_shift;
 };
 
+
 extern struct omap_vc_channel omap3_vc_mpu;
 extern struct omap_vc_channel omap3_vc_core;
 
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index fe4f4e5..b53b05e 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -50,6 +50,15 @@ static const struct omap_vc_common omap4_vc_common = {
 	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
 };
 
+/* handle exception case for vc44xx */
+static struct omap_vc_channel_cfg vc44xx_mpu_cfg_channel = {
+	.cfg_channel_sa = CFG_CHANNEL_SA,
+	.cfg_channel_cmd = BIT(1),
+	.cfg_channel_rav = BIT(2),
+	.cfg_channel_rac = BIT(3),
+	.cfg_channel_racen = BIT(4),
+};
+
 /* VC instance data for each controllable voltage line */
 struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
@@ -58,6 +67,7 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_MPU_L_SHIFT,
+	.cfg_ch_data = &vc44xx_mpu_cfg_channel,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
-- 
1.7.0.4

