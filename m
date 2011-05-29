From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept of default channel
Date: Sun, 29 May 2011 16:19:39 -0700
Message-ID: <1306711180-8631-3-git-send-email-nm@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48814 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752683Ab1E2XTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 19:19:50 -0400
Received: by gwj22 with SMTP id 22so1864589gwj.7
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 16:19:48 -0700 (PDT)
In-Reply-To: <1306711180-8631-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Due to a TRM bug, the current code assumes that channel0(core) is the default
channel. With the additional explanation provided by the hardware team, it is
clear that PRM_VC_CFG_CHANNEL register allows for flexibility of configuring
for various PMIC configurations. For example, the I2C slave address on TWL6030
when using 4430 configuration could potentially use the same slave address for
all domains, while in 4460 configuration, we drive MPU using TPS; Core and IVA
using TWL6030. To allow this flexibility, we state in existing parameters using
a flag to indicate usage of default channel.

In addition, the TRM update clears up the confusion on the fact that MPU is
infact the default channel on OMAP4.

We update the same here.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   58 ++++++++++++++++++++++++-------------
 arch/arm/mach-omap2/vc.h          |    8 +++--
 arch/arm/mach-omap2/vc44xx_data.c |    1 +
 arch/arm/mach-omap2/voltage.h     |    9 ++++++
 4 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 6437460..42c77a8 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -22,20 +22,20 @@
  * - command values for ON, ONLP, RET and OFF (CMD)
  *
  * This function currently only allows flexible configuration of
- * the non-default channel (e.g. non-zero channels.)  Starting with
- * OMAP4, only the non-zero channels can be configured.  Channel zero
- * always uses the channel zero register values.  Therefore, the
- * same limitation is imposed on OMAP3 for consistency.
+ * the non-default channels.  Introduced in OMAP4, is a concept of a default
+ * channel - in OMAP4, this channel is MPU, all other domains could optionally
+ * link their i2c regs to use MPU channel's configuration if required.
  */
 static int omap_vc_config_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 
 	/*
-	 * For channel zero, the only configurable bit is RACEN.
-	 * All others must stay at zero (see function comment above.)
+	 * For default channel, the only configurable bit is RACEN.
+	 * All others default channel bits stays at zero
+	 * (see function comment above.)
 	 */
-	if (!vc->cfg_channel_sa_shift)
+	if (vc->is_default_channel)
 		vc->cfg_channel &= CFG_CHANNEL_RACEN;
 
 	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
@@ -261,6 +261,18 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 	cfg_channel_data = vc->cfg_ch_bits;
 
+	/* Dont proceed if channel configurations are messed up */
+	if (vc->is_default_channel &&
+		(vc->i2c_slave_addr == USE_DEFAULT_CHANNEL_I2C_PARAM ||
+		 vc->cmd_reg_addr == USE_DEFAULT_CHANNEL_I2C_PARAM ||
+		 vc->volt_reg_addr == USE_DEFAULT_CHANNEL_I2C_PARAM)) {
+		pr_err("%s: Voltage Domain %s is default.INVALID CONFIGURATION:"
+			"slave_add = %04x cmd=%04x vol=%04x!\n",
+			__func__, voltdm->name, vc->i2c_slave_addr,
+			vc->cmd_reg_addr, vc->volt_reg_addr);
+		return;
+	}
+
 	vc->cfg_channel = 0;
 
 	/* get PMIC/board specific settings */
@@ -269,26 +281,32 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
 	vc->setup_time = voltdm->pmic->volt_setup_time;
 
-	/* Configure the i2c slave address for this VC */
-	voltdm->rmw(vc->smps_sa_mask,
-		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
-		    vc->common->smps_sa_reg);
-	vc->cfg_channel |= cfg_channel_data->sa;
+	/* Configure the I2C slave address for this VC */
+	if (vc->i2c_slave_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
+		voltdm->rmw(vc->smps_sa_mask,
+			    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
+			    vc->common->smps_sa_reg);
+		vc->cfg_channel |= cfg_channel_data->sa;
+	}
 
 	/*
 	 * Configure the PMIC register addresses.
 	 */
-	voltdm->rmw(vc->smps_volra_mask,
-		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
-		    vc->common->smps_volra_reg);
-	vc->cfg_channel |= cfg_channel_data->rav;
-
-	if (vc->cmd_reg_addr) {
+	if (vc->cmd_reg_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
-		vc->cfg_channel |= cfg_channel_data->rac |
-					cfg_channel_data->racen;
+		vc->cfg_channel |= cfg_channel_data->rac;
+	}
+
+	/* if voltage and cmd regs are same, we can use cmdra register */
+	if (vc->volt_reg_addr == vc->cmd_reg_addr) {
+		vc->cfg_channel |= cfg_channel_data->racen;
+	} else if (vc->volt_reg_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
+		voltdm->rmw(vc->smps_volra_mask,
+			    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
+			    vc->common->smps_volra_reg);
+		vc->cfg_channel |= cfg_channel_data->rav;
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index 2538089..96739a2 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -92,15 +92,16 @@ struct omap_vc_channel_cfg {
 /**
  * struct omap_vc_channel - VC per-instance data
  * @common: pointer to VC common data for this platform
+ * @is_master_channel: if the channel is the master channel
  * @smps_sa_mask: i2c slave address bitmask in the PRM_VC_SMPS_SA register
  * @smps_volra_mask: VOLRA* bitmask in the PRM_VC_VOL_RA register
  * @cfg_ch_bits: exception handling for unordered register bits in cfg_channel
  */
 struct omap_vc_channel {
 	/* channel state */
-	u8 i2c_slave_addr;
-	u8 volt_reg_addr;
-	u8 cmd_reg_addr;
+	u16 i2c_slave_addr;
+	u16 volt_reg_addr;
+	u16 cmd_reg_addr;
 	u8 cfg_channel;
 	struct omap_vc_channel_cfg *cfg_ch_bits;
 	u16 setup_time;
@@ -108,6 +109,7 @@ struct omap_vc_channel {
 
 	/* register access data */
 	const struct omap_vc_common *common;
+	bool is_default_channel;
 	u32 smps_sa_mask;
 	u32 smps_volra_mask;
 	u32 smps_cmdra_mask;
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 3d32ab0..817e87d 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -71,6 +71,7 @@ struct omap_vc_channel_cfg vc44xx_common_cfg_channel = {
 /* VC instance data for each controllable voltage line */
 struct omap_vc_channel omap4_vc_mpu = {
 	.common = &omap4_vc_common,
+	.is_default_channel = true,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index f079167..02f8969 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -109,6 +109,15 @@ struct omap_volt_data {
 	u8	vp_errgain;
 };
 
+/*
+ * Introduced in OMAP4, is a concept of a default channe - in OMAP4, this
+ * channel is MPU, all other domains such as IVA/CORE, could optionally
+ * link their i2c reg configuration to use MPU channel's configuration if
+ * required. To do this, mark in the PMIC structure's
+ * i2c_slave_addr/volt_reg_addr/cmd_reg_addr with this macro.
+ */
+#define USE_DEFAULT_CHANNEL_I2C_PARAM	0x10000
+
 /**
  * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
  * @slew_rate:	PMIC slew rate (in uv/us)
-- 
1.7.1

