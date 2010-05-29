From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 8/8] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Sat, 29 May 2010 22:02:28 +0530
Message-ID: <1275150748-15386-9-git-send-email-thara@ti.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
 <1275150748-15386-2-git-send-email-thara@ti.com>
 <1275150748-15386-3-git-send-email-thara@ti.com>
 <1275150748-15386-4-git-send-email-thara@ti.com>
 <1275150748-15386-5-git-send-email-thara@ti.com>
 <1275150748-15386-6-git-send-email-thara@ti.com>
 <1275150748-15386-7-git-send-email-thara@ti.com>
 <1275150748-15386-8-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38808 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757388Ab0E2Qcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:32:39 -0400
In-Reply-To: <1275150748-15386-8-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds debug support to the voltage and smartreflex drivers.
This means a whole bunch of voltage processor and smartreflex
parameters are now visible through the pm debugfs. By default
only a read of these parameters are permitted. If you need to
write into them then
	echo 1 > /pm_debug/enable_sr_vp_debug

The voltage parameters can be viewed at
	/pm_debug/Voltage/VDD<X>/<parameter>
and the smartreflex parameters can be viewed at
	/pm_debug/Smartreflex/SR<X>/<parameter>

where <X> is 1 or 2 for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c                |   13 ++
 arch/arm/mach-omap2/smartreflex.c             |   39 ++++++-
 arch/arm/mach-omap2/voltage.c                 |  148 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/voltage.h                 |    3 +
 arch/arm/plat-omap/include/plat/smartreflex.h |    2 -
 5 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index b239c16..fbba94b 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -35,6 +35,7 @@
 #include "prm.h"
 #include "cm.h"
 #include "pm.h"
+#include "voltage.h"
 
 int omap2_pm_debug;
 
@@ -552,6 +553,16 @@ static int option_set(void *data, u64 val)
 
 	if (option == &enable_off_mode)
 		omap3_pm_off_mode_enable(val);
+	if (option == &enable_sr_vp_debug && val)
+		pr_notice("Beware that enabling this option will allow user "
+			"to override the system defined vp and sr parameters "
+			"All the updated parameters will take effect next "
+			"time smartreflex is enabled. Also this option "
+			"disables the automatic vp errorgain and sr errormin "
+			"limit changes as per the voltage. Users will have "
+			"to explicitly write values into the debug fs "
+			"entries corresponding to these if they want to see "
+			"them changing according to the VDD voltage\n");
 
 	return 0;
 }
@@ -606,6 +617,8 @@ static int __init pm_dbg_init(void)
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+	(void) debugfs_create_file("enable_sr_vp_debug",  S_IRUGO | S_IWUGO, d,
+				   &enable_sr_vp_debug, &pm_dbg_option_fops);
 	pm_dbg_main_dir = d;
 	pm_dbg_init_done = 1;
 
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 74b7c0c..57fc9b2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -529,8 +529,13 @@ int sr_enable(int srid, unsigned long volt)
 		return -ENODATA;
 	}
 
-	/* errminlimit is opp dependent and hence linked to voltage */
-	sr->err_minlimit = volt_data->sr_errminlimit;
+	/*
+	 * errminlimit is opp dependent and hence linked to voltage
+	 * if the debug option is enabled, the user might have over ridden
+	 * this parameter so do not get it from voltage table
+	 */
+	if (!enable_sr_vp_debug)
+		sr->err_minlimit = volt_data->sr_errminlimit;
 
 	/* Enable the clocks */
 	if (!sr->is_sr_enable) {
@@ -785,8 +790,31 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	return 0;
 }
 
+static int omap_sr_params_show(void *data, u64 *val)
+{
+	u32 *param = data;
+
+	*val = *param;
+	return 0;
+}
+
+static int omap_sr_params_store(void *data, u64 val)
+{
+	if (enable_sr_vp_debug) {
+		u32 *option = data;
+		*option = val;
+	} else {
+		pr_notice("DEBUG option not enabled!\n	\
+			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
+	}
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 		omap_sr_autocomp_store, "%llu\n");
+
+DEFINE_SIMPLE_ATTRIBUTE(sr_params_fops, omap_sr_params_show,
+		omap_sr_params_store, "%llu\n");
 #endif
 
 static int __init omap_smartreflex_probe(struct platform_device *pdev)
@@ -849,6 +877,13 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
 	dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
 				(void *)sr_info, &pm_sr_fops);
