From: jean.pihet@newoldbits.com
Subject: [PATCH 26/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 16:06:10 +0100
Message-ID: <1321974370-25800-27-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64917 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304Ab1KVPHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:42 -0500
Received: by mail-ww0-f42.google.com with SMTP id 3so7366646wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:41 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

AVS is a power management technique which controls the operating
voltage of a device in order to optimize (i.e. reduce) its power
consumption. The voltage is adapted depending on static factors
(chip manufacturing process) and dynamic factors (temperature
depending performance).
AVS is also called SmartReflex on OMAP devices.

To that end, create the AVS framework in drivers/power/avs and
move the OMAP SmartReflex code to the new directory.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/Kconfig              |   57 ---
 arch/arm/mach-omap2/Makefile             |    3 -
 arch/arm/mach-omap2/smartreflex-class3.c |   64 ----
 arch/arm/mach-omap2/smartreflex-common.c |  543 ------------------------------
 arch/arm/mach-omap2/smartreflex.h        |  231 -------------
 arch/arm/mach-omap2/smartreflex_v1.c     |  183 ----------
 arch/arm/mach-omap2/smartreflex_v2.c     |  186 ----------
 drivers/power/Kconfig                    |    2 +
 drivers/power/Makefile                   |    2 +
 drivers/power/avs/Kconfig                |   56 +++
 drivers/power/avs/Makefile               |    4 +
 drivers/power/avs/smartreflex-class3.c   |   64 ++++
 drivers/power/avs/smartreflex-common.c   |  543 ++++++++++++++++++++++++++++++
 drivers/power/avs/smartreflex.h          |  231 +++++++++++++
 drivers/power/avs/smartreflex_v1.c       |  183 ++++++++++
 drivers/power/avs/smartreflex_v2.c       |  186 ++++++++++
 16 files changed, 1271 insertions(+), 1267 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex-common.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex.h
 delete mode 100644 arch/arm/mach-omap2/smartreflex_v1.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex_v2.c
 create mode 100644 drivers/power/avs/Kconfig
 create mode 100644 drivers/power/avs/Makefile
 create mode 100644 drivers/power/avs/smartreflex-class3.c
 create mode 100644 drivers/power/avs/smartreflex-common.c
 create mode 100644 drivers/power/avs/smartreflex.h
 create mode 100644 drivers/power/avs/smartreflex_v1.c
 create mode 100644 drivers/power/avs/smartreflex_v2.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3faf921..09ea525 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -370,61 +370,4 @@ config OMAP3_SDRC_AC_TIMING
 
 endmenu
 
-menuconfig POWER_AVS
-	tristate "Adaptive Voltage Scaling class support"
-	help
-	  AVS is a power management technique which controls the operating
-	  voltage of a device in order to optimize (i.e. reduce) its power
-	  consumption. The voltage is adapted depending on static factors
-	  (chip manufacturing process) and dynamic factors (temperature
-	  depending performance). AVS is also called SmartReflex on OMAP
-	  devices.
-
-	  Say Y here to enable Adaptive Voltage Scaling class support.
-
-if POWER_AVS
-
-config POWER_AVS_DEBUG
-	bool "Adaptive Voltage Scaling debug"
-	depends on DEBUG_FS
-	help
-	  Say Y here to enable debugfs entries for the AVS class and drivers.
-
-config POWER_AVS_OMAP_V1
-	tristate "AVS support for the OMAP IP version 1"
-	depends on ARCH_OMAP3 && PM
-	help
-	  Say Y to enable AVS support on OMAP containing the version 1 of
-	  the SmartReflex IP.
-	  V1 is the 65nm version used in OMAP3430.
-
-	  Please note, that by default SmartReflex is only
-	  initialized. To enable the automatic voltage
-	  compensation for vdd mpu  and vdd core from user space,
-	  user must write 1 to
-		/debug/voltage/vdd_<X>/smartreflex/autocomp,
-	  where X is mpu or core for OMAP3.
-	  Optionally autocompensation can be enabled in the kernel
-	  by default during system init via the enable_on_init flag
-	  which an be passed as platform data to the smartreflex driver.
-
-config POWER_AVS_OMAP_V2
-	tristate "AVS support for the OMAP IP version 2"
-	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
-	help
-	  Say Y to enable AVS support on OMAP containing the version 2 of
-	  the SmartReflex IP.
-	  V2 is the update for the 45nm version of the IP used in OMAP3630
-	  and OMAP4430
-
-config POWER_AVS_OMAP_CLASS3
-	bool "Class 3 mode of Smartreflex Implementation"
-	depends on (POWER_AVS_OMAP_V1 || POWER_AVS_OMAP_V2) && TWL4030_CORE
-	help
-	  Say Y to enable Class 3 implementation of Smartreflex
-	  Class 3 implementation of Smartreflex employs continuous hardware
-	  voltage calibration.
-
-endif # POWER_AVS
-
 endif
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6673ec5..74b4782 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -66,9 +66,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 obj-$(CONFIG_POWER_AVS)			+= sr_device.o
-obj-$(CONFIG_POWER_AVS_OMAP_V1)		+= smartreflex-common.o smartreflex_v1.o
-obj-$(CONFIG_POWER_AVS_OMAP_V2)		+= smartreflex-common.o smartreflex_v2.o
-obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
deleted file mode 100644
index 516901b..0000000
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Smart reflex Class 3 specific implementations
- *
- * Author: Thara Gopinath       <thara@ti.com>
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Thara Gopinath <thara@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include "smartreflex.h"
-
-static int sr_class3_enable(struct smartreflex *sr)
-{
-	unsigned long volt = voltdm_get_voltage(sr->voltdm);
-
-	if (!volt) {
-		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
-				__func__, sr->name);
-		return -ENODATA;
-	}
-
-	omap_vp_enable(sr->voltdm);
-	return sr_enable(sr, volt);
-}
-
-static int sr_class3_disable(struct smartreflex *sr, int is_volt_reset)
-{
-	omap_vp_disable(sr->voltdm);
-	sr_disable(sr);
-	if (is_volt_reset)
-		voltdm_reset(sr->voltdm);
-
-	return 0;
-}
-
-static int sr_class3_configure(struct smartreflex *sr)
-{
-	return sr_configure_errgen(sr);
-}
-
-/* SR class3 structure */
-static struct smartreflex_class_data class3_data = {
-	.enable = sr_class3_enable,
-	.disable = sr_class3_disable,
-	.configure = sr_class3_configure,
-	.class_type = SR_CLASS3,
-};
-
-/* Smartreflex Class3 init API to be called from board file */
-static int __init sr_class3_init(void)
-{
-	struct platform_device *pdev = NULL;
-	int ret = sr_register_class(pdev, &class3_data);
-
-	if (!ret)
-		pr_info("SmartReflex Class3 initialized\n");
-
-	return ret;
-}
-late_initcall(sr_class3_init);
diff --git a/arch/arm/mach-omap2/smartreflex-common.c b/arch/arm/mach-omap2/smartreflex-common.c
deleted file mode 100644
index d693195..0000000
--- a/arch/arm/mach-omap2/smartreflex-common.c
+++ /dev/null
@@ -1,543 +0,0 @@
-/*
- * Device driver for the SmartReflex IP blocks, common code
- *
- * Author: Thara Gopinath	<thara@ti.com>
- *
- * Copyright (C) 2007,2010 Texas Instruments, Inc.
- * Lesly A M <x0080970@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Copyright (C) 2008,2011 Nokia Corporation
- * Kalle Jokiniemi
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/debugfs.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/pm_runtime.h>
-
-#include <plat/common.h>
-#include <plat/smartreflex.h>
-
-#include "smartreflex.h"
-
-#define NVALUE_NAME_LEN		40
-
-/*
- * SR_CLK is the internal SmartReflex sensor sampling clock.  The OMAP34xx
- * TRM Rev ZH Section 4.10.5.4.3 "SmartReflex Submodules" states that this
- * should be 100KHz.
- */
-#define SR_CLK			100000 /* Hz */
-
-static struct dentry		*sr_dbg_dir;
-
-int sr_calculate_clk_length(struct smartreflex *sr)
-{
-	struct clk *fck;
-	int fck_rate, clk_length;
-
-	fck = clk_get(&sr->pdev->dev, "fck");
-	if (IS_ERR(fck)) {
-		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
-			__func__);
-		return 0;
-	}
-	fck_rate = clk_get_rate(fck);
-	clk_put(fck);
-
-	/*
-	 * This formula is from OMAP34xx TRM Rev ZH Section 4.10.5.4.3
-	 * "SmartReflex Submodules"
-	 */
-	clk_length = fck_rate / (2 * SR_CLK);
-
-	dev_dbg(&sr->pdev->dev, "%s: SRCLKLENGTH = %03x\n",
-		__func__, clk_length);
-
-	return clk_length;
-}
-
-static void sr_start_vddautocomp(struct smartreflex *sr)
-{
-	if (!sr->sr_class || !sr->sr_class->enable ||
-	    !sr->sr_class->configure) {
-		dev_warn(&sr->pdev->dev,
-			"%s: smartreflex class driver not registered\n",
-			__func__);
-		return;
-	}
-
-	if (!sr->sr_class->enable(sr))
-		sr->autocomp_active = true;
-}
-
-static void sr_stop_vddautocomp(struct smartreflex *sr)
-{
-	if (!sr->sr_class || !sr->sr_class->disable) {
-		dev_warn(&sr->pdev->dev,
-			"%s: smartreflex class driver not registered\n",
-			__func__);
-		return;
-	}
-
-	if (sr->autocomp_active) {
-		sr->sr_class->disable(sr, 1);
-		sr->autocomp_active = false;
-	}
-}
-
-static struct omap_sr_data_table *sr_retrieve_nvalue_row(
-				struct smartreflex *sr,
-				unsigned long volt_nominal)
-{
-	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
-	int i;
-
-	if (!sr->data_table) {
-		dev_warn(&sr->pdev->dev, "%s: Missing ntarget value table\n",
-			__func__);
-		return NULL;
-	}
-
-	for (i = 0; i < pdata->data_count; i++)
-		if (sr->data_table[i].volt_nominal == volt_nominal)
-			return &sr->data_table[i];
-
-	return NULL;
-}
-
-/**
- * sr_configure_errgen() - Configures the smrtreflex to perform AVS using the
- *			 error generator module.
- * @sr: struct smartreflex *
- *
- * This API is to be called from the smartreflex class driver to
- * configure the error generator module inside the smartreflex module.
- * SR settings if using the ERROR module inside Smartreflex.
- * SR CLASS 3 by default uses only the ERROR module where as
- * SR CLASS 2 can choose between ERROR module and MINMAXAVG
- * module. Returns 0 on success and error value in case of failure.
- */
-int sr_configure_errgen(struct smartreflex *sr)
-{
-	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
-	u32 sr_config, sr_errconfig;
-
-	if (IS_ERR_OR_NULL(sr))
-		return -EINVAL;
-
-	if (!sr_calculate_clk_length(sr))
-		return -EINVAL;
-
-	sr_config = sr->proto_sr_config;
-	sr_config |=  SRCONFIG_ERRGEN_EN;
-	sr_write_reg(sr, SRCONFIG, sr_config);
-
-	sr_errconfig = (pdata->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
-		(pdata->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
-		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
-	sr_modify_reg(sr, sr->errconfig_offs, (SR_ERRWEIGHT_MASK |
-		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
-		sr_errconfig);
-
-	/* Enabling the interrupts if the ERROR module is used */
-	sr_modify_reg(sr, sr->errconfig_offs,
-		sr->vpboundint_en, (sr->vpboundint_en | sr->vpboundint_st));
-
-	return 0;
-}
-
-static int sr_common_configure_minmax(struct smartreflex *sr)
-{
-	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
-	u32 sr_config, sr_avgwt;
-
-	sr_config = sr->proto_sr_config;
-	sr_config |= (pdata->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
-	sr_write_reg(sr, SRCONFIG, sr_config);
-
-	sr_avgwt = (pdata->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
-		(pdata->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
-	sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
-
-	return 0;
-}
-
-/**
- * sr_configure_minmax() - Configures the smrtreflex to perform AVS using the
- *  minmaxavg module.
- * @sr: struct smartreflex *
- *
- * This API is to be called from the smartreflex class driver to
- * configure the minmaxavg module inside the smartreflex module.
- * SR settings if using the ERROR module inside Smartreflex.
- * SR CLASS 3 by default uses only the ERROR module where as
- * SR CLASS 2 can choose between ERROR module and MINMAXAVG
- * module. Returns 0 on success and error value in case of failure.
- */
-int sr_configure_minmax(struct smartreflex *sr)
-{
-	int ret;
-
-	if (IS_ERR_OR_NULL(sr))
-		return -EINVAL;
-
-	ret = sr_common_configure_minmax(sr);
-	if (ret)
-		return ret;
-
-	return sr->configure_minmax(sr);
-}
-
-/**
- * sr_enable() - Enables the smartreflex module.
- * @sr: struct smartreflex *
- * @volt:	The voltage at which the Voltage domain associated with
- *		the smartreflex module is operating at.
- *		This is required only to program the correct Ntarget value.
- *
- * This API is to be called from the smartreflex class driver to
- * enable a smartreflex module. Returns 0 on success. Returns error
- * value if the voltage passed is wrong or if ntarget value is wrong.
- */
-int sr_enable(struct smartreflex *sr, unsigned long volt)
-{
-	struct omap_sr_data_table *nvalue_row;
-	int ret;
-
-	if (IS_ERR_OR_NULL(sr))
-		return -EINVAL;
-
-	/* Check if SR clocks are already enabled. If yes do nothing */
-	if (!pm_runtime_suspended(&sr->pdev->dev))
-		return 0;
-
-	nvalue_row = sr_retrieve_nvalue_row(sr, volt);
-	if (!nvalue_row) {
-		dev_warn(&sr->pdev->dev, "%s: failure getting SR data for "
-			 "this voltage %ld\n",__func__, volt);
-		return -ENODATA;
-	}
-
-	/* errminlimit is opp dependent and hence linked to voltage */
-	sr->err_minlimit = nvalue_row->errminlimit;
-
-	pm_runtime_get_sync(&sr->pdev->dev);
-
-	/* Check if SR is already enabled. If yes do nothing */
-	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
-		goto out;
-
-	/* Configure SR */
-	ret = sr->sr_class->configure(sr);
-	if (ret)
-		return ret;
-
-	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_row->nvalue);
-
-	/* SRCONFIG - enable SR */
-	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
-
-out:
-	pm_runtime_put_sync(&sr->pdev->dev);
-	return 0;
-}
-
-/**
- * sr_disable() - Disables the smartreflex module.
- * @sr: struct smartreflex *
- *
- * This API is to be called from the smartreflex class driver to
- * disable a smartreflex module.
- */
-void sr_disable(struct smartreflex *sr)
-{
-	if (IS_ERR_OR_NULL(sr))
-		return;
-
-	/* Check if SR clocks are already disabled. If yes do nothing */
-	if (pm_runtime_suspended(&sr->pdev->dev))
-		return;
-
-	/*
-	 * Disable SR if only it is indeed enabled. Else just
-	 * disable the clocks.
-	 */
-	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE) {
-		sr->disable(sr);
-	}
-
-	pm_runtime_put_sync_suspend(&sr->pdev->dev);
-}
-
-/**
- * sr_register_class() - API to register a smartreflex class parameters.
- * @class_data:	The structure containing various sr class specific data.
- *
- * XXX FIX THIS DOCUMENTATION
- *
- * This API is to be called by the smartreflex class driver to register itself
- * with the smartreflex driver during init. Returns 0 on success else the
- * error value.
- */
-int sr_register_class(struct platform_device *pdev, 
-		      struct smartreflex_class_data *class_data)
-{
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	struct smartreflex *sr;
-	int ret = 0;
-
-	if (!pdev || !class_data)
-		return -EINVAL;
-
-	sr = pdata->sr;
-	if (sr) {
-		dev_err(&pdev->dev, "%s: Smartreflex class driver already "
-				    "registered\n",
-		       __func__);
-		return -EBUSY; /* XXX -EEXIST seems better */
-	}
-
-	if (!sr->irq) {
-		dev_err(&pdev->dev, "%s: cannot register since class driver "
-				    "has an IRQ hook, but no SR IRQ "
-				    "specified\n", __func__);
-		ret = -EINVAL;
-		goto src_err;
-	}
-
-	sr->sr_class = class_data;
-
-	if (pdata->enable_on_init)
-		sr_start_vddautocomp(sr);
-
-src_err:
-	return ret;
-}
-
-#ifdef CONFIG_POWER_AVS_DEBUG
-static int omap_sr_autocomp_show(void *data, u64 *val)
-{
-	struct smartreflex *sr = (struct smartreflex *) data;
-
-	if (!sr) {
-		pr_warning("%s: smartreflex struct not found\n", __func__);
-		return -EINVAL;
-	}
-
-	*val = sr->autocomp_active;
-
-	return 0;
-}
-
-static int omap_sr_autocomp_store(void *data, u64 val)
-{
-	struct smartreflex *sr = (struct smartreflex *) data;
-
-	if (!sr) {
-		pr_warning("%s: smartreflex struct not found\n", __func__);
-		return -EINVAL;
-	}
-
-	/* Sanity check */
-	if (val && (val != 1)) {
-		pr_warning("%s: Invalid argument %lld\n", __func__, val);
-		return -EINVAL;
-	}
-
-	/* control enable/disable only if there is a delta in value */
-	if (sr->autocomp_active != val) {
-		if (!val)
-			sr_stop_vddautocomp(sr);
-		else
-			sr_start_vddautocomp(sr);
-	}
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
-		omap_sr_autocomp_store, "%llu\n");
-
-int __init sr_debugfs_setup(struct platform_device *pdev,
-			    struct smartreflex *sr)
-{
-	int i, ret = 0;
-	struct dentry *nvalue_dir;
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-
-	sr->dbg_dir = debugfs_create_dir(sr->name, sr_dbg_dir);
-	if (IS_ERR(sr->dbg_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
-			__func__);
-		return PTR_ERR(sr->dbg_dir);
-	}
-
-	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
-			sr->dbg_dir, (void *)sr, &pm_sr_fops);
-	(void) debugfs_create_x32("errweight", S_IRUGO, sr->dbg_dir,
-			&pdata->err_weight);
-	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr->dbg_dir,
-			&pdata->err_maxlimit);
-
-	/* XXX This should be per-OPP parameters, not just nvalue! */
-	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
-	if (IS_ERR(nvalue_dir)) {
-		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n", __func__);
-		ret = PTR_ERR(nvalue_dir);
-		goto err_debugfs;
-	}
-
-	if (pdata->data_count == 0 || !pdata->data_table) {
-		dev_warn(&pdev->dev, "%s: no SR data table\n", __func__);
-		ret = -ENODATA;
-		goto err_debugfs;
-	}
-
-	for (i = 0; i < pdata->data_count; i++) {
-		char name[NVALUE_NAME_LEN + 1];
-
-		/* XXX Also needs to include errminlimit! */
-		snprintf(name, sizeof(name), "volt_%lu",
-			 sr->data_table[i].volt_nominal);
-		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
-				&(sr->data_table[i].nvalue));
-	}
-
-	return ret;
-
-err_debugfs:
-	debugfs_remove_recursive(sr->dbg_dir);
-
-	return ret;
-}
-#else
-int __init sr_debugfs_setup(struct platform_device *pdev,
-			    struct smartreflex *sr)
-{
-	return 0;
-}
-#endif
-
-int __init sr_common_probe(struct platform_device *pdev,
-			   struct smartreflex *sr)
-{
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	struct resource *mem, *irq;
-	int ret = 0;
-
-	sr->name = kasprintf(GFP_KERNEL, "sr_%s", pdata->name);
-	if (!sr->name) {
-		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -ENODEV;
-	}
-
-	mem = request_mem_region(mem->start, resource_size(mem),
-					dev_name(&pdev->dev));
-	if (!mem) {
-		dev_err(&pdev->dev, "%s: no mem region\n", __func__);
-		return -EBUSY;
-	}
-
-	sr->base = ioremap(mem->start, resource_size(mem));
-	if (!sr->base) {
-		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
-		ret = -ENOMEM;
-		goto err_release_region;
-	}
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "%s: no IRQ resource defined\n", __func__);
-		ret = -ENODEV;
-		goto err_iounmap;
-	}
-	sr->irq = irq->start;
-
-	ret = request_irq(sr->irq, sr->isr, 0, sr->name, (void *)sr);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: could not register interrupt "
-				    "handler\n", __func__);
-		goto err_iounmap;
-	}
-
-	pdata->sr = sr;
-
-	sr->pdev = pdev;
-	sr->voltdm = pdata->voltdm;
-
-	sr->autocomp_active = false;
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_irq_safe(&pdev->dev);
-
-#ifdef CONFIG_POWER_AVS_DEBUG
-	ret = sr_debugfs_setup(pdev, sr);
-	if (ret)
-		goto err_free_irq;
-#endif
-
-	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
-
-	return ret;
-
-err_free_irq:
-	free_irq(sr->irq, (void *)sr);
-err_iounmap:
-	iounmap(sr->base);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
-
-	return ret;
-}
-
-int __devexit sr_remove(struct platform_device *pdev)
-{
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	struct smartreflex *sr;
-	struct resource *mem;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr = pdata->sr;
-	if (IS_ERR(sr)) {
-		dev_warn(&pdev->dev, "%s: smartreflex struct not found\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (sr->autocomp_active)
-		sr_stop_vddautocomp(sr);
-#ifdef CONFIG_POWER_AVS_DEBUG
-	if (sr->dbg_dir)
-		debugfs_remove_recursive(sr->dbg_dir);
-#endif
-	free_irq(sr->irq, (void *)sr);
-	iounmap(sr->base);
-	kfree(sr);
-	pdata->sr = NULL;
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
-
-	return 0;
-}
-
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
deleted file mode 100644
index 3395a48..0000000
--- a/arch/arm/mach-omap2/smartreflex.h
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * OMAP Smartreflex Defines and Routines
- *
- * Author: Thara Gopinath	<thara@ti.com>
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- * Thara Gopinath <thara@ti.com>
- *
- * Copyright (C) 2008 Nokia Corporation
- * Kalle Jokiniemi
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Lesly A M <x0080970@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __DRIVERS_POWER_AVS_SMARTREFLEX_H
-#define __DRIVERS_POWER_AVS_SMARTREFLEX_H
-
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#include <plat/smartreflex.h>
-#include <plat/voltage.h>
-
-#include "smartreflex.h"
-
-/*
- * Different Smartreflex IPs version. The v1 is the 65nm version used in
- * OMAP3430. The v2 is the update for the 45nm version of the IP
- * used in OMAP3630 and OMAP4430
- */
-#define SR_TYPE_V1	1
-#define SR_TYPE_V2	2
-
-/*
- * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
- * The smartreflex class driver should pass the class type.
- * Should be used to populate the class_type field of the
- * omap_smartreflex_class_data structure.
- */
-#define SR_CLASS1	0x1
-#define SR_CLASS2	0x2
-#define SR_CLASS3	0x3
-
-#define SR_DISABLE_TIMEOUT	200
-
-/* SMART REFLEX REG ADDRESS OFFSET */
-#define SRCONFIG		0x00
-#define SRSTATUS		0x04
-#define SENVAL			0x08
-#define SENMIN			0x0C
-#define SENMAX			0x10
-#define SENAVG			0x14
-#define AVGWEIGHT		0x18
-#define NVALUERECIPROCAL	0x1c
-#define SENERROR_V1		0x20
-#define ERRCONFIG_V1		0x24
-#define IRQ_EOI			0x20
-#define IRQSTATUS_RAW		0x24
-#define IRQSTATUS		0x28
-#define IRQENABLE_SET		0x2C
-#define IRQENABLE_CLR		0x30
-#define SENERROR_V2		0x34
-#define ERRCONFIG_V2		0x38
-
-/* Bit/Shift Positions */
-
-/* SRCONFIG */
-#define SRCONFIG_ACCUMDATA_SHIFT	22
-#define SRCONFIG_SRCLKLENGTH_SHIFT	12
-#define SRCONFIG_SENNENABLE_V1_SHIFT	5
-#define SRCONFIG_SENPENABLE_V1_SHIFT	3
-#define SRCONFIG_SENNENABLE_V2_SHIFT	1
-#define SRCONFIG_SENPENABLE_V2_SHIFT	0
-#define SRCONFIG_CLKCTRL_SHIFT		0
-
-#define SRCONFIG_ACCUMDATA_MASK		(0x3ff << 22)
-
-#define SRCONFIG_SRENABLE		BIT(11)
-#define SRCONFIG_SENENABLE		BIT(10)
-#define SRCONFIG_ERRGEN_EN		BIT(9)
-#define SRCONFIG_MINMAXAVG_EN		BIT(8)
-#define SRCONFIG_DELAYCTRL		BIT(2)
-
-/* AVGWEIGHT */
-#define AVGWEIGHT_SENPAVGWEIGHT_SHIFT	2
-#define AVGWEIGHT_SENNAVGWEIGHT_SHIFT	0
-
-/* NVALUERECIPROCAL */
-#define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
-#define NVALUERECIPROCAL_SENNGAIN_SHIFT	16
-#define NVALUERECIPROCAL_RNSENP_SHIFT	8
-#define NVALUERECIPROCAL_RNSENN_SHIFT	0
-
-/* ERRCONFIG */
-#define ERRCONFIG_ERRWEIGHT_SHIFT	16
-#define ERRCONFIG_ERRMAXLIMIT_SHIFT	8
-#define ERRCONFIG_ERRMINLIMIT_SHIFT	0
-
-#define SR_ERRWEIGHT_MASK		(0x07 << 16)
-#define SR_ERRMAXLIMIT_MASK		(0xff << 8)
-#define SR_ERRMINLIMIT_MASK		(0xff << 0)
-
-#define ERRCONFIG_VPBOUNDINTEN_V1	BIT(31)
-#define ERRCONFIG_VPBOUNDINTST_V1	BIT(30)
-#define	ERRCONFIG_MCUACCUMINTEN		BIT(29)
-#define ERRCONFIG_MCUACCUMINTST		BIT(28)
-#define	ERRCONFIG_MCUVALIDINTEN		BIT(27)
-#define ERRCONFIG_MCUVALIDINTST		BIT(26)
-#define ERRCONFIG_MCUBOUNDINTEN		BIT(25)
-#define	ERRCONFIG_MCUBOUNDINTST		BIT(24)
-#define	ERRCONFIG_MCUDISACKINTEN	BIT(23)
-#define ERRCONFIG_VPBOUNDINTST_V2	BIT(23)
-#define ERRCONFIG_MCUDISACKINTST	BIT(22)
-#define ERRCONFIG_VPBOUNDINTEN_V2	BIT(22)
-
-#define ERRCONFIG_STATUS_V1_MASK	(ERRCONFIG_VPBOUNDINTST_V1 | \
-					ERRCONFIG_MCUACCUMINTST | \
-					ERRCONFIG_MCUVALIDINTST | \
-					ERRCONFIG_MCUBOUNDINTST | \
-					ERRCONFIG_MCUDISACKINTST)
-/* IRQSTATUS */
-#define IRQSTATUS_MCUACCUMINT		BIT(3)
-#define IRQSTATUS_MCVALIDINT		BIT(2)
-#define IRQSTATUS_MCBOUNDSINT		BIT(1)
-#define IRQSTATUS_MCUDISABLEACKINT	BIT(0)
-
-/* IRQENABLE_SET and IRQENABLE_CLEAR */
-#define IRQENABLE_MCUACCUMINT		BIT(3)
-#define IRQENABLE_MCUVALIDINT		BIT(2)
-#define IRQENABLE_MCUBOUNDSINT		BIT(1)
-#define IRQENABLE_MCUDISABLEACKINT	BIT(0)
-
-/* XXX kerneldoc documentation needed */
-struct smartreflex {
-	char			*name;
-	int			ip_type;
-	bool			autocomp_active;
-	u32			err_minlimit;
-	u32			errconfig_mask;
-	u32			vpboundint_en;
-	u32			vpboundint_st;
-	u32			proto_sr_config;
-	void __iomem		*base;
-	struct platform_device	*pdev;
-	struct list_head	node;
-	struct omap_sr_data_table	*data_table;
-	struct smartreflex_class_data	*sr_class;
-	struct voltagedomain	*voltdm;
-	struct dentry		*dbg_dir;
-	u8			errconfig_offs;
-	unsigned int		irq;
-	irqreturn_t		(*isr)(int irq, void *data);
-	void			(*disable)(struct smartreflex *sr);
-	int			(*configure_minmax)(struct smartreflex *sr);
-};
-
-/**
- * struct omap_sr_class_data - Smartreflex class driver info
- *
- * @enable:		API to enable a particular class smaartreflex.
- * @disable:		API to disable a particular class smartreflex.
- * @configure:		API to configure a particular class smartreflex.
- * @class_type:		specify which smartreflex class.
- *			Can be used by the SR driver to take any class
- *			based decisions.
- */
-struct smartreflex_class_data {
-	int (*enable)(struct smartreflex *sr);
-	int (*disable)(struct smartreflex *sr, int is_volt_reset);
-	int (*configure)(struct smartreflex *sr);
-	u8 class_type;
-};
-
-/* Internal functions */
-static inline u32 sr_read_reg(struct smartreflex *sr, unsigned offset)
-{
-	return __raw_readl(sr->base + offset);
-}
-
-static inline void sr_write_reg(struct smartreflex *sr, unsigned offset,
-			 u32 value)
-{
-	__raw_writel(value, (sr->base + offset));
-}
-
-static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset,
-			  u32 mask, u32 value)
-{
-	u32 reg_val;
-
-	reg_val = __raw_readl(sr->base + offset);
-	reg_val &= ~mask;
-
-	/*
-	 * Smartreflex error config register is special as it contains
-	 * certain status bits which if written a 1 into means a clear
-	 * of those bits. So in order to make sure no accidental write of
-	 * 1 happens to those status bits, do a clear of them in the read
-	 * value. This mean this API doesn't rewrite values in these bits
-	 * if they are currently set, but does allow the caller to write
-	 * those bits.
-	 */
-	if (offset == sr->errconfig_offs)
-		reg_val &= ~sr->errconfig_mask;
-
-	reg_val |= value;
-
-	__raw_writel(reg_val, (sr->base + offset));
-}
-
-extern int sr_calculate_clk_length(struct smartreflex *sr);
-extern int __devexit sr_remove(struct platform_device *pdev);
-extern int __init sr_common_probe(struct platform_device *pdev,
-				  struct smartreflex *sr);
-
-/* Smartreflex driver hooks to be called from Smartreflex class driver */
-int sr_enable(struct smartreflex *sr, unsigned long volt);
-void sr_disable(struct smartreflex *sr);
-int sr_configure_errgen(struct smartreflex *sr);
-int sr_configure_minmax(struct smartreflex *sr);
-
-/* API to register the smartreflex class driver with the smartreflex driver */
-int sr_register_class(struct platform_device *pdev,
-		      struct smartreflex_class_data *class_data);
-#endif
-
diff --git a/arch/arm/mach-omap2/smartreflex_v1.c b/arch/arm/mach-omap2/smartreflex_v1.c
deleted file mode 100644
index 5629632..0000000
--- a/arch/arm/mach-omap2/smartreflex_v1.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Device driver for the SmartReflex IP block v1
- *
- * Author: Thara Gopinath	<thara@ti.com>
- *
- * Copyright (C) 2007,2010 Texas Instruments, Inc.
- * Lesly A M <x0080970@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Copyright (C) 2008,2011 Nokia Corporation
- * Kalle Jokiniemi
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <plat/common.h>
-#include <plat/smartreflex.h>
-
-#include "smartreflex.h"
-
-static irqreturn_t _interrupt(int irq, void *data)
-{
-	struct smartreflex *sr = (struct smartreflex *)data;
-	u32 status = 0;
-
-	/* Read the status bits */
-	status = sr_read_reg(sr, ERRCONFIG_V1);
-
-	/* Clear them by writing back */
-	sr_write_reg(sr, ERRCONFIG_V1, status);
-
-	/*
-	 * XXX If the class driver needs to be notified here, it should
-	 * use an atomic notifier
-	 */
-
-	return IRQ_HANDLED;
-}
-
-static void _disable(struct smartreflex *sr)
-{
-	int timeout = 0;
-
-	/* Enable MCUDisableAcknowledge interrupt */
-	sr_modify_reg(sr, ERRCONFIG_V1,
-			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
-
-	/* SRCONFIG - disable SR */
-	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
-
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG_V1,
-			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
-			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
-			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
-			ERRCONFIG_MCUBOUNDINTST |
-			ERRCONFIG_VPBOUNDINTST_V1));
-
-	/*
-	 * Wait for SR to be disabled.
-	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
-	 */
-	omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
-			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
-			timeout);
-
-	if (timeout >= SR_DISABLE_TIMEOUT)
-		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
-			__func__);
-
-	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
-	sr_modify_reg(sr, ERRCONFIG_V1, ERRCONFIG_MCUDISACKINTEN,
-			ERRCONFIG_MCUDISACKINTST);
-}
-
-static int _configure_minmax(struct smartreflex *sr)
-{
-	/*
-	 * Enabling the interrupts if MINMAXAVG module is used.
-	 * TODO: check if all the interrupts are mandatory
-	 */
-	sr_modify_reg(sr, ERRCONFIG_V1,
-		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
-		ERRCONFIG_MCUBOUNDINTEN),
-		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
-		 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
-		 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
-
-	return 0;
-}
-
-static int __init sr_probe(struct platform_device *pdev)
-{
-	struct smartreflex *sr = kzalloc(sizeof(struct smartreflex), GFP_KERNEL);
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	u32 srclklength;
-	u8 senn_shift, senp_shift;
-	int ret = 0;
-
-	if (!sr) {
-		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
-		return -ENOMEM;
-	}
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		ret = -EINVAL;
-		goto err_free_devinfo;
-	}
-
-	srclklength = sr_calculate_clk_length(sr);
-
-	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE;
-
-	senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
-	senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
-	sr->proto_sr_config |= SRCONFIG_DELAYCTRL;
-	sr->errconfig_offs = ERRCONFIG_V1;
-	sr->errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
-	sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
-	sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
-
-	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
-				(pdata->senp_mod << senp_shift));
-
-	sr->isr = _interrupt;
-	sr->disable = _disable;
-	sr->configure_minmax = _configure_minmax;
-
-	ret = sr_common_probe(pdev, sr);
-
-	return ret;
-
-err_free_devinfo:
-	kfree(sr);
-
-	return ret;
-}
-
-static struct platform_driver smartreflex_driver = {
-	.remove		= sr_remove,
-	.driver		= {
-		.name	= "smartreflex-v1",
-	},
-};
-
-/* SmartReflex IP v1 is the 65nm version used in OMAP3430 */
-static int __init sr_init(void)
-{
-	int ret = 0;
-
-	if (!(cpu_is_omap34xx() && !(cpu_is_omap3630() || cpu_is_omap44xx())))
-		return -ENODEV;
-
-	ret = platform_driver_probe(&smartreflex_driver, sr_probe);
-	if (ret) {
-		pr_err("%s: platform driver register failed for SR\n",
-			__func__);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void __exit sr_exit(void)
-{
-	platform_driver_unregister(&smartreflex_driver);
-}
-late_initcall(sr_init);
-module_exit(sr_exit);
-
-MODULE_DESCRIPTION("SmartReflex v1 device driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/arch/arm/mach-omap2/smartreflex_v2.c b/arch/arm/mach-omap2/smartreflex_v2.c
deleted file mode 100644
index 5fbbc8e..0000000
--- a/arch/arm/mach-omap2/smartreflex_v2.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * Device driver for the SmartReflex IP block v2
- *
- * Author: Thara Gopinath	<thara@ti.com>
- *
- * Copyright (C) 2007,2010 Texas Instruments, Inc.
- * Lesly A M <x0080970@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Copyright (C) 2008,2011 Nokia Corporation
- * Kalle Jokiniemi
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <plat/common.h>
-#include <plat/smartreflex.h>
-
-#include "smartreflex.h"
-
-static irqreturn_t _interrupt(int irq, void *data)
-{
-	struct smartreflex *sr = (struct smartreflex *)data;
-	u32 status = 0;
-
-	/* Read the status bits */
-	sr_read_reg(sr, IRQSTATUS);
-
-	/* Clear them by writing back */
-	sr_write_reg(sr, IRQSTATUS, status);
-
-	/*
-	 * XXX If the class driver needs to be notified here, it should
-	 * use an atomic notifier
-	 */
-
-	return IRQ_HANDLED;
-}
-
-static void _disable(struct smartreflex *sr)
-{
-	int timeout = 0;
-
-	/* Enable MCUDisableAcknowledge interrupt */
-	sr_write_reg(sr, IRQENABLE_SET, IRQENABLE_MCUDISABLEACKINT);
-
-	/* SRCONFIG - disable SR */
-	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
-
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
-			ERRCONFIG_VPBOUNDINTST_V2);
-	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
-			IRQENABLE_MCUVALIDINT |
-			IRQENABLE_MCUBOUNDSINT));
-	sr_write_reg(sr, IRQSTATUS, (IRQSTATUS_MCUACCUMINT |
-			IRQSTATUS_MCVALIDINT |
-			IRQSTATUS_MCBOUNDSINT));
-
-	/*
-	 * Wait for SR to be disabled.
-	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
-	 */
-	omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
-			IRQSTATUS_MCUDISABLEACKINT), SR_DISABLE_TIMEOUT,
-			timeout);
-
-	if (timeout >= SR_DISABLE_TIMEOUT)
-		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
-			__func__);
-
-	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
-	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
-	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
-}
-
-static int _configure_minmax(struct smartreflex *sr)
-{
-	/*
-	 * Enabling the interrupts if MINMAXAVG module is used.
-	 * TODO: check if all the interrupts are mandatory
-	 */
-	sr_write_reg(sr, IRQSTATUS,
-		IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
-		IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
-	sr_write_reg(sr, IRQENABLE_SET,
-		IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
-		IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
-
-	return 0;
-}
-
-static int __init sr_probe(struct platform_device *pdev)
-{
-	struct smartreflex *sr = kzalloc(sizeof(struct smartreflex), GFP_KERNEL);
-	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
-	u32 srclklength;
-	u8 senn_shift, senp_shift;
-	int ret = 0;
-
-	if (!sr) {
-		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
-		return -ENOMEM;
-	}
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		ret = -EINVAL;
-		goto err_free_devinfo;
-	}
-
-	srclklength = sr_calculate_clk_length(sr);
-
-	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
-		SRCONFIG_SENENABLE;
-
-	senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
-	senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
-	sr->errconfig_offs = ERRCONFIG_V2;
-	sr->errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
-	sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
-	sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
-
-	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
-				(pdata->senp_mod << senp_shift));
-
-	sr->isr = _interrupt;
-	sr->disable = _disable;
-	sr->configure_minmax = _configure_minmax;
-
-	ret = sr_common_probe(pdev, sr);
-
-	return ret;
-
-err_free_devinfo:
-	kfree(sr);
-
-	return ret;
-}
-
-static struct platform_driver smartreflex_driver = {
-	.remove		= sr_remove,
-	.driver		= {
-		.name	= "smartreflex-v2",
-	},
-};
-
-/*
- * SmartReflex IP v2 is the update from v1 for the 45nm version of the IP
- * used in OMAP3630 and OMAP4430
- */
-static int __init sr_init(void)
-{
-	int ret = 0;
-
-	if (!(cpu_is_omap3630() || cpu_is_omap44xx()))
-		return -ENODEV;
-
-	ret = platform_driver_probe(&smartreflex_driver, sr_probe);
-	if (ret) {
-		pr_err("%s: platform driver register failed for SR\n",
-			__func__);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void __exit sr_exit(void)
-{
-	platform_driver_unregister(&smartreflex_driver);
-}
-late_initcall(sr_init);
-module_exit(sr_exit);
-
-MODULE_DESCRIPTION("SmartReflex v2 device driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 9f88641..945b427 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -251,3 +251,5 @@ config CHARGER_MAX8998
 	  platform data of MAX8998/LP3974 PMICs.
 
 endif # POWER_SUPPLY
+
+source "drivers/power/avs/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b4af13d..2bd3d16 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -38,3 +38,5 @@ obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
+
+obj-$(CONFIG_POWER_AVS)		+= avs/
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
new file mode 100644
index 0000000..900a239
--- /dev/null
+++ b/drivers/power/avs/Kconfig
@@ -0,0 +1,56 @@
+menuconfig POWER_AVS
+	tristate "Adaptive Voltage Scaling class support"
+	help
+	  AVS is a power management technique which controls the operating
+	  voltage of a device in order to optimize (i.e. reduce) its power
+	  consumption. The voltage is adapted depending on static factors
+	  (chip manufacturing process) and dynamic factors (temperature
+	  depending performance). AVS is also called SmartReflex on OMAP
+	  devices.
+
+	  Say Y here to enable Adaptive Voltage Scaling class support.
+
+if POWER_AVS
+
+config POWER_AVS_DEBUG
+	bool "Adaptive Voltage Scaling debug"
+	depends on DEBUG_FS
+	help
+	  Say Y here to enable debugfs entries for the AVS class and drivers.
+
+config POWER_AVS_OMAP_V1
+	tristate "AVS support for the OMAP IP version 1"
+	depends on ARCH_OMAP3 && PM
+	help
+	  Say Y to enable AVS support on OMAP containing the version 1 of
+	  the SmartReflex IP.
+	  V1 is the 65nm version used in OMAP3430.
+
+	  Please note, that by default SmartReflex is only
+	  initialized. To enable the automatic voltage
+	  compensation for vdd mpu  and vdd core from user space,
+	  user must write 1 to
+		/debug/voltage/vdd_<X>/smartreflex/autocomp,
+	  where X is mpu or core for OMAP3.
+	  Optionally autocompensation can be enabled in the kernel
+	  by default during system init via the enable_on_init flag
+	  which an be passed as platform data to the smartreflex driver.
+
+config POWER_AVS_OMAP_V2
+	tristate "AVS support for the OMAP IP version 2"
+	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
+	help
+	  Say Y to enable AVS support on OMAP containing the version 2 of
+	  the SmartReflex IP.
+	  V2 is the update for the 45nm version of the IP used in OMAP3630
+	  and OMAP4430
+
+config POWER_AVS_OMAP_CLASS3
+	bool "Class 3 mode of Smartreflex Implementation"
+	depends on (POWER_AVS_OMAP_V1 || POWER_AVS_OMAP_V2) && TWL4030_CORE
+	help
+	  Say Y to enable Class 3 implementation of Smartreflex
+	  Class 3 implementation of Smartreflex employs continuous hardware
+	  voltage calibration.
+
+endif # POWER_AVS
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
new file mode 100644
index 0000000..e263ab4
--- /dev/null
+++ b/drivers/power/avs/Makefile
@@ -0,0 +1,4 @@
+omap-3-4-common				= smartreflex-common.o
+obj-$(CONFIG_POWER_AVS_OMAP_V1)		+= $(omap-3-4-common) smartreflex_v1.o
+obj-$(CONFIG_POWER_AVS_OMAP_V2)		+= $(omap-3-4-common) smartreflex_v2.o
+obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
diff --git a/drivers/power/avs/smartreflex-class3.c b/drivers/power/avs/smartreflex-class3.c
new file mode 100644
index 0000000..516901b
--- /dev/null
+++ b/drivers/power/avs/smartreflex-class3.c
@@ -0,0 +1,64 @@
+/*
+ * Smart reflex Class 3 specific implementations
+ *
+ * Author: Thara Gopinath       <thara@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "smartreflex.h"
+
+static int sr_class3_enable(struct smartreflex *sr)
+{
+	unsigned long volt = voltdm_get_voltage(sr->voltdm);
+
+	if (!volt) {
+		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
+				__func__, sr->name);
+		return -ENODATA;
+	}
+
+	omap_vp_enable(sr->voltdm);
+	return sr_enable(sr, volt);
+}
+
+static int sr_class3_disable(struct smartreflex *sr, int is_volt_reset)
+{
+	omap_vp_disable(sr->voltdm);
+	sr_disable(sr);
+	if (is_volt_reset)
+		voltdm_reset(sr->voltdm);
+
+	return 0;
+}
+
+static int sr_class3_configure(struct smartreflex *sr)
+{
+	return sr_configure_errgen(sr);
+}
+
+/* SR class3 structure */
+static struct smartreflex_class_data class3_data = {
+	.enable = sr_class3_enable,
+	.disable = sr_class3_disable,
+	.configure = sr_class3_configure,
+	.class_type = SR_CLASS3,
+};
+
+/* Smartreflex Class3 init API to be called from board file */
+static int __init sr_class3_init(void)
+{
+	struct platform_device *pdev = NULL;
+	int ret = sr_register_class(pdev, &class3_data);
+
+	if (!ret)
+		pr_info("SmartReflex Class3 initialized\n");
+
+	return ret;
+}
+late_initcall(sr_class3_init);
diff --git a/drivers/power/avs/smartreflex-common.c b/drivers/power/avs/smartreflex-common.c
new file mode 100644
index 0000000..d693195
--- /dev/null
+++ b/drivers/power/avs/smartreflex-common.c
@@ -0,0 +1,543 @@
+/*
+ * Device driver for the SmartReflex IP blocks, common code
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2007,2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Copyright (C) 2008,2011 Nokia Corporation
+ * Kalle Jokiniemi
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+
+#include <plat/common.h>
+#include <plat/smartreflex.h>
+
+#include "smartreflex.h"
+
+#define NVALUE_NAME_LEN		40
+
+/*
+ * SR_CLK is the internal SmartReflex sensor sampling clock.  The OMAP34xx
+ * TRM Rev ZH Section 4.10.5.4.3 "SmartReflex Submodules" states that this
+ * should be 100KHz.
+ */
+#define SR_CLK			100000 /* Hz */
+
+static struct dentry		*sr_dbg_dir;
+
+int sr_calculate_clk_length(struct smartreflex *sr)
+{
+	struct clk *fck;
+	int fck_rate, clk_length;
+
+	fck = clk_get(&sr->pdev->dev, "fck");
+	if (IS_ERR(fck)) {
+		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
+			__func__);
+		return 0;
+	}
+	fck_rate = clk_get_rate(fck);
+	clk_put(fck);
+
+	/*
+	 * This formula is from OMAP34xx TRM Rev ZH Section 4.10.5.4.3
+	 * "SmartReflex Submodules"
+	 */
+	clk_length = fck_rate / (2 * SR_CLK);
+
+	dev_dbg(&sr->pdev->dev, "%s: SRCLKLENGTH = %03x\n",
+		__func__, clk_length);
+
+	return clk_length;
+}
+
+static void sr_start_vddautocomp(struct smartreflex *sr)
+{
+	if (!sr->sr_class || !sr->sr_class->enable ||
+	    !sr->sr_class->configure) {
+		dev_warn(&sr->pdev->dev,
+			"%s: smartreflex class driver not registered\n",
+			__func__);
+		return;
+	}
+
+	if (!sr->sr_class->enable(sr))
+		sr->autocomp_active = true;
+}
+
+static void sr_stop_vddautocomp(struct smartreflex *sr)
+{
+	if (!sr->sr_class || !sr->sr_class->disable) {
+		dev_warn(&sr->pdev->dev,
+			"%s: smartreflex class driver not registered\n",
+			__func__);
+		return;
+	}
+
+	if (sr->autocomp_active) {
+		sr->sr_class->disable(sr, 1);
+		sr->autocomp_active = false;
+	}
+}
+
+static struct omap_sr_data_table *sr_retrieve_nvalue_row(
+				struct smartreflex *sr,
+				unsigned long volt_nominal)
+{
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
+	int i;
+
+	if (!sr->data_table) {
+		dev_warn(&sr->pdev->dev, "%s: Missing ntarget value table\n",
+			__func__);
+		return NULL;
+	}
+
+	for (i = 0; i < pdata->data_count; i++)
+		if (sr->data_table[i].volt_nominal == volt_nominal)
+			return &sr->data_table[i];
+
+	return NULL;
+}
+
+/**
+ * sr_configure_errgen() - Configures the smrtreflex to perform AVS using the
+ *			 error generator module.
+ * @sr: struct smartreflex *
+ *
+ * This API is to be called from the smartreflex class driver to
+ * configure the error generator module inside the smartreflex module.
+ * SR settings if using the ERROR module inside Smartreflex.
+ * SR CLASS 3 by default uses only the ERROR module where as
+ * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+ * module. Returns 0 on success and error value in case of failure.
+ */
+int sr_configure_errgen(struct smartreflex *sr)
+{
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
+	u32 sr_config, sr_errconfig;
+
+	if (IS_ERR_OR_NULL(sr))
+		return -EINVAL;
+
+	if (!sr_calculate_clk_length(sr))
+		return -EINVAL;
+
+	sr_config = sr->proto_sr_config;
+	sr_config |=  SRCONFIG_ERRGEN_EN;
+	sr_write_reg(sr, SRCONFIG, sr_config);
+
+	sr_errconfig = (pdata->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
+		(pdata->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
+		(sr->err_minlimit <<  ERRCONFIG_ERRMINLIMIT_SHIFT);
+	sr_modify_reg(sr, sr->errconfig_offs, (SR_ERRWEIGHT_MASK |
+		SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
+		sr_errconfig);
+
+	/* Enabling the interrupts if the ERROR module is used */
+	sr_modify_reg(sr, sr->errconfig_offs,
+		sr->vpboundint_en, (sr->vpboundint_en | sr->vpboundint_st));
+
+	return 0;
+}
+
+static int sr_common_configure_minmax(struct smartreflex *sr)
+{
+	struct smartreflex_platform_data *pdata = sr->pdev->dev.platform_data;
+	u32 sr_config, sr_avgwt;
+
+	sr_config = sr->proto_sr_config;
+	sr_config |= (pdata->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
+	sr_write_reg(sr, SRCONFIG, sr_config);
+
+	sr_avgwt = (pdata->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
+		(pdata->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
+	sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
+
+	return 0;
+}
+
+/**
+ * sr_configure_minmax() - Configures the smrtreflex to perform AVS using the
+ *  minmaxavg module.
+ * @sr: struct smartreflex *
+ *
+ * This API is to be called from the smartreflex class driver to
+ * configure the minmaxavg module inside the smartreflex module.
+ * SR settings if using the ERROR module inside Smartreflex.
+ * SR CLASS 3 by default uses only the ERROR module where as
+ * SR CLASS 2 can choose between ERROR module and MINMAXAVG
+ * module. Returns 0 on success and error value in case of failure.
+ */
+int sr_configure_minmax(struct smartreflex *sr)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(sr))
+		return -EINVAL;
+
+	ret = sr_common_configure_minmax(sr);
+	if (ret)
+		return ret;
+
+	return sr->configure_minmax(sr);
+}
+
+/**
+ * sr_enable() - Enables the smartreflex module.
+ * @sr: struct smartreflex *
+ * @volt:	The voltage at which the Voltage domain associated with
+ *		the smartreflex module is operating at.
+ *		This is required only to program the correct Ntarget value.
+ *
+ * This API is to be called from the smartreflex class driver to
+ * enable a smartreflex module. Returns 0 on success. Returns error
+ * value if the voltage passed is wrong or if ntarget value is wrong.
+ */
+int sr_enable(struct smartreflex *sr, unsigned long volt)
+{
+	struct omap_sr_data_table *nvalue_row;
+	int ret;
+
+	if (IS_ERR_OR_NULL(sr))
+		return -EINVAL;
+
+	/* Check if SR clocks are already enabled. If yes do nothing */
+	if (!pm_runtime_suspended(&sr->pdev->dev))
+		return 0;
+
+	nvalue_row = sr_retrieve_nvalue_row(sr, volt);
+	if (!nvalue_row) {
+		dev_warn(&sr->pdev->dev, "%s: failure getting SR data for "
+			 "this voltage %ld\n",__func__, volt);
+		return -ENODATA;
+	}
+
+	/* errminlimit is opp dependent and hence linked to voltage */
+	sr->err_minlimit = nvalue_row->errminlimit;
+
+	pm_runtime_get_sync(&sr->pdev->dev);
+
+	/* Check if SR is already enabled. If yes do nothing */
+	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
+		goto out;
+
+	/* Configure SR */
+	ret = sr->sr_class->configure(sr);
+	if (ret)
+		return ret;
+
+	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_row->nvalue);
+
+	/* SRCONFIG - enable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
+
+out:
+	pm_runtime_put_sync(&sr->pdev->dev);
+	return 0;
+}
+
+/**
+ * sr_disable() - Disables the smartreflex module.
+ * @sr: struct smartreflex *
+ *
+ * This API is to be called from the smartreflex class driver to
+ * disable a smartreflex module.
+ */
+void sr_disable(struct smartreflex *sr)
+{
+	if (IS_ERR_OR_NULL(sr))
+		return;
+
+	/* Check if SR clocks are already disabled. If yes do nothing */
+	if (pm_runtime_suspended(&sr->pdev->dev))
+		return;
+
+	/*
+	 * Disable SR if only it is indeed enabled. Else just
+	 * disable the clocks.
+	 */
+	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE) {
+		sr->disable(sr);
+	}
+
+	pm_runtime_put_sync_suspend(&sr->pdev->dev);
+}
+
+/**
+ * sr_register_class() - API to register a smartreflex class parameters.
+ * @class_data:	The structure containing various sr class specific data.
+ *
+ * XXX FIX THIS DOCUMENTATION
+ *
+ * This API is to be called by the smartreflex class driver to register itself
+ * with the smartreflex driver during init. Returns 0 on success else the
+ * error value.
+ */
+int sr_register_class(struct platform_device *pdev, 
+		      struct smartreflex_class_data *class_data)
+{
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+	struct smartreflex *sr;
+	int ret = 0;
+
+	if (!pdev || !class_data)
+		return -EINVAL;
+
+	sr = pdata->sr;
+	if (sr) {
+		dev_err(&pdev->dev, "%s: Smartreflex class driver already "
+				    "registered\n",
+		       __func__);
+		return -EBUSY; /* XXX -EEXIST seems better */
+	}
+
+	if (!sr->irq) {
+		dev_err(&pdev->dev, "%s: cannot register since class driver "
+				    "has an IRQ hook, but no SR IRQ "
+				    "specified\n", __func__);
+		ret = -EINVAL;
+		goto src_err;
+	}
+
+	sr->sr_class = class_data;
+
+	if (pdata->enable_on_init)
+		sr_start_vddautocomp(sr);
+
+src_err:
+	return ret;
+}
+
+#ifdef CONFIG_POWER_AVS_DEBUG
+static int omap_sr_autocomp_show(void *data, u64 *val)
+{
+	struct smartreflex *sr = (struct smartreflex *) data;
+
+	if (!sr) {
+		pr_warning("%s: smartreflex struct not found\n", __func__);
+		return -EINVAL;
+	}
+
+	*val = sr->autocomp_active;
+
+	return 0;
+}
+
+static int omap_sr_autocomp_store(void *data, u64 val)
+{
+	struct smartreflex *sr = (struct smartreflex *) data;
+
+	if (!sr) {
+		pr_warning("%s: smartreflex struct not found\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Sanity check */
+	if (val && (val != 1)) {
+		pr_warning("%s: Invalid argument %lld\n", __func__, val);
+		return -EINVAL;
+	}
+
+	/* control enable/disable only if there is a delta in value */
+	if (sr->autocomp_active != val) {
+		if (!val)
+			sr_stop_vddautocomp(sr);
+		else
+			sr_start_vddautocomp(sr);
+	}
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
+		omap_sr_autocomp_store, "%llu\n");
+
+int __init sr_debugfs_setup(struct platform_device *pdev,
+			    struct smartreflex *sr)
+{
+	int i, ret = 0;
+	struct dentry *nvalue_dir;
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+
+	sr->dbg_dir = debugfs_create_dir(sr->name, sr_dbg_dir);
+	if (IS_ERR(sr->dbg_dir)) {
+		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
+			__func__);
+		return PTR_ERR(sr->dbg_dir);
+	}
+
+	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
+			sr->dbg_dir, (void *)sr, &pm_sr_fops);
+	(void) debugfs_create_x32("errweight", S_IRUGO, sr->dbg_dir,
+			&pdata->err_weight);
+	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr->dbg_dir,
+			&pdata->err_maxlimit);
+
+	/* XXX This should be per-OPP parameters, not just nvalue! */
+	nvalue_dir = debugfs_create_dir("nvalue", sr->dbg_dir);
+	if (IS_ERR(nvalue_dir)) {
+		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n", __func__);
+		ret = PTR_ERR(nvalue_dir);
+		goto err_debugfs;
+	}
+
+	if (pdata->data_count == 0 || !pdata->data_table) {
+		dev_warn(&pdev->dev, "%s: no SR data table\n", __func__);
+		ret = -ENODATA;
+		goto err_debugfs;
+	}
+
+	for (i = 0; i < pdata->data_count; i++) {
+		char name[NVALUE_NAME_LEN + 1];
+
+		/* XXX Also needs to include errminlimit! */
+		snprintf(name, sizeof(name), "volt_%lu",
+			 sr->data_table[i].volt_nominal);
+		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
+				&(sr->data_table[i].nvalue));
+	}
+
+	return ret;
+
+err_debugfs:
+	debugfs_remove_recursive(sr->dbg_dir);
+
+	return ret;
+}
+#else
+int __init sr_debugfs_setup(struct platform_device *pdev,
+			    struct smartreflex *sr)
+{
+	return 0;
+}
+#endif
+
+int __init sr_common_probe(struct platform_device *pdev,
+			   struct smartreflex *sr)
+{
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *mem, *irq;
+	int ret = 0;
+
+	sr->name = kasprintf(GFP_KERNEL, "sr_%s", pdata->name);
+	if (!sr->name) {
+		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
+		return -ENODEV;
+	}
+
+	mem = request_mem_region(mem->start, resource_size(mem),
+					dev_name(&pdev->dev));
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem region\n", __func__);
+		return -EBUSY;
+	}
+
+	sr->base = ioremap(mem->start, resource_size(mem));
+	if (!sr->base) {
+		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
+		ret = -ENOMEM;
+		goto err_release_region;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "%s: no IRQ resource defined\n", __func__);
+		ret = -ENODEV;
+		goto err_iounmap;
+	}
+	sr->irq = irq->start;
+
+	ret = request_irq(sr->irq, sr->isr, 0, sr->name, (void *)sr);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: could not register interrupt "
+				    "handler\n", __func__);
+		goto err_iounmap;
+	}
+
+	pdata->sr = sr;
+
+	sr->pdev = pdev;
+	sr->voltdm = pdata->voltdm;
+
+	sr->autocomp_active = false;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
+
+#ifdef CONFIG_POWER_AVS_DEBUG
+	ret = sr_debugfs_setup(pdev, sr);
+	if (ret)
+		goto err_free_irq;
+#endif
+
+	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
+
+	return ret;
+
+err_free_irq:
+	free_irq(sr->irq, (void *)sr);
+err_iounmap:
+	iounmap(sr->base);
+err_release_region:
+	release_mem_region(mem->start, resource_size(mem));
+
+	return ret;
+}
+
+int __devexit sr_remove(struct platform_device *pdev)
+{
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+	struct smartreflex *sr;
+	struct resource *mem;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	sr = pdata->sr;
+	if (IS_ERR(sr)) {
+		dev_warn(&pdev->dev, "%s: smartreflex struct not found\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (sr->autocomp_active)
+		sr_stop_vddautocomp(sr);
+#ifdef CONFIG_POWER_AVS_DEBUG
+	if (sr->dbg_dir)
+		debugfs_remove_recursive(sr->dbg_dir);
+#endif
+	free_irq(sr->irq, (void *)sr);
+	iounmap(sr->base);
+	kfree(sr);
+	pdata->sr = NULL;
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+
+	return 0;
+}
+
diff --git a/drivers/power/avs/smartreflex.h b/drivers/power/avs/smartreflex.h
new file mode 100644
index 0000000..3395a48
--- /dev/null
+++ b/drivers/power/avs/smartreflex.h
@@ -0,0 +1,231 @@
+/*
+ * OMAP Smartreflex Defines and Routines
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Kalle Jokiniemi
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DRIVERS_POWER_AVS_SMARTREFLEX_H
+#define __DRIVERS_POWER_AVS_SMARTREFLEX_H
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <plat/smartreflex.h>
+#include <plat/voltage.h>
+
+#include "smartreflex.h"
+
+/*
+ * Different Smartreflex IPs version. The v1 is the 65nm version used in
+ * OMAP3430. The v2 is the update for the 45nm version of the IP
+ * used in OMAP3630 and OMAP4430
+ */
+#define SR_TYPE_V1	1
+#define SR_TYPE_V2	2
+
+/*
+ * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
+ * The smartreflex class driver should pass the class type.
+ * Should be used to populate the class_type field of the
+ * omap_smartreflex_class_data structure.
+ */
+#define SR_CLASS1	0x1
+#define SR_CLASS2	0x2
+#define SR_CLASS3	0x3
+
+#define SR_DISABLE_TIMEOUT	200
+
+/* SMART REFLEX REG ADDRESS OFFSET */
+#define SRCONFIG		0x00
+#define SRSTATUS		0x04
+#define SENVAL			0x08
+#define SENMIN			0x0C
+#define SENMAX			0x10
+#define SENAVG			0x14
+#define AVGWEIGHT		0x18
+#define NVALUERECIPROCAL	0x1c
+#define SENERROR_V1		0x20
+#define ERRCONFIG_V1		0x24
+#define IRQ_EOI			0x20
+#define IRQSTATUS_RAW		0x24
+#define IRQSTATUS		0x28
+#define IRQENABLE_SET		0x2C
+#define IRQENABLE_CLR		0x30
+#define SENERROR_V2		0x34
+#define ERRCONFIG_V2		0x38
+
+/* Bit/Shift Positions */
+
+/* SRCONFIG */
+#define SRCONFIG_ACCUMDATA_SHIFT	22
+#define SRCONFIG_SRCLKLENGTH_SHIFT	12
+#define SRCONFIG_SENNENABLE_V1_SHIFT	5
+#define SRCONFIG_SENPENABLE_V1_SHIFT	3
+#define SRCONFIG_SENNENABLE_V2_SHIFT	1
+#define SRCONFIG_SENPENABLE_V2_SHIFT	0
+#define SRCONFIG_CLKCTRL_SHIFT		0
+
+#define SRCONFIG_ACCUMDATA_MASK		(0x3ff << 22)
+
+#define SRCONFIG_SRENABLE		BIT(11)
+#define SRCONFIG_SENENABLE		BIT(10)
+#define SRCONFIG_ERRGEN_EN		BIT(9)
+#define SRCONFIG_MINMAXAVG_EN		BIT(8)
+#define SRCONFIG_DELAYCTRL		BIT(2)
+
+/* AVGWEIGHT */
+#define AVGWEIGHT_SENPAVGWEIGHT_SHIFT	2
+#define AVGWEIGHT_SENNAVGWEIGHT_SHIFT	0
+
+/* NVALUERECIPROCAL */
+#define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
+#define NVALUERECIPROCAL_SENNGAIN_SHIFT	16
+#define NVALUERECIPROCAL_RNSENP_SHIFT	8
+#define NVALUERECIPROCAL_RNSENN_SHIFT	0
+
+/* ERRCONFIG */
+#define ERRCONFIG_ERRWEIGHT_SHIFT	16
+#define ERRCONFIG_ERRMAXLIMIT_SHIFT	8
+#define ERRCONFIG_ERRMINLIMIT_SHIFT	0
+
+#define SR_ERRWEIGHT_MASK		(0x07 << 16)
+#define SR_ERRMAXLIMIT_MASK		(0xff << 8)
+#define SR_ERRMINLIMIT_MASK		(0xff << 0)
+
+#define ERRCONFIG_VPBOUNDINTEN_V1	BIT(31)
+#define ERRCONFIG_VPBOUNDINTST_V1	BIT(30)
+#define	ERRCONFIG_MCUACCUMINTEN		BIT(29)
+#define ERRCONFIG_MCUACCUMINTST		BIT(28)
+#define	ERRCONFIG_MCUVALIDINTEN		BIT(27)
+#define ERRCONFIG_MCUVALIDINTST		BIT(26)
+#define ERRCONFIG_MCUBOUNDINTEN		BIT(25)
+#define	ERRCONFIG_MCUBOUNDINTST		BIT(24)
+#define	ERRCONFIG_MCUDISACKINTEN	BIT(23)
+#define ERRCONFIG_VPBOUNDINTST_V2	BIT(23)
+#define ERRCONFIG_MCUDISACKINTST	BIT(22)
+#define ERRCONFIG_VPBOUNDINTEN_V2	BIT(22)
+
+#define ERRCONFIG_STATUS_V1_MASK	(ERRCONFIG_VPBOUNDINTST_V1 | \
+					ERRCONFIG_MCUACCUMINTST | \
+					ERRCONFIG_MCUVALIDINTST | \
+					ERRCONFIG_MCUBOUNDINTST | \
+					ERRCONFIG_MCUDISACKINTST)
+/* IRQSTATUS */
+#define IRQSTATUS_MCUACCUMINT		BIT(3)
+#define IRQSTATUS_MCVALIDINT		BIT(2)
+#define IRQSTATUS_MCBOUNDSINT		BIT(1)
+#define IRQSTATUS_MCUDISABLEACKINT	BIT(0)
+
+/* IRQENABLE_SET and IRQENABLE_CLEAR */
+#define IRQENABLE_MCUACCUMINT		BIT(3)
+#define IRQENABLE_MCUVALIDINT		BIT(2)
+#define IRQENABLE_MCUBOUNDSINT		BIT(1)
+#define IRQENABLE_MCUDISABLEACKINT	BIT(0)
+
+/* XXX kerneldoc documentation needed */
+struct smartreflex {
+	char			*name;
+	int			ip_type;
+	bool			autocomp_active;
+	u32			err_minlimit;
+	u32			errconfig_mask;
+	u32			vpboundint_en;
+	u32			vpboundint_st;
+	u32			proto_sr_config;
+	void __iomem		*base;
+	struct platform_device	*pdev;
+	struct list_head	node;
+	struct omap_sr_data_table	*data_table;
+	struct smartreflex_class_data	*sr_class;
+	struct voltagedomain	*voltdm;
+	struct dentry		*dbg_dir;
+	u8			errconfig_offs;
+	unsigned int		irq;
+	irqreturn_t		(*isr)(int irq, void *data);
+	void			(*disable)(struct smartreflex *sr);
+	int			(*configure_minmax)(struct smartreflex *sr);
+};
+
+/**
+ * struct omap_sr_class_data - Smartreflex class driver info
+ *
+ * @enable:		API to enable a particular class smaartreflex.
+ * @disable:		API to disable a particular class smartreflex.
+ * @configure:		API to configure a particular class smartreflex.
+ * @class_type:		specify which smartreflex class.
+ *			Can be used by the SR driver to take any class
+ *			based decisions.
+ */
+struct smartreflex_class_data {
+	int (*enable)(struct smartreflex *sr);
+	int (*disable)(struct smartreflex *sr, int is_volt_reset);
+	int (*configure)(struct smartreflex *sr);
+	u8 class_type;
+};
+
+/* Internal functions */
+static inline u32 sr_read_reg(struct smartreflex *sr, unsigned offset)
+{
+	return __raw_readl(sr->base + offset);
+}
+
+static inline void sr_write_reg(struct smartreflex *sr, unsigned offset,
+			 u32 value)
+{
+	__raw_writel(value, (sr->base + offset));
+}
+
+static inline void sr_modify_reg(struct smartreflex *sr, unsigned offset,
+			  u32 mask, u32 value)
+{
+	u32 reg_val;
+
+	reg_val = __raw_readl(sr->base + offset);
+	reg_val &= ~mask;
+
+	/*
+	 * Smartreflex error config register is special as it contains
+	 * certain status bits which if written a 1 into means a clear
+	 * of those bits. So in order to make sure no accidental write of
+	 * 1 happens to those status bits, do a clear of them in the read
+	 * value. This mean this API doesn't rewrite values in these bits
+	 * if they are currently set, but does allow the caller to write
+	 * those bits.
+	 */
+	if (offset == sr->errconfig_offs)
+		reg_val &= ~sr->errconfig_mask;
+
+	reg_val |= value;
+
+	__raw_writel(reg_val, (sr->base + offset));
+}
+
+extern int sr_calculate_clk_length(struct smartreflex *sr);
+extern int __devexit sr_remove(struct platform_device *pdev);
+extern int __init sr_common_probe(struct platform_device *pdev,
+				  struct smartreflex *sr);
+
+/* Smartreflex driver hooks to be called from Smartreflex class driver */
+int sr_enable(struct smartreflex *sr, unsigned long volt);
+void sr_disable(struct smartreflex *sr);
+int sr_configure_errgen(struct smartreflex *sr);
+int sr_configure_minmax(struct smartreflex *sr);
+
+/* API to register the smartreflex class driver with the smartreflex driver */
+int sr_register_class(struct platform_device *pdev,
+		      struct smartreflex_class_data *class_data);
+#endif
+
diff --git a/drivers/power/avs/smartreflex_v1.c b/drivers/power/avs/smartreflex_v1.c
new file mode 100644
index 0000000..5629632
--- /dev/null
+++ b/drivers/power/avs/smartreflex_v1.c
@@ -0,0 +1,183 @@
+/*
+ * Device driver for the SmartReflex IP block v1
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2007,2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Copyright (C) 2008,2011 Nokia Corporation
+ * Kalle Jokiniemi
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include <plat/common.h>
+#include <plat/smartreflex.h>
+
+#include "smartreflex.h"
+
+static irqreturn_t _interrupt(int irq, void *data)
+{
+	struct smartreflex *sr = (struct smartreflex *)data;
+	u32 status = 0;
+
+	/* Read the status bits */
+	status = sr_read_reg(sr, ERRCONFIG_V1);
+
+	/* Clear them by writing back */
+	sr_write_reg(sr, ERRCONFIG_V1, status);
+
+	/*
+	 * XXX If the class driver needs to be notified here, it should
+	 * use an atomic notifier
+	 */
+
+	return IRQ_HANDLED;
+}
+
+static void _disable(struct smartreflex *sr)
+{
+	int timeout = 0;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_modify_reg(sr, ERRCONFIG_V1,
+			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
+
+	/* SRCONFIG - disable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
+
+	/* Disable all other SR interrupts and clear the status */
+	sr_modify_reg(sr, ERRCONFIG_V1,
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
+			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
+			ERRCONFIG_MCUBOUNDINTST |
+			ERRCONFIG_VPBOUNDINTST_V1));
+
+	/*
+	 * Wait for SR to be disabled.
+	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
+			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
+			timeout);
+
+	if (timeout >= SR_DISABLE_TIMEOUT)
+		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
+			__func__);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
+	sr_modify_reg(sr, ERRCONFIG_V1, ERRCONFIG_MCUDISACKINTEN,
+			ERRCONFIG_MCUDISACKINTST);
+}
+
+static int _configure_minmax(struct smartreflex *sr)
+{
+	/*
+	 * Enabling the interrupts if MINMAXAVG module is used.
+	 * TODO: check if all the interrupts are mandatory
+	 */
+	sr_modify_reg(sr, ERRCONFIG_V1,
+		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+		ERRCONFIG_MCUBOUNDINTEN),
+		(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
+		 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
+		 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
+
+	return 0;
+}
+
+static int __init sr_probe(struct platform_device *pdev)
+{
+	struct smartreflex *sr = kzalloc(sizeof(struct smartreflex), GFP_KERNEL);
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+	u32 srclklength;
+	u8 senn_shift, senp_shift;
+	int ret = 0;
+
+	if (!sr) {
+		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
+		return -ENOMEM;
+	}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		ret = -EINVAL;
+		goto err_free_devinfo;
+	}
+
+	srclklength = sr_calculate_clk_length(sr);
+
+	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE;
+
+	senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
+	senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
+	sr->proto_sr_config |= SRCONFIG_DELAYCTRL;
+	sr->errconfig_offs = ERRCONFIG_V1;
+	sr->errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
+	sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
+	sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
+
+	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
+				(pdata->senp_mod << senp_shift));
+
+	sr->isr = _interrupt;
+	sr->disable = _disable;
+	sr->configure_minmax = _configure_minmax;
+
+	ret = sr_common_probe(pdev, sr);
+
+	return ret;
+
+err_free_devinfo:
+	kfree(sr);
+
+	return ret;
+}
+
+static struct platform_driver smartreflex_driver = {
+	.remove		= sr_remove,
+	.driver		= {
+		.name	= "smartreflex-v1",
+	},
+};
+
+/* SmartReflex IP v1 is the 65nm version used in OMAP3430 */
+static int __init sr_init(void)
+{
+	int ret = 0;
+
+	if (!(cpu_is_omap34xx() && !(cpu_is_omap3630() || cpu_is_omap44xx())))
+		return -ENODEV;
+
+	ret = platform_driver_probe(&smartreflex_driver, sr_probe);
+	if (ret) {
+		pr_err("%s: platform driver register failed for SR\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit sr_exit(void)
+{
+	platform_driver_unregister(&smartreflex_driver);
+}
+late_initcall(sr_init);
+module_exit(sr_exit);
+
+MODULE_DESCRIPTION("SmartReflex v1 device driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/power/avs/smartreflex_v2.c b/drivers/power/avs/smartreflex_v2.c
new file mode 100644
index 0000000..5fbbc8e
--- /dev/null
+++ b/drivers/power/avs/smartreflex_v2.c
@@ -0,0 +1,186 @@
+/*
+ * Device driver for the SmartReflex IP block v2
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2007,2010 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Copyright (C) 2008,2011 Nokia Corporation
+ * Kalle Jokiniemi
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include <plat/common.h>
+#include <plat/smartreflex.h>
+
+#include "smartreflex.h"
+
+static irqreturn_t _interrupt(int irq, void *data)
+{
+	struct smartreflex *sr = (struct smartreflex *)data;
+	u32 status = 0;
+
+	/* Read the status bits */
+	sr_read_reg(sr, IRQSTATUS);
+
+	/* Clear them by writing back */
+	sr_write_reg(sr, IRQSTATUS, status);
+
+	/*
+	 * XXX If the class driver needs to be notified here, it should
+	 * use an atomic notifier
+	 */
+
+	return IRQ_HANDLED;
+}
+
+static void _disable(struct smartreflex *sr)
+{
+	int timeout = 0;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_write_reg(sr, IRQENABLE_SET, IRQENABLE_MCUDISABLEACKINT);
+
+	/* SRCONFIG - disable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
+
+	/* Disable all other SR interrupts and clear the status */
+	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+			ERRCONFIG_VPBOUNDINTST_V2);
+	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
+			IRQENABLE_MCUVALIDINT |
+			IRQENABLE_MCUBOUNDSINT));
+	sr_write_reg(sr, IRQSTATUS, (IRQSTATUS_MCUACCUMINT |
+			IRQSTATUS_MCVALIDINT |
+			IRQSTATUS_MCBOUNDSINT));
+
+	/*
+	 * Wait for SR to be disabled.
+	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
+			IRQSTATUS_MCUDISABLEACKINT), SR_DISABLE_TIMEOUT,
+			timeout);
+
+	if (timeout >= SR_DISABLE_TIMEOUT)
+		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
+			__func__);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
+	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
+	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
+}
+
+static int _configure_minmax(struct smartreflex *sr)
+{
+	/*
+	 * Enabling the interrupts if MINMAXAVG module is used.
+	 * TODO: check if all the interrupts are mandatory
+	 */
+	sr_write_reg(sr, IRQSTATUS,
+		IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
+		IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
+	sr_write_reg(sr, IRQENABLE_SET,
+		IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
+		IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
+
+	return 0;
+}
+
+static int __init sr_probe(struct platform_device *pdev)
+{
+	struct smartreflex *sr = kzalloc(sizeof(struct smartreflex), GFP_KERNEL);
+	struct smartreflex_platform_data *pdata = pdev->dev.platform_data;
+	u32 srclklength;
+	u8 senn_shift, senp_shift;
+	int ret = 0;
+
+	if (!sr) {
+		dev_err(&pdev->dev, "%s: unable to allocate sr\n", __func__);
+		return -ENOMEM;
+	}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		ret = -EINVAL;
+		goto err_free_devinfo;
+	}
+
+	srclklength = sr_calculate_clk_length(sr);
+
+	sr->proto_sr_config = (srclklength << SRCONFIG_SRCLKLENGTH_SHIFT) |
+		SRCONFIG_SENENABLE;
+
+	senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
+	senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
+	sr->errconfig_offs = ERRCONFIG_V2;
+	sr->errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
+	sr->vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
+	sr->vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
+
+	sr->proto_sr_config |= ((pdata->senn_mod << senn_shift) |
+				(pdata->senp_mod << senp_shift));
+
+	sr->isr = _interrupt;
+	sr->disable = _disable;
+	sr->configure_minmax = _configure_minmax;
+
+	ret = sr_common_probe(pdev, sr);
+
+	return ret;
+
+err_free_devinfo:
+	kfree(sr);
+
+	return ret;
+}
+
+static struct platform_driver smartreflex_driver = {
+	.remove		= sr_remove,
+	.driver		= {
+		.name	= "smartreflex-v2",
+	},
+};
+
+/*
+ * SmartReflex IP v2 is the update from v1 for the 45nm version of the IP
+ * used in OMAP3630 and OMAP4430
+ */
+static int __init sr_init(void)
+{
+	int ret = 0;
+
+	if (!(cpu_is_omap3630() || cpu_is_omap44xx()))
+		return -ENODEV;
+
+	ret = platform_driver_probe(&smartreflex_driver, sr_probe);
+	if (ret) {
+		pr_err("%s: platform driver register failed for SR\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit sr_exit(void)
+{
+	platform_driver_unregister(&smartreflex_driver);
+}
+late_initcall(sr_init);
+module_exit(sr_exit);
+
+MODULE_DESCRIPTION("SmartReflex v2 device driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
-- 
1.7.5.4

