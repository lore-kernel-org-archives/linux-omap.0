From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv5 09/10] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Thu, 16 Dec 2010 16:58:37 -0800
Message-ID: <87ipyt9pvm.fsf@deeprootsystems.com>
References: <1292004181-4804-1-git-send-email-thara@ti.com>
	<1292004181-4804-10-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:52210 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab0LQA6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 19:58:42 -0500
Received: by pxi20 with SMTP id 20so33147pxi.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 16:58:42 -0800 (PST)
In-Reply-To: <1292004181-4804-10-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 10 Dec 2010 23:33:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds debug support to the voltage and smartreflex drivers.
> This means a whole bunch of voltage processor and smartreflex
> parameters are now visible through the pm debugfs.
> The voltage parameters can be viewed at
>         /debug/voltage/vdd_<x>/<parameter>
> and the smartreflex parameters can be viewed at
>         /debug/voltage/vdd_<x>/smartreflex/<parameter>
>
> Also smartreflex n-target values are now exposed out at
> 	/debug/voltage/vdd_<x>/smartreflex/nvalue/<voltage>
>
> This is a read-write interface which means user has the
> flexibility to change the n-target values for any opp.

I think this comment needs updating, since the write
interface is now removed from this series as we agreed upon.

Kevin

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   46 ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/voltage.c     |   66 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index eee23d0..52a05b3 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -31,6 +31,7 @@
>  #include "pm.h"
>  
>  #define SMARTREFLEX_NAME_LEN	16
> +#define NVALUE_NAME_LEN		40
>  #define SR_DISABLE_TIMEOUT	200
>  
>  struct omap_sr {
> @@ -817,8 +818,9 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
>  	struct omap_sr_data *pdata = pdev->dev.platform_data;
>  	struct resource *mem, *irq;
> -	struct dentry *vdd_dbg_dir, *dbg_dir;
> -	int ret = 0;
> +	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
> +	struct omap_volt_data *volt_data;
> +	int i, ret = 0;
>  
>  	if (!sr_info) {
>  		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
> @@ -897,6 +899,46 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  
>  	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
>  				(void *)sr_info, &pm_sr_fops);
> +	(void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
> +			&sr_info->err_weight);
> +	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
> +			&sr_info->err_maxlimit);
> +	(void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
> +			&sr_info->err_minlimit);
> +
> +	nvalue_dir = debugfs_create_dir("nvalue", dbg_dir);
> +	if (IS_ERR(nvalue_dir)) {
> +		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
> +			"for n-values\n", __func__);
> +		return PTR_ERR(nvalue_dir);
> +	}
> +
> +	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
> +	if (!volt_data) {
> +		dev_warn(&pdev->dev, "%s: No Voltage table for the"
> +			" corresponding vdd vdd_%s. Cannot create debugfs"
> +			"entries for n-values\n",
> +			__func__, sr_info->voltdm->name);
> +		return -ENODATA;
> +	}
> +
> +	for (i = 0; i < sr_info->nvalue_count; i++) {
> +		char *name;
> +		char volt_name[32];
> +
> +		name = kzalloc(NVALUE_NAME_LEN + 1, GFP_KERNEL);
> +		if (!name) {
> +			dev_err(&pdev->dev, "%s: Unable to allocate memory"
> +				" for n-value directory name\n",  __func__);
> +			return -ENOMEM;
> +		}
> +
> +		strcpy(name, "volt_");
> +		sprintf(volt_name, "%d", volt_data[i].volt_nominal);
> +		strcat(name, volt_name);
> +		(void) debugfs_create_x32(name, S_IRUGO | S_IWUGO, nvalue_dir,
> +				&(sr_info->nvalue_table[i].nvalue));
> +	}
>  
>  	return ret;
>  
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 4ecdc68..1f84939 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -238,6 +238,47 @@ static struct dentry *voltage_dir;
>  static void (*vc_init) (struct omap_vdd_info *vdd);
>  static void (*vdd_data_configure) (struct omap_vdd_info *vdd);
>  
> +/* Voltage debugfs support */
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
> +	vsel = prm_read_mod_reg(vdd->vp_reg.prm_mod, vdd->vp_offs.voltage);
> +	pr_notice("curr_vsel = %x\n", vsel);
> +
> +	if (!vdd->pmic_info->vsel_to_uv) {
> +		pr_warning("PMIC function to convert vsel to voltage"
> +			"in uV not registerd\n");
> +		return -EINVAL;
> +	}
> +
> +	*val = vdd->pmic_info->vsel_to_uv(vsel);
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
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL, "%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
> +								"%llu\n");
>  static void vp_latch_vsel(struct omap_vdd_info *vdd)
>  {
>  	u32 vpconfig;
> @@ -331,7 +372,32 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  		pr_warning("%s: Unable to create debugfs directory for"
>  			" vdd_%s\n", __func__, vdd->voltdm.name);
>  		vdd->debug_dir = NULL;
> +		return;
>  	}
> +
> +	(void) debugfs_create_x16("vp_errorgain", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vpconfig_errorgain));
> +	(void) debugfs_create_x16("vp_smpswaittimemin", S_IRUGO,
> +				vdd->debug_dir,
> +				&(vdd->vp_reg.vstepmin_smpswaittimemin));
> +	(void) debugfs_create_x8("vp_stepmin", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vstepmin_stepmin));
> +	(void) debugfs_create_x16("vp_smpswaittimemax", S_IRUGO,
> +				vdd->debug_dir,
> +				&(vdd->vp_reg.vstepmax_smpswaittimemax));
> +	(void) debugfs_create_x8("vp_stepmax", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vstepmax_stepmax));
> +	(void) debugfs_create_x8("vp_vddmax", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vlimitto_vddmax));
> +	(void) debugfs_create_x8("vp_vddmin", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vlimitto_vddmin));
> +	(void) debugfs_create_x16("vp_timeout", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vp_reg.vlimitto_timeout));
> +	(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd->debug_dir,
> +				(void *) vdd, &vp_volt_debug_fops);
> +	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
> +				vdd->debug_dir, (void *) vdd,
> +				&nom_volt_debug_fops);
>  }
>  
>  /* Voltage scale and accessory APIs */