+	(void) debugfs_create_file("errweight", S_IRUGO | S_IWUGO, dbg_dir,
+				&sr_info->err_weight, &sr_params_fops);
+	(void) debugfs_create_file("errmaxlimit", S_IRUGO | S_IWUGO, dbg_dir,
+				&sr_info->err_maxlimit, &sr_params_fops);
+	(void) debugfs_create_file("errminlimit", S_IRUGO | S_IWUGO, dbg_dir,
+				&sr_info->err_minlimit, &sr_params_fops);
+
 #endif
 
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 657e322..e3d641d 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/debugfs.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap34xx.h>
@@ -37,6 +38,13 @@
 #define VP_IDLE_TIMEOUT		200
 #define VP_TRANXDONE_TIMEOUT	300
 
+#ifdef CONFIG_PM_DEBUG
+struct dentry *voltage_dir;
+#endif
+
+/* VP SR debug support */
+u32 enable_sr_vp_debug;
+
 /* PRM voltage module */
 u32 volt_mod;
 
@@ -107,6 +115,7 @@ struct omap_vdd_info{
 	struct clk *volt_clk;
 	int opp_type;
 	int volt_data_count;
+	int id;
 	unsigned long nominal_volt;
 	u8 cmdval_reg;
 	u8 vdd_sr_reg;
@@ -228,6 +237,54 @@ static int check_voltage_domain(int vdd)
 	return -EINVAL;
 }
 
+/* Voltage debugfs support */
+#ifdef CONFIG_PM_DEBUG
+static int vp_debug_get(void *data, u64 *val)
+{
+	u16 *option = data;
+
+	*val = *option;
+	return 0;
+}
+
+static int vp_debug_set(void *data, u64 val)
+{
+	if (enable_sr_vp_debug) {
+		u32 *option = data;
+		*option = val;
+	} else {
+		pr_notice("DEBUG option not enabled!\n	\
+			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
+	}
+	return 0;
+}
+
+static int vp_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *info = (struct omap_vdd_info *) data;
+	u8 vsel;
+
+	vsel = voltage_read_reg(info->vp_offs.voltage_reg);
+	pr_notice("curr_vsel = %x\n", vsel);
+	*val = vsel * 12500 + 600000;
+
+	return 0;
+}
+
+static int nom_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *info = (struct omap_vdd_info *) data;
+
+	*val = get_curr_voltage(info->id);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vp_debug_fops, vp_debug_get, vp_debug_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
+								"%llu\n");
+#endif
+
 static void vp_latch_vsel(int vp_id)
 {
 	u32 vpconfig;
@@ -481,8 +538,49 @@ static void __init init_voltageprocesor(int vp_id)
 
 static void __init vdd_data_configure(int vdd)
 {
+#ifdef CONFIG_PM_DEBUG
+	struct dentry *vdd_debug;
+	char name[5];
+#endif
+	vdd_info[vdd].id = vdd;
 	if (cpu_is_omap34xx())
 		omap3_vdd_data_configure(vdd);
+
+#ifdef CONFIG_PM_DEBUG
+	sprintf(name, "VDD%d", vdd + 1);
+	vdd_debug = debugfs_create_dir(name, voltage_dir);
+	(void) debugfs_create_file("vp_errorgain", S_IRUGO | S_IWUGO,
+				vdd_debug,
+				&(vdd_info[vdd].vp_reg.vpconfig_errorgain),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemin", S_IRUGO | S_IWUGO,
+				vdd_debug, &(vdd_info[vdd].vp_reg.
+				vstepmin_smpswaittimemin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmin", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd_info[vdd].vp_reg.vstepmin_stepmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemax", S_IRUGO | S_IWUGO,
+				vdd_debug, &(vdd_info[vdd].vp_reg.
+				vstepmax_smpswaittimemax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmax", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd_info[vdd].vp_reg.vstepmax_stepmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmax", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd_info[vdd].vp_reg.vlimitto_vddmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmin", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd_info[vdd].vp_reg.vlimitto_vddmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_timeout", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd_info[vdd].vp_reg.vlimitto_timeout),
+				&vp_debug_fops);
+	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd_debug,
+				(void *) &vdd_info[vdd], &vp_volt_debug_fops);
+	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO, vdd_debug,
+				(void *) &vdd_info[vdd], &nom_volt_debug_fops);
+#endif
 }
 static void __init init_voltagecontroller(void)
 {
@@ -541,8 +639,11 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt)
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd_info[vdd].cmdval_reg, vc_cmdval);
 
