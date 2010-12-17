From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv5 00/10] OMAP: Adding Smartreflex and Voltage driver support
Date: Fri, 17 Dec 2010 06:32:11 -0800
Message-ID: <87vd2s8o7o.fsf@deeprootsystems.com>
References: <1292004181-4804-1-git-send-email-thara@ti.com>
	<8739px9oe8.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373A9376A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42046 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab0LQOcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 09:32:16 -0500
Received: by iyi12 with SMTP id 12so466450iyi.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 06:32:15 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373A9376A@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 17 Dec 2010 17:06:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>
>>>Also, it needs (hopefully only) one more rebase/repost.
>>>
>>>First, a few things have changed at the PRCM API level that need to be
>>>updated.  I have a untested patch (below) that should fix this for you,
>>>that you'll need to split and apply to the OMAP3 and OMAP4 voltage
>>>driver patches.
>
> You have forgotten to attach the patch! Can you please share it.
>

Sorry...

Here it is.  It is not yet functional as I did not assign the function
pointers, but shows an approach to fixing the problem.  Please
check/confirm my fix with Rajendra as he has been more involved in the
low-level PRCM API changes.

Kevin

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 6e91748..f28c778 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -150,6 +150,8 @@ struct omap_vdd_info {
 	bool vp_enabled;
 	int (*volt_scale) (struct omap_vdd_info *vdd,
 		unsigned long target_volt);
+	u32 (*read_reg)(s16 inst, u16 idx);
+	u32 (*write_reg)(u32 val, s16 inst, u16 idx);
 };
 
 static struct omap_vdd_info *vdd_info;
@@ -321,7 +323,7 @@ static int vp_volt_debug_get(void *data, u64 *val)
 		return -EINVAL;
 	}
 
-	vsel = prm_read_mod_reg(vdd->vp_reg.prm_mod, vdd->vp_offs.voltage);
+	vsel = vdd->read_reg(vdd->vp_reg.prm_mod, vdd->vp_offs.voltage);
 	pr_notice("curr_vsel = %x\n", vsel);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
@@ -375,19 +377,19 @@ static void vp_latch_vsel(struct omap_vdd_info *vdd)
 
 	vsel = vdd->pmic_info->uv_to_vsel(uvdc);
 
-	vpconfig = prm_read_mod_reg(mod, vdd->vp_offs.vpconfig);
+	vpconfig = vdd->read_reg(mod, vdd->vp_offs.vpconfig);
 	vpconfig &= ~(vdd->vp_reg.vpconfig_initvoltage_mask |
 			vdd->vp_reg.vpconfig_initvdd);
 	vpconfig |= vsel << vdd->vp_reg.vpconfig_initvoltage_shift;
 
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	/* Trigger initVDD value copy to voltage processor */
-	prm_write_mod_reg((vpconfig | vdd->vp_reg.vpconfig_initvdd), mod,
+	vdd->write_reg((vpconfig | vdd->vp_reg.vpconfig_initvdd), mod,
 			vdd->vp_offs.vpconfig);
 
 	/* Clear initVDD copy trigger bit */
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 }
 
 /* Generic voltage init functions */
@@ -402,19 +404,19 @@ static void __init vp_init(struct omap_vdd_info *vdd)
 		(vdd->vp_reg.vpconfig_errorgain <<
 		vdd->vp_reg.vpconfig_errorgain_shift) |
 		vdd->vp_reg.vpconfig_timeouten;
