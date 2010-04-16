From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 20/22] OMAP3: PM: VP force update method of voltage scaling
Date: Fri, 16 Apr 2010 14:33:15 +0530
Message-ID: <1271408597-3066-21-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
 <1271408597-3066-10-git-send-email-thara@ti.com>
 <1271408597-3066-11-git-send-email-thara@ti.com>
 <1271408597-3066-12-git-send-email-thara@ti.com>
 <1271408597-3066-13-git-send-email-thara@ti.com>
 <1271408597-3066-14-git-send-email-thara@ti.com>
 <1271408597-3066-15-git-send-email-thara@ti.com>
 <1271408597-3066-16-git-send-email-thara@ti.com>
 <1271408597-3066-17-git-send-email-thara@ti.com>
 <1271408597-3066-18-git-send-email-thara@ti.com>
 <1271408597-3066-19-git-send-email-thara@ti.com>
 <1271408597-3066-20-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51450 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756341Ab0DPJDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:31 -0400
In-Reply-To: <1271408597-3066-20-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces VP force update method of voltage scaling
and enables it by default. The older method of vc bypass is now
configuratble through a menu config option. VP force update is the
hardware recommended method of voltage scaling.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |  175 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/voltage.h |    3 +
 2 files changed, 172 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 05b0b78..554f137 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -35,6 +35,7 @@
 #include "voltage.h"
 
 #define VP_IDLE_TIMEOUT		200
+#define VP_TRANXDONE_TIMEOUT	300
 
 /**
  * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
@@ -80,6 +81,7 @@ struct vp_info {
 	u32 vp_vddmin;
 	u32 vp_vddmax;
 	u32 vp_timeout;
+	u32 vp_tranxdone_status;
 };
 static struct vp_info *vp_reg;
 /*
@@ -166,6 +168,9 @@ static struct omap_volt_data omap34xx_vdd2_volt_data[] = {
 	{1150000, 0, 0xF9, 0x18},
 };
 
+/* By default VPFORCEUPDATE is the chosen method of voltage scaling */
+static bool voltscale_vpforceupdate = true;
+
 static inline u32 voltage_read_reg(u8 offset)
 {
 	return prm_read_mod_reg(volt_mod, offset);
@@ -325,6 +330,8 @@ static void __init vp_data_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VDD2) {
 			vp_reg[vp_id].volt_data = omap34xx_vdd2_volt_data;
 			vp_reg[vp_id].volt_data_count =
@@ -334,6 +341,8 @@ static void __init vp_data_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP2_TRANXDONE_ST;
 		} else {
 			pr_warning("Voltage processor%d does not exisit\
 					in OMAP3 \n", vp_id);
@@ -476,6 +485,134 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 	return true;
 }
 