-	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
+	/*
+	 * Setting vp errorgain based on the voltage If the debug option is
+	 * enabled allow the override of errorgain from user side
+	 */
+	if (!enable_sr_vp_debug && volt_data) {
 		vp_errgain_val = voltage_read_reg(vdd_info[vdd].
 				vp_offs.vpconfig_reg);
 		vdd_info[vdd].vp_reg.vpconfig_errorgain =
@@ -629,8 +730,11 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd_info[vdd].cmdval_reg, vc_cmdval);
 
-	/* Getting  vp errorgain based on the voltage */
-	if (volt_data)
+	/*
+	 * Getting  vp errorgain based on the voltage If the debug option is
+	 * enabled allow the override of errorgain from user side.
+	 */
+	if (!enable_sr_vp_debug && volt_data)
 		vdd_info[vdd].vp_reg.vpconfig_errorgain =
 					volt_data->vp_errgain;
 	/*
@@ -799,6 +903,39 @@ void omap_voltageprocessor_enable(int vp_id)
 	if (!voltscale_vpforceupdate)
 		vp_latch_vsel(vp_id);
 
+	/*
+	 * If debug is enabled, it is likely that the following parameters
+	 * were set from user space so rewrite them.
+	 */
+	if (enable_sr_vp_debug) {
+		vpconfig = voltage_read_reg(
+			vdd_info[vp_id].vp_offs.vpconfig_reg);
+		vpconfig |= (vdd_info[vp_id].vp_reg.vpconfig_errorgain <<
+			vdd_info[vp_id].vp_reg.vpconfig_errorgain_shift);
+		voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
+			vpconfig);
+
+		voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmin_reg,
+			(vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin <<
+			vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin_shift) |
+			(vdd_info[vp_id].vp_reg.vstepmin_stepmin <<
+			vdd_info[vp_id].vp_reg.vstepmin_stepmin_shift));
+
+		voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmax_reg,
+			(vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax <<
+			vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax_shift) |
+			(vdd_info[vp_id].vp_reg.vstepmax_stepmax <<
+			vdd_info[vp_id].vp_reg.vstepmax_stepmax_shift));
+
+		voltage_write_reg(vdd_info[vp_id].vp_offs.vlimitto_reg,
+			(vdd_info[vp_id].vp_reg.vlimitto_vddmax <<
+			vdd_info[vp_id].vp_reg.vlimitto_vddmax_shift) |
+			(vdd_info[vp_id].vp_reg.vlimitto_vddmin <<
+			vdd_info[vp_id].vp_reg.vlimitto_vddmin_shift) |
+			(vdd_info[vp_id].vp_reg.vlimitto_timeout <<
+			vdd_info[vp_id].vp_reg.vlimitto_timeout_shift));
+	}
+
 	vpconfig = voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg);
 	/* Enable VP */
 	voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
@@ -1044,6 +1181,9 @@ static int __init omap_voltage_init(void)
 		return 0;
 	}
 
+#ifdef CONFIG_PM_DEBUG
+	voltage_dir = debugfs_create_dir("Voltage", pm_dbg_main_dir);
+#endif
 	if (cpu_is_omap34xx()) {
 		volt_mod = OMAP3430_GR_MOD;
 		vdd_info = omap3_vdd_info;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index f2796b2..a7be515 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -14,6 +14,9 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 
+extern u32 enable_sr_vp_debug;
+extern struct dentry *pm_dbg_main_dir;
+
 /* VoltageDomain instances */
 #define VDD1	0
 #define VDD2	1
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
index 2225f27..1105db0 100644
--- a/arch/arm/plat-omap/include/plat/smartreflex.h
+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
@@ -22,8 +22,6 @@
 
 #include <linux/platform_device.h>
 
-extern struct dentry *pm_dbg_main_dir;
-
 /*
  * Different Smartreflex IPs version. The v1 is the 65nm version used in
  * OMAP3430. The v2 is the update for the 45nm version of the IP
-- 
1.7.0.rc1.33.g07cf0f