-	prm_write_mod_reg(vp_val, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vp_val, mod, vdd->vp_offs.vpconfig);
 
 	vp_val = ((vdd->vp_reg.vstepmin_smpswaittimemin <<
 		vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
 		(vdd->vp_reg.vstepmin_stepmin <<
 		vdd->vp_reg.vstepmin_stepmin_shift));
-	prm_write_mod_reg(vp_val, mod, vdd->vp_offs.vstepmin);
+	vdd->write_reg(vp_val, mod, vdd->vp_offs.vstepmin);
 
 	vp_val = ((vdd->vp_reg.vstepmax_smpswaittimemax <<
 		vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
 		(vdd->vp_reg.vstepmax_stepmax <<
 		vdd->vp_reg.vstepmax_stepmax_shift));
-	prm_write_mod_reg(vp_val, mod, vdd->vp_offs.vstepmax);
+	vdd->write_reg(vp_val, mod, vdd->vp_offs.vstepmax);
 
 	vp_val = ((vdd->vp_reg.vlimitto_vddmax <<
 		vdd->vp_reg.vlimitto_vddmax_shift) |
@@ -422,7 +424,7 @@ static void __init vp_init(struct omap_vdd_info *vdd)
 		vdd->vp_reg.vlimitto_vddmin_shift) |
 		(vdd->vp_reg.vlimitto_timeout <<
 		vdd->vp_reg.vlimitto_timeout_shift));
-	prm_write_mod_reg(vp_val, mod, vdd->vp_offs.vlimitto);
+	vdd->write_reg(vp_val, mod, vdd->vp_offs.vlimitto);
 }
 
 static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
