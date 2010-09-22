From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Wed, 22 Sep 2010 20:15:16 +0530
Message-ID: <1285166719-19352-9-git-send-email-thara@ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364Ab0IVOpu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:45:50 -0400
In-Reply-To: <1285166719-19352-1-git-send-email-thara@ti.com>
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
	/pm_debug/voltage/vdd_<x>/<parameter>
and the smartreflex parameters can be viewed at
	/pm_debug/smartreflex/sr_<x>/<parameter>

where <x> is mpu or core for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c                |   15 ++
 arch/arm/mach-omap2/smartreflex.c             |   40 +++++-
 arch/arm/mach-omap2/voltage.c                 |  210 ++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/smartreflex.h |    1 -
 arch/arm/plat-omap/include/plat/voltage.h     |    5 +
 5 files changed, 264 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 390f1c6..879efb2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -32,6 +32,7 @@
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 #include <plat/dmtimer.h>
+#include <plat/voltage.h>
 
 #include "prm.h"
 #include "cm.h"
@@ -586,6 +587,18 @@ static int option_set(void *data, u64 val)
 			omap3_pm_off_mode_enable(val);
 	}
 
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
+
+
 	return 0;
 }
 
@@ -642,6 +655,8 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("wakeup_timer_milliseconds",
 			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
 			&pm_dbg_option_fops);
+	(void) debugfs_create_file("enable_sr_vp_debug",  S_IRUGO | S_IWUGO, d,
+				&enable_sr_vp_debug, &pm_dbg_option_fops);
 
 	pm_dbg_main_dir = d;
 	pm_dbg_init_done = 1;
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7fc3138..b5a7878 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -558,8 +558,13 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
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
 	if (!sr->sr_enable) {
@@ -811,9 +816,34 @@ static int omap_sr_autocomp_store(void *data, u64 val)
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
+		pr_notice("%s: DEBUG option not enabled!\n	\
+			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n",
+			__func__);
+	}
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 		omap_sr_autocomp_store, "%llu\n");
 
+DEFINE_SIMPLE_ATTRIBUTE(sr_params_fops, omap_sr_params_show,
+		omap_sr_params_store, "%llu\n");
+
 static int __init omap_smartreflex_probe(struct platform_device *pdev)
 {
 	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
@@ -907,6 +937,12 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
 				(void *)sr_info, &pm_sr_fops);
+	(void) debugfs_create_file("errweight", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_weight, &sr_params_fops);
+	(void) debugfs_create_file("errmaxlimit", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_maxlimit, &sr_params_fops);
+	(void) debugfs_create_file("errminlimit", S_IRUGO | S_IWUGO, dbg_dir,
+			&sr_info->err_minlimit, &sr_params_fops);
 
 	return ret;
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 49013cb..70a645e 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -22,15 +22,22 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
 
 #include <plat/common.h>
 #include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
+#include "pm.h"
 
 #define VP_IDLE_TIMEOUT		200
 #define VP_TRANXDONE_TIMEOUT	300
+#define VOLTAGE_DIR_SIZE	16
 
+static struct dentry *voltage_dir;
+/* VP SR debug support */
+u32 enable_sr_vp_debug;
 /* PRM voltage module */
 static u32 volt_mod;
 
@@ -221,6 +228,82 @@ static inline void voltage_write_reg(u8 offset, u32 value)
 	prm_write_mod_reg(value, volt_mod, offset);
 }
 