+/* VP force update method of voltage scaling */
+static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt,
+						unsigned long current_volt)
+{
+	u32 smps_steps = 0, smps_delay = 0;
+	u32 vpconfig;
+	int timeout = 0;
+	u8 target_vsel, current_vsel;
+
+	if (!((vdd == VDD1) || (vdd == VDD2))) {
+		pr_warning("Wrong vdd id passed to vp forceupdate\n");
+		return false;
+	}
+
+	target_vsel = omap_twl_uv_to_vsel(target_volt);
+	current_vsel = omap_twl_uv_to_vsel(current_volt);
+	smps_steps = abs(target_vsel - current_vsel);
+
+	if (vdd == VDD1) {
+		u32 vc_cmdval0;
+
+		vc_cmdval0 = voltage_read_reg(vc_reg.cmdval0_reg);
+		vc_cmdval0 &= ~VC_CMD_ON_MASK;
+		vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
+		voltage_write_reg(vc_reg.cmdval0_reg, vc_cmdval0);
+	} else if (vdd == VDD2) {
+		u32 vc_cmdval1;
+
+		vc_cmdval1 = voltage_read_reg(vc_reg.cmdval1_reg);
+		vc_cmdval1 &= ~VC_CMD_ON_MASK;
+		vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
+		voltage_write_reg(vc_reg.cmdval1_reg, vc_cmdval1);
+	}
+
+	/*
+	 * Clear all pending TransactionDone interrupt/status. Typical latency
+	 * is <3us
+	 */
+	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
+		prm_write_mod_reg(vp_reg[vdd].vp_tranxdone_status,
+				OCP_MOD, PRM_IRQSTATUS_REG_OFFSET);
+		if (!(prm_read_mod_reg(OCP_MOD, PRM_IRQSTATUS_REG_OFFSET) &
+				vp_reg[vdd].vp_tranxdone_status))
+				break;
+		udelay(1);
+	}
+
+	if (timeout >= VP_TRANXDONE_TIMEOUT) {
+		pr_warning("VP%d TRANXDONE timeout exceeded. Voltage change \
+				aborted", vdd);
+		return false;
+	}
+
+	/* OMAP3430 has errorgain varying btw higher and lower opp's */
+	if (cpu_is_omap34xx()) {
+		struct omap_volt_data volt_data;
+
+		if (omap_match_volt(vdd, target_volt, &volt_data)) {
+			pr_warning("Unable to get voltage table for VDD%d \
+				during voltage scaling. Some really Wrong!",
+				vdd + 1);
+			return false;
+		}
+		vp_reg[vdd].vp_errorgain = (volt_data.vp_errorgain <<
+				OMAP3430_ERRORGAIN_SHIFT);
+	}
+
+	/* Configure for VP-Force Update */
+	vpconfig = voltage_read_reg(vp_reg[vdd].vp_offs.vpconfig_reg);
+	vpconfig &= ~(VP_CONFIG_INITVDD | VP_FORCEUPDATE |
+			VP_INITVOLTAGE_MASK | VP_ERRORGAIN_MASK);
+	vpconfig |= ((target_vsel << VP_INITVOLTAGE_SHIFT) |
+			vp_reg[vdd].vp_errorgain);
+	voltage_write_reg(vp_reg[vdd].vp_offs.vpconfig_reg, vpconfig);
+
+	/* Trigger initVDD value copy to voltage processor */
+	vpconfig |= VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vdd].vp_offs.vpconfig_reg, vpconfig);
+
+	/* Force update of voltage */
+	vpconfig |= VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vdd].vp_offs.vpconfig_reg, vpconfig);
+
+	timeout = 0;
+	/*
+	 * Wait for TransactionDone. Typical latency is <200us.
+	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
+	 */
+	omap_test_timeout((prm_read_mod_reg(OCP_MOD, PRM_IRQSTATUS_REG_OFFSET) &
+			vp_reg[vdd].vp_tranxdone_status),
+			VP_TRANXDONE_TIMEOUT, timeout);
+
+	if (timeout >= VP_TRANXDONE_TIMEOUT)
+		pr_warning("VP%d TRANXDONE timeout exceeded. TRANXDONE never \
+			got set after the voltage update.Serious error!!!!\n",
+			vdd);
+
+	/* Wait for voltage to settle with SW wait-loop */
+	smps_delay = ((smps_steps * 125) / 40) + 2;
+	udelay(smps_delay);
+
+	/*
+	 * Disable TransactionDone interrupt , clear all status, clear
+	 * control registers
+	 */
+	timeout = 0;
+	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
+		prm_write_mod_reg(vp_reg[vdd].vp_tranxdone_status,
+				OCP_MOD, PRM_IRQSTATUS_REG_OFFSET);
+		if (!(prm_read_mod_reg(OCP_MOD, PRM_IRQSTATUS_REG_OFFSET) &
+				vp_reg[vdd].vp_tranxdone_status))
+				break;
+		udelay(1);
+	}
+	if (timeout >= VP_TRANXDONE_TIMEOUT)
+		pr_warning("VP%d TRANXDONE timeout exceeded while trying to \
+			clear the TRANXDONE status\n", vdd);
+
+	vpconfig = voltage_read_reg(vp_reg[vdd].vp_offs.vpconfig_reg);
+	/* Clear initVDD copy trigger bit */
+	vpconfig &= ~VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vdd].vp_offs.vpconfig_reg, vpconfig);
+	/* Clear force bit */
+	vpconfig &= ~VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vdd].vp_offs.vpconfig_reg, vpconfig);
+
+	return true;
+}
 
 static void __init init_voltageprocessors(void)
 {
@@ -586,7 +723,9 @@ void omap_voltageprocessor_enable(int vp_id)
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
 	 */
-	vp_latch_vsel(vp_id);
+	if (!voltscale_vpforceupdate)
+		vp_latch_vsel(vp_id);
+
 	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
 	/* Enable VP */
 	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg,
@@ -638,11 +777,12 @@ void omap_voltageprocessor_disable(int vp_id)
  */
 int omap_voltage_scale(int vdd, unsigned long target_volt,
 					unsigned long current_volt)
-{	/*
-	 * TODO add VP force update method of voltage scaling
-	 * and choose btw the two
-	 */
-	return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
+{
+	if (voltscale_vpforceupdate)
+		return vp_forceupdate_scale_voltage(vdd, target_volt,
+								current_volt);
+	else
+		return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
 }
 
 /**
@@ -679,6 +819,29 @@ void omap_reset_voltage(int vdd)
 }
 
 /**
+ * omap_change_voltscale_method : API to change the voltage scaling method.
+ * @voltscale_method : the method to be used for voltage scaling.
+ *
+ * This API can be used by the board files to change the method of voltage
+ * scaling between vpforceupdate and vcbypass. The parameter values are
+ * defined in voltage.h
+ */
+void omap_change_voltscale_method(int voltscale_method)
+{
+	switch (voltscale_method) {
+	case VOLTSCALE_VPFORCEUPDATE:
+		voltscale_vpforceupdate = true;
+		return;
+	case VOLTSCALE_VCBYPASS:
+		voltscale_vpforceupdate = false;
+		return;
+	default:
+		pr_warning("Trying to change the method of voltage scaling \
+				to an unsupported one!\n");
+	}
+}
+
+/**
  * omap3_pm_init_vc - polpulates vc_config with values specified in board file
  * @setup_vc - the structure with various vc parameters
  *
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 8800369..473a953 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -14,7 +14,10 @@
 #define VDD1	0
 #define VDD2	1
 
+#define VOLTSCALE_VPFORCEUPDATE		1
+#define VOLTSCALE_VCBYPASS		2
 
+#define PRM_IRQSTATUS_REG_OFFSET	OMAP3_PRM_IRQSTATUS_MPU_OFFSET
 /* Generic VP definitions. Need to be redefined for OMAP4 */
 #define VP_CONFIG_TIMEOUTEN	OMAP3430_TIMEOUTEN
 #define VP_CONFIG_INITVDD	OMAP3430_INITVDD
-- 
1.7.0.rc1.33.g07cf0f