@@ -503,23 +505,23 @@ static int _pre_volt_scale(struct omap_vdd_info *vdd,
 		volt_data = NULL;
 
 	*target_vsel = vdd->pmic_info->uv_to_vsel(target_volt);
-	*current_vsel = prm_read_mod_reg(vp_mod, vdd->vp_offs.voltage);
+	*current_vsel = vdd->read_reg(vp_mod, vdd->vp_offs.voltage);
 
 	/* Setting the ON voltage to the new target voltage */
-	vc_cmdval = prm_read_mod_reg(vc_mod, vdd->vc_reg.cmdval_reg);
+	vc_cmdval = vdd->read_reg(vc_mod, vdd->vc_reg.cmdval_reg);
 	vc_cmdval &= ~vdd->vc_reg.cmd_on_mask;
 	vc_cmdval |= (*target_vsel << vdd->vc_reg.cmd_on_shift);
-	prm_write_mod_reg(vc_cmdval, vc_mod, vdd->vc_reg.cmdval_reg);
+	vdd->write_reg(vc_cmdval, vc_mod, vdd->vc_reg.cmdval_reg);
 
 	/* Setting vp errorgain based on the voltage */
 	if (volt_data) {
-		vp_errgain_val = prm_read_mod_reg(vp_mod,
+		vp_errgain_val = vdd->read_reg(vp_mod,
 				vdd->vp_offs.vpconfig);
 		vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
 		vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
 		vp_errgain_val |= vdd->vp_reg.vpconfig_errorgain <<
 				vdd->vp_reg.vpconfig_errorgain_shift;
-		prm_write_mod_reg(vp_errgain_val, vp_mod,
+		vdd->write_reg(vp_errgain_val, vp_mod,
 				vdd->vp_offs.vpconfig);
 	}
 
@@ -564,10 +566,10 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 			(vdd->pmic_info->i2c_slave_addr <<
 			vdd->vc_reg.slaveaddr_shift);
 
-	prm_write_mod_reg(vc_bypass_value, mod, vc_bypass_val_reg);
-	prm_write_mod_reg(vc_bypass_value | vc_valid, mod, vc_bypass_val_reg);
+	vdd->write_reg(vc_bypass_value, mod, vc_bypass_val_reg);
+	vdd->write_reg(vc_bypass_value | vc_valid, mod, vc_bypass_val_reg);
 
-	vc_bypass_value = prm_read_mod_reg(mod, vc_bypass_val_reg);
+	vc_bypass_value = vdd->read_reg(mod, vc_bypass_val_reg);
 	/*
 	 * Loop till the bypass command is acknowledged from the SMPS.
 	 * NOTE: This is legacy code. The loop count and retry count needs
@@ -586,7 +588,7 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 			loop_cnt = 0;
 			udelay(10);
 		}
-		vc_bypass_value = prm_read_mod_reg(mod, vc_bypass_val_reg);
+		vc_bypass_value = vdd->read_reg(mod, vc_bypass_val_reg);
 	}
 
 	_post_volt_scale(vdd, target_volt, target_vsel, current_vsel);
@@ -615,9 +617,9 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 * is <3us
 	 */
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		prm_write_mod_reg(vdd->vp_reg.tranxdone_status,
+		vdd->write_reg(vdd->vp_reg.tranxdone_status,
 				ocp_mod, prm_irqst_reg);
-		if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg) &
+		if (!(vdd->read_reg(ocp_mod, prm_irqst_reg) &
 				vdd->vp_reg.tranxdone_status))
 				break;
 		udelay(1);
@@ -629,28 +631,28 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	}
 
 	/* Configure for VP-Force Update */
-	vpconfig = prm_read_mod_reg(mod, vdd->vp_offs.vpconfig);
+	vpconfig = vdd->read_reg(mod, vdd->vp_offs.vpconfig);
 	vpconfig &= ~(vdd->vp_reg.vpconfig_initvdd |
 			vdd->vp_reg.vpconfig_forceupdate |
 			vdd->vp_reg.vpconfig_initvoltage_mask);
 	vpconfig |= ((target_vsel <<
 			vdd->vp_reg.vpconfig_initvoltage_shift));
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	/* Trigger initVDD value copy to voltage processor */
 	vpconfig |= vdd->vp_reg.vpconfig_initvdd;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	/* Force update of voltage */
 	vpconfig |= vdd->vp_reg.vpconfig_forceupdate;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	/*
 	 * Wait for TransactionDone. Typical latency is <200us.
 	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
 	 */
 	timeout = 0;
-	omap_test_timeout((prm_read_mod_reg(ocp_mod, prm_irqst_reg) &
+	omap_test_timeout((vdd->read_reg(ocp_mod, prm_irqst_reg) &
 			vdd->vp_reg.tranxdone_status),
 			VP_TRANXDONE_TIMEOUT, timeout);
 	if (timeout >= VP_TRANXDONE_TIMEOUT)
@@ -666,9 +668,9 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	 */
 	timeout = 0;
 	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
-		prm_write_mod_reg(vdd->vp_reg.tranxdone_status,
+		vdd->write_reg(vdd->vp_reg.tranxdone_status,
 				ocp_mod, prm_irqst_reg);
-		if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg) &
+		if (!(vdd->read_reg(ocp_mod, prm_irqst_reg) &
 				vdd->vp_reg.tranxdone_status))
 				break;
 		udelay(1);
@@ -679,13 +681,13 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 			"to clear the TRANXDONE status\n",
 			__func__, vdd->voltdm.name);
 
-	vpconfig = prm_read_mod_reg(mod, vdd->vp_offs.vpconfig);
+	vpconfig = vdd->read_reg(mod, vdd->vp_offs.vpconfig);
 	/* Clear initVDD copy trigger bit */
 	vpconfig &= ~vdd->vp_reg.vpconfig_initvdd;;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 	/* Clear force bit */
 	vpconfig &= ~vdd->vp_reg.vpconfig_forceupdate;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	return 0;
 }
@@ -713,23 +715,23 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 	mod = vdd->vc_reg.prm_mod;
 
 	/* Set up the SMPS_SA(i2c slave address in VC */
-	vc_val = prm_read_mod_reg(mod, vdd->vc_reg.smps_sa_reg);
+	vc_val = vdd->read_reg(mod, vdd->vc_reg.smps_sa_reg);
 	vc_val &= ~vdd->vc_reg.smps_sa_mask;
 	vc_val |= vdd->pmic_info->i2c_slave_addr << vdd->vc_reg.smps_sa_shift;
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.smps_sa_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.smps_sa_reg);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
-	vc_val = prm_read_mod_reg(mod, vdd->vc_reg.smps_volra_reg);
+	vc_val = vdd->read_reg(mod, vdd->vc_reg.smps_volra_reg);
 	vc_val &= ~vdd->vc_reg.smps_volra_mask;
 	vc_val |= vdd->pmic_info->pmic_reg << vdd->vc_reg.smps_volra_shift;
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.smps_volra_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.smps_volra_reg);
 
 	/*Configure the setup times */
