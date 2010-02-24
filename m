From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 15/16] OMAP3: PM: VP force update method of voltage scaling
Date: Wed, 24 Feb 2010 14:59:16 +0530
Message-ID: <1267003757-22456-16-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
 <1267003757-22456-9-git-send-email-thara@ti.com>
 <1267003757-22456-10-git-send-email-thara@ti.com>
 <1267003757-22456-11-git-send-email-thara@ti.com>
 <1267003757-22456-12-git-send-email-thara@ti.com>
 <1267003757-22456-13-git-send-email-thara@ti.com>
 <1267003757-22456-14-git-send-email-thara@ti.com>
 <1267003757-22456-15-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51630 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926Ab0BXJ3f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:35 -0500
In-Reply-To: <1267003757-22456-15-git-send-email-thara@ti.com>
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
 arch/arm/mach-omap2/voltage.c |  149 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/voltage.h |    1 +
 arch/arm/plat-omap/Kconfig    |   19 +++++
 3 files changed, 162 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 49167c0..4f325af 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -29,7 +29,8 @@
 #include "prm-regbits-34xx.h"
 #include "voltage.h"
 
-#define VP_IDLE_TIMEOUT 200
+#define VP_IDLE_TIMEOUT 	200
+#define VP_TRANXDONE_TIMEOUT	300
 
 /*
  * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
@@ -70,6 +71,7 @@ struct vp_reg_info {
 	u32 vp_vddmin;
 	u32 vp_vddmax;
 	u32 vp_timeout;
+	u32 vp_tranxdone_status;
 };
 static struct vp_reg_info *vp_reg;
 /*
@@ -299,6 +301,8 @@ static void __init vp_reg_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP1_TRANXDONE_ST;
 		} else if (vp_id == VP2) {
 			/*
 			 * OMAP3430 has error gain varying btw higher and
@@ -312,6 +316,8 @@ static void __init vp_reg_configure(int vp_id)
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
+			vp_reg[vp_id].vp_tranxdone_status =
+					OMAP3430_VP2_TRANXDONE_ST;
 		} else {
 			pr_warning("Voltage processor%d does not exisit\
 					in OMAP3 \n", vp_id);
@@ -346,6 +352,131 @@ static void __init vp_reg_configure(int vp_id)
 	/* TODO Extend this for OMAP4 ?? Or need a separate file  */
 }
 
+#ifdef CONFIG_OMAP_VOLT_VPFORCEUPDATE
+/* VP force update method of voltage scaling */
+static int vp_forceupdate_scale_voltage(u32 vdd, u8 target_vsel,
+				u8 current_vsel)
+{
+	u32 smps_steps = 0, smps_delay = 0;
+	u32 vpconfig;
+	int timeout = 0;
+	int vp_id = vdd - 1;
+
+	if (!((vdd == VDD1_OPP) || (vdd == VDD2_OPP))) {
+		pr_warning("Wrong vdd id passed to vp forceupdate\n");
+		return false;
+	}
+
+	smps_steps = abs(target_vsel - current_vsel);
+
+	/* OMAP3430 has errorgain varying btw higher and lower opp's */
+	if (cpu_is_omap34xx()) {
+		if (vdd == VDD1_OPP) {
+			u32 vc_cmdval0;
+
+			vc_cmdval0 = voltage_read_reg(vc_reg.vc_cmdval0_reg);
+			vc_cmdval0 &= ~VC_CMD_ON_MASK;
+			vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
+			voltage_write_reg(vc_reg.vc_cmdval0_reg, vc_cmdval0);
+			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
+		} else if (vdd == VDD2_OPP) {
+			u32 vc_cmdval1;
+
+			vc_cmdval1 = voltage_read_reg(vc_reg.vc_cmdval1_reg);
+			vc_cmdval1 &= ~VC_CMD_ON_MASK;
+			vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
+			voltage_write_reg(vc_reg.vc_cmdval1_reg, vc_cmdval1);
+			vp_reg[vp_id].vp_errorgain = (((get_vdd2_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
+		}
+	}
+
+	/* Clear all pending TransactionDone interrupt/status. Typical latency
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
+	/* Configure for VP-Force Update */
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg);
+	vpconfig &= ~(VP_CONFIG_INITVDD | VP_FORCEUPDATE |
+			VP_INITVOLTAGE_MASK | VP_ERRORGAIN_MASK);
+	vpconfig |= ((target_vsel << VP_INITVOLTAGE_SHIFT) |
+			vp_reg[vp_id].vp_errorgain);
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, vpconfig);
+
+	/* Trigger initVDD value copy to voltage processor */
+	vpconfig |= VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, vpconfig);
+
+	/* Force update of voltage */
+	vpconfig |= VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, vpconfig);
+
+	timeout = 0;
+	/* Wait for TransactionDone. Typical latency is <200us.
+	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
+	 */
+	while ((timeout++ < VP_TRANXDONE_TIMEOUT) &&
+			(!(voltage_read_reg(PRM_IRQSTATUS_REG) &
+			vp_reg[vp_id].vp_tranxdone_status)))
+		udelay(1);
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
+	/* Disable TransactionDone interrupt , clear all status, clear
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
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg);
+	/* Clear initVDD copy trigger bit */
+	vpconfig &= ~VP_CONFIG_INITVDD;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, vpconfig);
+	/* Clear force bit */
+	vpconfig &= ~VP_FORCEUPDATE;
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vp_vpconfig_reg, vpconfig);
+
+	return true;
+}
+#endif
+
+#ifdef CONFIG_OMAP_VOLT_VCBYPASS
 /**
  * vc_bypass_scale_voltage - VC bypass method of voltage scaling
  */