+/* Voltage debugfs support */
+static int vp_debug_get(void *data, u64 *val)
+{
+	u16 *option = data;
+
+	if (!option) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = *option;
+
+	return 0;
+}
+
+static int vp_debug_set(void *data, u64 val)
+{
+	if (enable_sr_vp_debug) {
+		u32 *option = data;
+
+		if (!option) {
+			pr_warning("Wrong paramater passed\n");
+			return -EINVAL;
+		}
+
+		*option = val;
+	} else {
+		pr_notice("DEBUG option not enabled!"
+			"echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
+	}
+
+	return 0;
+}
+
+static int vp_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+	u8 vsel;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	vsel = voltage_read_reg(vdd->vp_offs.voltage);
+	pr_notice("curr_vsel = %x\n", vsel);
+
+	if (!volt_pmic_info.vsel_to_uv) {
+		pr_warning("PMIC function to convert vsel to voltage"
+			"in uV not registerd\n");
+		return -EINVAL;
+	}
+
+	*val = volt_pmic_info.vsel_to_uv(vsel);
+	return 0;
+}
+
+static int nom_volt_debug_get(void *data, u64 *val)
+{
+	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
+
+	if (!vdd) {
+		pr_warning("Wrong paramater passed\n");
+		return -EINVAL;
+	}
+
+	*val = omap_voltage_get_nom_volt(&vdd->voltdm);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vp_debug_fops, vp_debug_get, vp_debug_set, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
+								"%llu\n");
+
 static void vp_latch_vsel(struct omap_vdd_info *vdd)
 {
 	u32 vpconfig;
@@ -457,6 +540,61 @@ static void __init vdd_data_configure(struct omap_vdd_info *vdd)
 		omap3_vdd_data_configure(vdd);
 }
 