-	vc_val = prm_read_mod_reg(mod, vdd->vc_reg.voltsetup_reg);
+	vc_val = vdd->read_reg(mod, vdd->vc_reg.voltsetup_reg);
 	vc_val &= ~vdd->vc_reg.voltsetup_mask;
 	vc_val |= vdd->pmic_info->volt_setup_time <<
 			vdd->vc_reg.voltsetup_shift;
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.voltsetup_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.voltsetup_reg);
 
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = vdd->pmic_info->uv_to_vsel(vdd->pmic_info->on_volt);
@@ -740,19 +742,19 @@ static void __init omap3_vc_init(struct omap_vdd_info *vdd)
 		(onlp_vsel << vdd->vc_reg.cmd_onlp_shift) |
 		(ret_vsel << vdd->vc_reg.cmd_ret_shift) |
 		(off_vsel << vdd->vc_reg.cmd_off_shift));
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.cmdval_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.cmdval_reg);
 
 	if (is_initialized)
 		return;
 
 	/* Generic VC parameters init */
-	prm_write_mod_reg(OMAP3430_CMD1_MASK | OMAP3430_RAV1_MASK, mod,
+	vdd->write_reg(OMAP3430_CMD1_MASK | OMAP3430_RAV1_MASK, mod,
 			OMAP3_PRM_VC_CH_CONF_OFFSET);
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK, mod,
+	vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MASK, mod,
 			OMAP3_PRM_VC_I2C_CFG_OFFSET);
-	prm_write_mod_reg(OMAP3_CLKSETUP, mod, OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg(OMAP3_VOLTOFFSET, mod, OMAP3_PRM_VOLTOFFSET_OFFSET);
-	prm_write_mod_reg(OMAP3_VOLTSETUP2, mod, OMAP3_PRM_VOLTSETUP2_OFFSET);
+	vdd->write_reg(OMAP3_CLKSETUP, mod, OMAP3_PRM_CLKSETUP_OFFSET);
+	vdd->write_reg(OMAP3_VOLTOFFSET, mod, OMAP3_PRM_VOLTOFFSET_OFFSET);
+	vdd->write_reg(OMAP3_VOLTSETUP2, mod, OMAP3_PRM_VOLTSETUP2_OFFSET);
 	is_initialized = true;
 }
 
@@ -896,16 +898,16 @@ static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 	mod = vdd->vc_reg.prm_mod;
 
 	/* Set up the SMPS_SA(i2c slave address in VC */
-	vc_val = prm_read_mod_reg(mod, vdd->vc_reg.smps_sa_reg);
+	vc_val = vdd->read_reg(mod, vdd->vc_reg.smps_sa_reg);
 	vc_val &= ~vdd->vc_reg.smps_sa_mask;
 	vc_val |= vdd->pmic_info->i2c_slave_addr << vdd->vc_reg.smps_sa_shift;
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.smps_sa_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.smps_sa_reg);
 
 	/* Setup the VOLRA(pmic reg addr) in VC */
-	vc_val = prm_read_mod_reg(mod, vdd->vc_reg.smps_volra_reg);
+	vc_val = vdd->read_reg(mod, vdd->vc_reg.smps_volra_reg);
 	vc_val &= ~vdd->vc_reg.smps_volra_mask;
 	vc_val |= vdd->pmic_info->pmic_reg << vdd->vc_reg.smps_volra_shift;
-	prm_write_mod_reg(vc_val, mod, vdd->vc_reg.smps_volra_reg);
+	vdd->write_reg(vc_val, mod, vdd->vc_reg.smps_volra_reg);
 
 	/* TODO: Configure setup times and CMD_VAL values*/
 
