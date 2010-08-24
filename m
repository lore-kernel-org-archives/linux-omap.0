From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 8/8] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Tue, 24 Aug 2010 16:53:13 -0700
Message-ID: <87lj7vk1p2.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-9-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53401 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab0HXXxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 19:53:16 -0400
Received: by pvg2 with SMTP id 2so3269pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 16:53:16 -0700 (PDT)
In-Reply-To: <1281707231-3026-9-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds debug support to the voltage and smartreflex drivers.
> This means a whole bunch of voltage processor and smartreflex
> parameters are now visible through the pm debugfs. By default
> only a read of these parameters are permitted. If you need to
> write into them then
> 	echo 1 > /pm_debug/enable_sr_vp_debug
>
> The voltage parameters can be viewed at
> 	/pm_debug/voltage/vdd_<x>/<parameter>
> and the smartreflex parameters can be viewed at
> 	/pm_debug/smartreflex/sr_<x>/<parameter>
>
> where <x> is mpu or core for OMAP3.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c                |   13 ++
>  arch/arm/mach-omap2/smartreflex.c             |   40 ++++++-
>  arch/arm/mach-omap2/voltage.c                 |  164 ++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/smartreflex.h |    1 -
>  arch/arm/plat-omap/include/plat/voltage.h     |    5 +
>  5 files changed, 216 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index fed8da1..b748baa 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -31,6 +31,7 @@
>  #include <plat/board.h>
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
> +#include <plat/voltage.h>
>  
>  #include "prm.h"
>  #include "cm.h"
> @@ -556,6 +557,16 @@ static int option_set(void *data, u64 val)
>  	if (option == &enable_off_mode)
>  		omap3_pm_off_mode_enable(val);
>  
> +	if (option == &enable_sr_vp_debug && val)
> +		pr_notice("Beware that enabling this option will allow user "
> +			"to override the system defined vp and sr parameters "
> +			"All the updated parameters will take effect next "
> +			"time smartreflex is enabled. Also this option "
> +			"disables the automatic vp errorgain and sr errormin "
> +			"limit changes as per the voltage. Users will have "
> +			"to explicitly write values into the debug fs "
> +			"entries corresponding to these if they want to see "
> +			"them changing according to the VDD voltage\n");
>  	return 0;
>  }
>  
> @@ -609,6 +620,8 @@ static int __init pm_dbg_init(void)
>  				   &sleep_while_idle, &pm_dbg_option_fops);
>  	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
>  				   &wakeup_timer_seconds, &pm_dbg_option_fops);
> +	(void) debugfs_create_file("enable_sr_vp_debug",  S_IRUGO | S_IWUGO, d,
> +				   &enable_sr_vp_debug, &pm_dbg_option_fops);
>  	pm_dbg_main_dir = d;
>  	pm_dbg_init_done = 1;
>  
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 1c871ae..bc611d1 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -547,8 +547,13 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
>  		return -ENODATA;
>  	}
>  
> -	/* errminlimit is opp dependent and hence linked to voltage */
> -	sr->err_minlimit = volt_data->sr_errminlimit;
> +	/*
> +	 * errminlimit is opp dependent and hence linked to voltage
> +	 * if the debug option is enabled, the user might have over ridden
> +	 * this parameter so do not get it from voltage table
> +	 */
> +	if (!enable_sr_vp_debug)
> +		sr->err_minlimit = volt_data->sr_errminlimit;
>  
>  	/* Enable the clocks */
>  	if (!sr->is_sr_enable) {
> @@ -812,8 +817,32 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>  	return 0;
>  }
>  
> +static int omap_sr_params_show(void *data, u64 *val)
> +{
> +	u32 *param = data;
> +
> +	*val = *param;
> +	return 0;
> +}
> +
> +static int omap_sr_params_store(void *data, u64 val)
> +{
> +	if (enable_sr_vp_debug) {
> +		u32 *option = data;
> +		*option = val;
> +	} else {
> +		pr_notice("%s: DEBUG option not enabled!\n	\
> +			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n",
> +			__func__);
> +	}
> +	return 0;
> +}
> +
>  DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
>  		omap_sr_autocomp_store, "%llu\n");
> +
> +DEFINE_SIMPLE_ATTRIBUTE(sr_params_fops, omap_sr_params_show,
> +		omap_sr_params_store, "%llu\n");
>  #endif
>  
>  static int __init omap_smartreflex_probe(struct platform_device *pdev)
> @@ -884,6 +913,13 @@ static int __init omap_smartreflex_probe(struct platform_device *pdev)
>  	dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
>  	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
>  				(void *)sr_info, &pm_sr_fops);
> +	(void) debugfs_create_file("errweight", S_IRUGO | S_IWUGO, dbg_dir,
> +				&sr_info->err_weight, &sr_params_fops);
> +	(void) debugfs_create_file("errmaxlimit", S_IRUGO | S_IWUGO, dbg_dir,
> +				&sr_info->err_maxlimit, &sr_params_fops);
> +	(void) debugfs_create_file("errminlimit", S_IRUGO | S_IWUGO, dbg_dir,
> +				&sr_info->err_minlimit, &sr_params_fops);
> +
>  #endif
>  
>  	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index cb0fcac..d15c5cb 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -23,6 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/debugfs.h>
>  
>  #include <plat/omap-pm.h>
>  #include <plat/omap34xx.h>
> @@ -37,6 +38,13 @@
>  #define VP_IDLE_TIMEOUT		200
>  #define VP_TRANXDONE_TIMEOUT	300
>  
> +#ifdef CONFIG_PM_DEBUG
> +static struct dentry *voltage_dir;
> +#endif
> +
> +/* VP SR debug support */
> +u32 enable_sr_vp_debug;
> +
>  /* PRM voltage module */
>  static u32 volt_mod;
>  
> @@ -228,6 +236,73 @@ static inline void voltage_write_reg(u8 offset, u32 value)
>  	prm_write_mod_reg(value, volt_mod, offset);
>  }
>  
> +/* Voltage debugfs support */
> +#ifdef CONFIG_PM_DEBUG
> +static int vp_debug_get(void *data, u64 *val)
> +{
> +	u16 *option = data;
> +
> +	if (!option) {
> +		pr_warning("Wrong paramater passed\n");
> +		return -EINVAL;
> +	}
> +
> +	*val = *option;
> +	return 0;
> +}
> +
> +static int vp_debug_set(void *data, u64 val)
> +{
> +	if (enable_sr_vp_debug) {
> +		u32 *option = data;
> +		if (!option) {
> +			pr_warning("Wrong paramater passed\n");
> +			return -EINVAL;
> +		}
> +		*option = val;
> +	} else {
> +		pr_notice("DEBUG option not enabled!"
> +			"echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
> +	}
> +	return 0;
> +}
> +
> +static int vp_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
> +	u8 vsel;
> +
> +	if (!vdd) {
> +		pr_warning("Wrong paramater passed\n");
> +		return -EINVAL;
> +	}
> +
> +	vsel = voltage_read_reg(vdd->vp_offs.voltage);
> +	pr_notice("curr_vsel = %x\n", vsel);
> +	*val = omap_twl_vsel_to_uv(vsel);
> +
> +	return 0;
> +}
> +
> +static int nom_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
> +
> +	if (!vdd) {
> +		pr_warning("Wrong paramater passed\n");
> +		return -EINVAL;
> +	}
> +
> +	*val = omap_voltage_get_nom_volt(&vdd->voltdm);
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(vp_debug_fops, vp_debug_get, vp_debug_set, "%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
> +								"%llu\n");
> +#endif
> +
>  static void vp_latch_vsel(struct omap_vdd_info *vdd)
>  {
>  	u32 vpconfig;
> @@ -480,8 +555,49 @@ static void __init init_voltageprocessor(struct omap_vdd_info *vdd)
>  
>  static void __init vdd_data_configure(struct omap_vdd_info *vdd)
>  {
> +#ifdef CONFIG_PM_DEBUG
> +	struct dentry *vdd_debug;
> +	char name[16];
> +#endif
>  	if (cpu_is_omap34xx())
>  		omap3_vdd_data_configure(vdd);
> +
> +#ifdef CONFIG_PM_DEBUG

I'd rather just drop the #ifdefs here and make this conditional on the
existence of 'voltage_dir'.  More on this below...

> +	strcpy(name, "vdd_");
> +	strcat(name, vdd->voltdm.name);
> +	vdd_debug = debugfs_create_dir(name, voltage_dir);
> +	(void) debugfs_create_file("vp_errorgain", S_IRUGO | S_IWUGO,
> +				vdd_debug,
> +				&(vdd->vp_reg.vpconfig_errorgain),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_smpswaittimemin", S_IRUGO | S_IWUGO,
> +				vdd_debug,
> +				&(vdd->vp_reg.vstepmin_smpswaittimemin),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_stepmin", S_IRUGO | S_IWUGO, vdd_debug,
> +				&(vdd->vp_reg.vstepmin_stepmin),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_smpswaittimemax", S_IRUGO | S_IWUGO,
> +				vdd_debug,
> +				&(vdd->vp_reg.vstepmax_smpswaittimemax),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_stepmax", S_IRUGO | S_IWUGO, vdd_debug,
> +				&(vdd->vp_reg.vstepmax_stepmax),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_vddmax", S_IRUGO | S_IWUGO, vdd_debug,
> +				&(vdd->vp_reg.vlimitto_vddmax),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_vddmin", S_IRUGO | S_IWUGO, vdd_debug,
> +				&(vdd->vp_reg.vlimitto_vddmin),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("vp_timeout", S_IRUGO | S_IWUGO, vdd_debug,
> +				&(vdd->vp_reg.vlimitto_timeout),
> +				&vp_debug_fops);
> +	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd_debug,
> +				(void *) vdd, &vp_volt_debug_fops);
> +	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO, vdd_debug,
> +				(void *) vdd, &nom_volt_debug_fops);
> +#endif
>  }
>  static void __init init_voltagecontroller(void)
>  {
> @@ -541,8 +657,11 @@ static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
>  	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
>  	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
>  
> -	/* Setting vp errorgain based on the voltage */
> -	if (volt_data) {
> +	/*
> +	 * Setting vp errorgain based on the voltage. If the debug option is
> +	 * enabled allow the override of errorgain from user side
> +	 */
> +	if (!enable_sr_vp_debug && volt_data) {
>  		vp_errgain_val = voltage_read_reg(vdd->vp_offs.vpconfig);
>  		vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
>  		vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
> @@ -627,8 +746,11 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	vc_cmdval |= (target_vsel << vc_cmd_on_shift);
>  	voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
>  
> -	/* Getting  vp errorgain based on the voltage */
> -	if (volt_data)
> +	/*
> +	 * Getting  vp errorgain based on the voltage. If the debug option is
> +	 * enabled allow the override of errorgain from user side.
> +	 */
> +	if (!enable_sr_vp_debug && volt_data)
>  		vdd->vp_reg.vpconfig_errorgain =
>  					volt_data->vp_errgain;
>  	/*
> @@ -811,6 +933,37 @@ void omap_vp_enable(struct voltagedomain *voltdm)
>  	if (!voltscale_vpforceupdate)
>  		vp_latch_vsel(vdd);
>  
> +	/*
> +	 * If debug is enabled, it is likely that the following parameters
> +	 * were set from user space so rewrite them.
> +	 */
> +	if (enable_sr_vp_debug) {
> +		vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
> +		vpconfig |= (vdd->vp_reg.vpconfig_errorgain <<
> +			vdd->vp_reg.vpconfig_errorgain_shift);
> +		voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
> +
> +		voltage_write_reg(vdd->vp_offs.vstepmin,
> +			(vdd->vp_reg.vstepmin_smpswaittimemin <<
> +			vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
> +			(vdd->vp_reg.vstepmin_stepmin <<
> +			vdd->vp_reg.vstepmin_stepmin_shift));
> +
> +		voltage_write_reg(vdd->vp_offs.vstepmax,
> +			(vdd->vp_reg.vstepmax_smpswaittimemax <<
> +			vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
> +			(vdd->vp_reg.vstepmax_stepmax <<
> +			vdd->vp_reg.vstepmax_stepmax_shift));
> +
> +		voltage_write_reg(vdd->vp_offs.vlimitto,
> +			(vdd->vp_reg.vlimitto_vddmax <<
> +			vdd->vp_reg.vlimitto_vddmax_shift) |
> +			(vdd->vp_reg.vlimitto_vddmin <<
> +			vdd->vp_reg.vlimitto_vddmin_shift) |
> +			(vdd->vp_reg.vlimitto_timeout <<
> +			vdd->vp_reg.vlimitto_timeout_shift));
> +	}
> +
>  	vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
>  	/* Enable VP */
>  	voltage_write_reg(vdd->vp_offs.vpconfig,
> @@ -1104,6 +1257,9 @@ static int __init omap_voltage_init(void)
>  		return 0;
>  	}
>  
> +#ifdef CONFIG_PM_DEBUG
> +	voltage_dir = debugfs_create_dir("voltage", pm_dbg_main_dir);
> +#endif

This also depends on CONFIG_DEBUG_FS.   

>  	if (cpu_is_omap34xx()) {
>  		volt_mod = OMAP3430_GR_MOD;
>  		vdd_info = omap3_vdd_info;
> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
> index 8954c86..08f7d07 100644
> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
> @@ -24,7 +24,6 @@
>  #include <plat/voltage.h>
>  
>  #ifdef CONFIG_PM_DEBUG
> -extern struct dentry *pm_dbg_main_dir;
>  extern struct dentry *sr_dbg_dir;
>  #endif
>  
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index fc9778b..c6fe2d6 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -14,6 +14,11 @@
>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  
> +extern u32 enable_sr_vp_debug;
> +#ifdef CONFIG_PM_DEBUG
> +extern struct dentry *pm_dbg_main_dir;
> +#endif

Ah, now I see where this is included from.     This should be part of
the patch that makes this global (PATCH 1/8).


>  #define VOLTSCALE_VPFORCEUPDATE		1
>  #define VOLTSCALE_VCBYPASS		2

Kevin