+static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
+{
+	struct dentry *vdd_debug;
+	char *name;
+
+	name = kzalloc(VOLTAGE_DIR_SIZE, GFP_KERNEL);
+	if (!name) {
+		pr_warning("%s: Unable to allocate memry for debugfs"
+			"directory name for vdd_%s",
+			__func__, vdd->voltdm.name);
+		return;
+	}
+	strcpy(name, "vdd_");
+	strcat(name, vdd->voltdm.name);
+
+	vdd_debug = debugfs_create_dir(name, voltage_dir);
+	if (IS_ERR(vdd_debug)) {
+		pr_warning("%s: Unable to create debugfs directory for"
+			"vdd_%s\n", __func__, vdd->voltdm.name);
+		return;
+	}
+
+	(void) debugfs_create_file("vp_errorgain", S_IRUGO | S_IWUGO,
+				vdd_debug,
+				&(vdd->vp_reg.vpconfig_errorgain),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemin", S_IRUGO | S_IWUGO,
+				vdd_debug,
+				&(vdd->vp_reg.vstepmin_smpswaittimemin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmin", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd->vp_reg.vstepmin_stepmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_smpswaittimemax", S_IRUGO | S_IWUGO,
+				vdd_debug,
+				&(vdd->vp_reg.vstepmax_smpswaittimemax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_stepmax", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd->vp_reg.vstepmax_stepmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmax", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd->vp_reg.vlimitto_vddmax),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_vddmin", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd->vp_reg.vlimitto_vddmin),
+				&vp_debug_fops);
+	(void) debugfs_create_file("vp_timeout", S_IRUGO | S_IWUGO, vdd_debug,
+				&(vdd->vp_reg.vlimitto_timeout),
+				&vp_debug_fops);
+	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd_debug,
+				(void *) vdd, &vp_volt_debug_fops);
+	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO, vdd_debug,
+				(void *) vdd, &nom_volt_debug_fops);
+}
+
 static void __init init_voltagecontroller(void)
 {
 	if (cpu_is_omap34xx())
@@ -524,8 +662,11 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
 
-	/* Setting vp errorgain based on the voltage */
-	if (volt_data) {
+	/*
+	 * Setting vp errorgain based on the voltage. If the debug option is
+	 * enabled allow the override of errorgain from user side
+	 */
+	if (!enable_sr_vp_debug && volt_data) {
 		vp_errgain_val = voltage_read_reg(vdd->vp_offs.vpconfig);
 		vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
 		vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
@@ -630,8 +771,11 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
 	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
 	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
 
-	/* Getting  vp errorgain based on the voltage */
-	if (volt_data)
+	/*
+	 * Getting  vp errorgain based on the voltage. If the debug option is
+	 * enabled allow the override of errorgain from user side.
+	 */
+	if (!enable_sr_vp_debug && volt_data)
 		vdd->vp_reg.vpconfig_errorgain =
 					volt_data->vp_errgain;
 
@@ -806,6 +950,37 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	if (!voltscale_vpforceupdate)
 		vp_latch_vsel(vdd);
 
+	/*
+	 * If debug is enabled, it is likely that the following parameters
+	 * were set from user space so rewrite them.
+	 */
+	if (enable_sr_vp_debug) {
+		vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
+		vpconfig |= (vdd->vp_reg.vpconfig_errorgain <<
+			vdd->vp_reg.vpconfig_errorgain_shift);
+		voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
+
+		voltage_write_reg(vdd->vp_offs.vstepmin,
+			(vdd->vp_reg.vstepmin_smpswaittimemin <<
+			vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
+			(vdd->vp_reg.vstepmin_stepmin <<
+			vdd->vp_reg.vstepmin_stepmin_shift));
+
+		voltage_write_reg(vdd->vp_offs.vstepmax,
+			(vdd->vp_reg.vstepmax_smpswaittimemax <<
+			vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
+			(vdd->vp_reg.vstepmax_stepmax <<
+			vdd->vp_reg.vstepmax_stepmax_shift));
+
+		voltage_write_reg(vdd->vp_offs.vlimitto,
+			(vdd->vp_reg.vlimitto_vddmax <<
+			vdd->vp_reg.vlimitto_vddmax_shift) |
+			(vdd->vp_reg.vlimitto_vddmin <<
+			vdd->vp_reg.vlimitto_vddmin_shift) |
+			(vdd->vp_reg.vlimitto_timeout <<
+			vdd->vp_reg.vlimitto_timeout_shift));
+	}
+
 	/* Enable VP */
 	vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
 	voltage_write_reg(vdd->vp_offs.vpconfig,
@@ -1107,6 +1282,7 @@ static int __init omap_voltage_init(void)
 		return 0;
 	}
 
+
 	init_voltagecontroller();
 	for (i = 0; i < nr_scalable_vdd; i++) {
 		vdd_data_configure(&vdd_info[i]);
@@ -1115,3 +1291,29 @@ static int __init omap_voltage_init(void)
 	return 0;
 }
 core_initcall(omap_voltage_init);
+
+static int __init omap_voltage_debugfs_init(void)
+{
+	int i;
+
+	/*
+	 * If pm debug main directory is not created,
+	 * do not create rest of the debugfs entries.
+	 */
+	if (!pm_dbg_main_dir)
+		return 0;
+
+	voltage_dir = debugfs_create_dir("voltage", pm_dbg_main_dir);
+	if (IS_ERR(voltage_dir)) {
+		pr_err("%s: Unable to create voltage debugfs main dir\n",
+			__func__);
+		return 0;
+	}
+
+	for (i = 0; i < nr_scalable_vdd; i++)
+		vdd_debugfs_init(&vdd_info[i]);
+
+	return 0;
+}
+
+late_initcall(omap_voltage_debugfs_init);
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
index 1ad03ea..4ee548d 100644
--- a/arch/arm/plat-omap/include/plat/smartreflex.h
+++ b/arch/arm/plat-omap/include/plat/smartreflex.h
@@ -24,7 +24,6 @@
 #include <plat/voltage.h>
 
 #ifdef CONFIG_PM_DEBUG
-extern struct dentry *pm_dbg_main_dir;
 extern struct dentry *sr_dbg_dir;
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 99836a1..8978d33 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -14,6 +14,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 
+extern u32 enable_sr_vp_debug;
+#ifdef CONFIG_PM_DEBUG
+extern struct dentry *pm_dbg_main_dir;
+#endif
+
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
 
-- 
1.7.1.GIT