@@ -916,10 +918,10 @@ static void __init omap4_vc_init(struct omap_vdd_info *vdd)
 	vc_val = (OMAP4430_RAV_VDD_MPU_L_MASK | OMAP4430_CMD_VDD_MPU_L_MASK |
 		OMAP4430_RAV_VDD_IVA_L_MASK | OMAP4430_CMD_VDD_IVA_L_MASK |
 		OMAP4430_RAV_VDD_CORE_L_MASK | OMAP4430_CMD_VDD_CORE_L_MASK);
-	prm_write_mod_reg(vc_val, mod, OMAP4_PRM_VC_CFG_CHANNEL_OFFSET);
+	vdd->write_reg(vc_val, mod, OMAP4_PRM_VC_CFG_CHANNEL_OFFSET);
 
 	vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4430_SCLH_SHIFT);
-	prm_write_mod_reg(vc_val, mod, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
+	vdd->write_reg(vc_val, mod, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
 
 	is_initialized = true;
 }
@@ -994,12 +996,12 @@ static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 
 	/* Generic voltage parameters */
 	vdd->curr_volt = 1200000;
-	vdd->ocp_mod = OMAP4430_PRM_OCP_SOCKET_MOD;
+	vdd->ocp_mod = OMAP4430_PRM_OCP_SOCKET_INST;
 	vdd->volt_scale = vp_forceupdate_scale_voltage;
 	vdd->vp_enabled = false;
 
 	/* VC parameters */
-	vdd->vc_reg.prm_mod = OMAP4430_PRM_DEVICE_MOD;
+	vdd->vc_reg.prm_mod = OMAP4430_PRM_DEVICE_INST;
 	vdd->vc_reg.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET;
 	vdd->vc_reg.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET;
 	vdd->vc_reg.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET;
@@ -1013,7 +1015,7 @@ static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	vdd->vc_reg.cmd_ret_shift = OMAP4430_RET_SHIFT;
 	vdd->vc_reg.cmd_off_shift = OMAP4430_OFF_SHIFT;
 
-	vdd->vp_reg.prm_mod = OMAP4430_PRM_DEVICE_MOD;
+	vdd->vp_reg.prm_mod = OMAP4430_PRM_DEVICE_INST;
 
 	/* VPCONFIG bit fields */
 	vdd->vp_reg.vpconfig_erroroffset = (vdd->pmic_info->vp_erroroffset <<
@@ -1091,7 +1093,7 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
 
 	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
 
-	curr_vsel = prm_read_mod_reg(vdd->vp_reg.prm_mod,
+	curr_vsel = vdd->read_reg(vdd->vp_reg.prm_mod,
 			vdd->vp_offs.voltage);
 
 	if (!vdd->pmic_info || !vdd->pmic_info->vsel_to_uv) {
@@ -1132,9 +1134,9 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	vp_latch_vsel(vdd);
 
 	/* Enable VP */
-	vpconfig = prm_read_mod_reg(mod, vdd->vp_offs.vpconfig);
+	vpconfig = vdd->read_reg(mod, vdd->vp_offs.vpconfig);
 	vpconfig |= vdd->vp_reg.vpconfig_vpenable;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 	vdd->vp_enabled = true;
 }
 
@@ -1169,14 +1171,14 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	}
 
 	/* Disable VP */
-	vpconfig = prm_read_mod_reg(mod, vdd->vp_offs.vpconfig);
+	vpconfig = vdd->read_reg(mod, vdd->vp_offs.vpconfig);
 	vpconfig &= ~vdd->vp_reg.vpconfig_vpenable;
-	prm_write_mod_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
+	vdd->write_reg(vpconfig, mod, vdd->vp_offs.vpconfig);
 
 	/*
 	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
 	 */
-	omap_test_timeout((prm_read_mod_reg(mod, vdd->vp_offs.vstatus)),
+	omap_test_timeout((vdd->read_reg(mod, vdd->vp_offs.vstatus)),
 				VP_IDLE_TIMEOUT, timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)


