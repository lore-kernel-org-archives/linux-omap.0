From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 16/17] OMAP3: PM: VP force update method of voltage scaling
Date: Thu, 18 Mar 2010 14:45:54 +0530
Message-ID: <1268903755-4151-17-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
 <1268903755-4151-13-git-send-email-thara@ti.com>
 <1268903755-4151-14-git-send-email-thara@ti.com>
 <1268903755-4151-15-git-send-email-thara@ti.com>
 <1268903755-4151-16-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50251 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-16-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces VP force update method of voltage scaling
and enables it by default. The older method of vc bypass is now
configuratble through a menu config option. VP force update is the
hardware recommended method of voltage scaling.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/voltage.c |  171 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/voltage.h |    3 +
 2 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index d660d02..8fd1949 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -35,6 +35,7 @@
 #include "voltage.h"
 
 #define VP_IDLE_TIMEOUT		200
+#define VP_TRANXDONE_TIMEOUT	300
 #define VDD1_LOWOPP_VOLT	1075000
 #define VDD2_LOWOPP_VOLT	1050000
 
@@ -77,6 +78,7 @@ struct vp_reg_info {
 	u32 vp_vddmin;
 	u32 vp_vddmax;
 	u32 vp_timeout;
+	u32 vp_tranxdone_status;
 };
 static struct vp_reg_info *vp_reg;
 /*
@@ -140,6 +142,9 @@ static struct prm_setup_vc vc_config = {
 	.vdd1_off = 0x00,       /* 0.6v */
 };
 
+/* By default VPFORCEUPDATE is the chosen method of voltage scaling */
+static bool voltscale_vpforceupdate = true;
+
 static inline u32 voltage_read_reg(void __iomem *offset)
 {
 	return __raw_readl(offset);
@@ -311,12 +316,16 @@ static void __init vp_reg_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VP2) {
 			curr_volt = get_curr_vdd2_voltage();
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP2_TRANXDONE_ST;
 		} else {
 			pr_warning("Voltage processor%d does not exisit\
 					in OMAP3 \n", vp_id);
@@ -360,6 +369,127 @@ static void __init vp_reg_configure(int vp_id)
 	/* TODO Extend this for OMAP4 ?? Or need a separate file  */
 }
 
+/* VP force update method of voltage scaling */
+static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt,
+						unsigned long current_volt)
+{
+	u32 smps_steps = 0, smps_delay = 0;
+	u32 vpconfig;
+	int timeout = 0;
+	int vp_id = vdd - 1;
+	u8 target_vsel, current_vsel;
+
+	if (!((vdd == VDD1_OPP) || (vdd == VDD2_OPP))) {
+		pr_warning("Wrong vdd id passed to vp forceupdate\n");
+		return false;
+	}
+
+	target_vsel = omap_twl_uv_to_vsel(target_volt);
+	current_vsel = omap_twl_uv_to_vsel(current_volt);
+	smps_steps = abs(target_vsel - current_vsel);
+
+	if (vdd == VDD1_OPP) {
+		u32 vc_cmdval0;
+
+		vc_cmdval0 = voltage_read_reg(vc_reg.cmdval0_reg);
+		vc_cmdval0 &= ~VC_CMD_ON_MASK;
+		vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
+		voltage_write_reg(vc_reg.cmdval0_reg, vc_cmdval0);
+	} else if (vdd == VDD2_OPP) {
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
+		voltage_write_reg(PRM_IRQSTATUS_REG,
+				vp_reg[vp_id].vp_tranxdone_status);
+		if (!(voltage_read_reg(PRM_IRQSTATUS_REG) &
+				vp_reg[vp_id].vp_tranxdone_status))
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
+	if (cpu_is_omap34xx())
+		vp_reg[vp_id].vp_errorgain = (omap3_get_vp_errorgain((vp_id),
+			target_volt) << OMAP3430_ERRORGAIN_SHIFT);
+
+	/* Configure for VP-Force Update */
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
+	vpconfig &= ~(VP_CONFIG_INITVDD | VP_FORCEUPDATE |
+			VP_INITVOLTAGE_MASK | VP_ERRORGAIN_MASK);
+	vpconfig |= ((target_vsel << VP_INITVOLTAGE_SHIFT) |
+			vp_reg[vp_id].vp_errorgain);
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	/* Trigger initVDD value copy to voltage processor */
+	vpconfig |= VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	/* Force update of voltage */
+	vpconfig |= VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	timeout = 0;
+	/*
+	 * Wait for TransactionDone. Typical latency is <200us.
+	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
+	 */
+	omap_test_timeout((voltage_read_reg(PRM_IRQSTATUS_REG) &
+			vp_reg[vp_id].vp_tranxdone_status),
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
+		voltage_write_reg(PRM_IRQSTATUS_REG,
+				vp_reg[vp_id].vp_tranxdone_status);
+		if (!(voltage_read_reg(PRM_IRQSTATUS_REG) &
+				vp_reg[vp_id].vp_tranxdone_status))
+				break;
+		udelay(1);
+	}
+	if (timeout >= VP_TRANXDONE_TIMEOUT)
+		pr_warning("VP%d TRANXDONE timeout exceeded while trying to \
+			clear the TRANXDONE status\n", vdd);
+
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
+	/* Clear initVDD copy trigger bit */
+	vpconfig &= ~VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+	/* Clear force bit */
+	vpconfig &= ~VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	return true;
+}
+
 /**
  * vc_bypass_scale_voltage - VC bypass method of voltage scaling
  */
@@ -447,7 +577,6 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 	return true;
 }
 
-
 static void __init init_voltageprocessors(void)
 {
 	int i;
@@ -537,9 +666,11 @@ void omap_voltageprocessor_enable(int vp_id)
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
 	 */
-	vp_latch_vsel(vp_id - 1);
-	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
+	if (!voltscale_vpforceupdate)
+		vp_latch_vsel(vp_id - 1);
+
 	/* Enable VP */
+	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
 	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg,
 				vpconfig | VP_CONFIG_VPENABLE);
 }
@@ -589,11 +720,12 @@ void omap_voltageprocessor_disable(int vp_id)
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
@@ -629,6 +761,29 @@ void omap_reset_voltage(int vdd)
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
index 88d9b07..a350444 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -14,7 +14,10 @@
 #define VP1	0
 #define VP2	1
 
+#define VOLTSCALE_VPFORCEUPDATE		1
+#define VOLTSCALE_VCBYPASS		2
 
+#define PRM_IRQSTATUS_REG	OMAP3430_PRM_IRQSTATUS_MPU
 /* Generic VP definitions. Need to be redefined for OMAP4 */
 #define VP_CONFIG_TIMEOUTEN	OMAP3430_TIMEOUTEN
 #define VP_CONFIG_INITVDD	OMAP3430_INITVDD
-- 
1.7.0.rc1.33.g07cf0f