@@ -437,7 +568,7 @@ static int vc_bypass_scale_voltage(u32 vdd, u8 target_vsel, u8 current_vsel)
 	udelay(smps_delay);
 	return true;
 }
-
+#endif
 
 static void __init init_voltageprocessors(void)
 {
@@ -474,13 +605,16 @@ void omap_voltageprocessor_enable(int vp_id)
 	if (voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg) &
 				VP_CONFIG_VPENABLE)
 		return;
+
+#ifdef CONFIG_OMAP_VOLT_VCBYPASS
 	/*
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
 	 */
 	vp_latch_vsel(vp_id - 1);
-	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg);
+#endif
 	/* Enable VP */
+	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg);
 	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg,
 				vpconfig | VP_CONFIG_VPENABLE);
 }
@@ -529,11 +663,12 @@ void omap_voltageprocessor_disable(int vp_id)
  * for a particular voltage domain during dvfs or any other situation.
  */
 int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel)
-{	/*
-	 * TODO add VP force update method of voltage scaling
-	 * and choose btw the two
-	 */
+{
+#ifdef CONFIG_OMAP_VOLT_VCBYPASS
 	return vc_bypass_scale_voltage(vdd, target_vsel, current_vsel);
+#elif CONFIG_OMAP_VOLT_VPFORCEUPDATE
+	return vp_forceupdate_scale_voltage(vdd, target_vsel, current_vsel);
+#endif
 }
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index c3203c9..615bde6 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -17,6 +17,7 @@
 extern int get_vdd1_opp(void);
 extern int get_vdd2_opp(void);
 
+#define PRM_IRQSTATUS_REG	OMAP3430_PRM_IRQSTATUS_MPU
 /* Generic VP definitions. Need to be redefined for OMAP4 */
 #define VP_CONFIG_TIMEOUTEN	OMAP3430_TIMEOUTEN
 #define VP_CONFIG_INITVDD	OMAP3430_INITVDD
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 9d286e6..1a611a9 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -92,6 +92,25 @@ config OMAP_SMARTREFLEX_TESTING
 
 	  WARNING: Enabling this option may cause your device to hang!
 
+choice
+	prompt "Choose Voltage Scale method"
+	depends on ARCH_OMAP3 && PM
+	default OMAP_VOLT_VPFORCEUPDATE
+
+config OMAP_VOLT_VPFORCEUPDATE
+	bool "Voltage scaling via VP force update method"
+	help
+	 Say Y if you want to enable VP force update method
+	 of voltage scaling. This is the h/w recomended way
+	 of voltage scaling in OMAP3.
+
+config OMAP_VOLT_VCBYPASS
+	bool "Voltage Scale via Voltage controller in bypass"
+	help
+	 Say Y if you want to enable VC Bypass method of voltage scaling.
+	 Not the default recommended method.
+endchoice
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
-- 
1.7.0.rc1.33.g07cf0f

