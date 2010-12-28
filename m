From: Anand Sawant <sawant@ti.com>
Subject: RE: [PATCH v6 09/10] OMAP3: PM: Adding debug support to Voltage and
 Smartreflex drivers
Date: Tue, 28 Dec 2010 22:37:49 +0530
Message-ID: <1b7fd98d1f8cf358cdc712da05f30a34@mail.gmail.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com> <1292864357-13939-10-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60994 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753242Ab0L1RHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Dec 2010 12:07:51 -0500
Received: by gwj20 with SMTP id 20so4371054gwj.36
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 09:07:50 -0800 (PST)
In-Reply-To: <1292864357-13939-10-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Nishanth Menon <nm@ti.com>

Thara,

Few comments on the changes in voltage layer ...

> -----Original Message-----
> From: Thara Gopinath [mailto:thara@ti.com]
> Sent: Monday, December 20, 2010 10:29 PM
> To: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; b-
> cousson@ti.com; vishwanath.bs@ti.com; sawant@ti.com;
> nm@ti.com; Thara Gopinath
> Subject: [PATCH v6 09/10] OMAP3: PM: Adding debug support to
> Voltage and Smartreflex drivers
>
> This patch adds debug support to the voltage and smartreflex
> drivers.
> This means a whole bunch of voltage processor and
> smartreflex
> parameters are now visible through the pm debugfs.
> The voltage parameters can be viewed at
>         /debug/voltage/vdd_<x>/<parameter>
> and the smartreflex parameters can be viewed at
>         /debug/voltage/vdd_<x>/smartreflex/<parameter>
>
> Also smartreflex n-target values are now exposed out at
> 	/debug/voltage/vdd_<x>/smartreflex/nvalue/<voltage>
>
> The interface to access smartreflex n-target values is a
> read-write interface which means user has the flexibility
> to change the n-target values for any opp.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   46
> ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/voltage.c     |   66
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c
> b/arch/arm/mach-omap2/smartreflex.c
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
> @@ -817,8 +818,9 @@ static int __init omap_sr_probe(struct
> platform_device *pdev)
>  	struct omap_sr *sr_info = kzalloc(sizeof(struct
> omap_sr), GFP_KERNEL);
>  	struct omap_sr_data *pdata = pdev->dev.platform_data;
>  	struct resource *mem, *irq;
> -	struct dentry *vdd_dbg_dir, *dbg_dir;
> -	int ret = 0;
> +	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
> +	struct omap_volt_data *volt_data;
> +	int i, ret = 0;
>
>  	if (!sr_info) {
>  		dev_err(&pdev->dev, "%s: unable to allocate
> sr_info\n",
> @@ -897,6 +899,46 @@ static int __init omap_sr_probe(struct
> platform_device *pdev)
>
>  	(void) debugfs_create_file("autocomp", S_IRUGO |
> S_IWUGO, dbg_dir,
>  				(void *)sr_info, &pm_sr_fops);
> +	(void) debugfs_create_x32("errweight", S_IRUGO,
> dbg_dir,
> +			&sr_info->err_weight);
> +	(void) debugfs_create_x32("errmaxlimit", S_IRUGO,
> dbg_dir,
> +			&sr_info->err_maxlimit);
> +	(void) debugfs_create_x32("errminlimit", S_IRUGO,
> dbg_dir,
> +			&sr_info->err_minlimit);
> +
> +	nvalue_dir = debugfs_create_dir("nvalue", dbg_dir);
> +	if (IS_ERR(nvalue_dir)) {
> +		dev_err(&pdev->dev, "%s: Unable to create
> debugfs directory"
> +			"for n-values\n", __func__);
> +		return PTR_ERR(nvalue_dir);
> +	}
> +
> +	omap_voltage_get_volttable(sr_info->voltdm,
> &volt_data);
> +	if (!volt_data) {
> +		dev_warn(&pdev->dev, "%s: No Voltage table for
> the"
> +			" corresponding vdd vdd_%s. Cannot create
> debugfs"
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
> +			dev_err(&pdev->dev, "%s: Unable to
> allocate memory"
> +				" for n-value directory name\n",
> __func__);
> +			return -ENOMEM;
> +		}
> +
> +		strcpy(name, "volt_");
> +		sprintf(volt_name, "%d",
> volt_data[i].volt_nominal);
> +		strcat(name, volt_name);
> +		(void) debugfs_create_x32(name, S_IRUGO |
> S_IWUGO, nvalue_dir,
> +				&(sr_info->nvalue_table[i].nvalue));
> +	}
>
>  	return ret;
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> omap2/voltage.c
> index 875667f..b27fa4f 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -250,6 +250,47 @@ static void omap3_voltage_write_reg(u32
> val, u16 mod, u8 offset)
>  	omap2_prm_write_mod_reg(val, mod, offset);
>  }
>
> +/* Voltage debugfs support */

Add comment for the function.

> +static int vp_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd = (struct omap_vdd_info *)
> data;
> +	u8 vsel;
> +
> +	if (!vdd) {
> +		pr_warning("Wrong paramater passed\n");
> +		return -EINVAL;
> +	}
> +
> +	vsel = vdd->read_reg(vdd->vp_reg.prm_mod, vdd-
> >vp_offs.voltage);
> +	pr_notice("curr_vsel = %x\n", vsel);
> +
> +	if (!vdd->pmic_info->vsel_to_uv) {
> +		pr_warning("PMIC function to convert vsel to
> voltage"
> +			"in uV not registerd\n");
> +		return -EINVAL;
> +	}
> +
> +	*val = vdd->pmic_info->vsel_to_uv(vsel);
> +	return 0;
> +}
> +

Add comment for the function.

> +static int nom_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd = (struct omap_vdd_info *)
> data;
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
> +DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops,
> vp_volt_debug_get, NULL, "%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops,
> nom_volt_debug_get, NULL,
> +								"%llu\n");
>  static void vp_latch_vsel(struct omap_vdd_info *vdd)
>  {
>  	u32 vpconfig;
> @@ -349,7 +390,32 @@ static void __init
> vdd_debugfs_init(struct omap_vdd_info *vdd)
>  		pr_warning("%s: Unable to create debugfs
> directory for"
>  			" vdd_%s\n", __func__, vdd->voltdm.name);
>  		vdd->debug_dir = NULL;
> +		return;
>  	}
> +
> +	(void) debugfs_create_x16("vp_errorgain", S_IRUGO,
> vdd->debug_dir,
> +				&(vdd->vp_reg.vpconfig_errorgain));
> +	(void) debugfs_create_x16("vp_smpswaittimemin",
> S_IRUGO,
> +				vdd->debug_dir,
> +				&(vdd-
> >vp_reg.vstepmin_smpswaittimemin));
> +	(void) debugfs_create_x8("vp_stepmin", S_IRUGO, vdd-
> >debug_dir,
> +				&(vdd->vp_reg.vstepmin_stepmin));
> +	(void) debugfs_create_x16("vp_smpswaittimemax",
> S_IRUGO,
> +				vdd->debug_dir,
> +				&(vdd-
> >vp_reg.vstepmax_smpswaittimemax));
> +	(void) debugfs_create_x8("vp_stepmax", S_IRUGO, vdd-
> >debug_dir,
> +				&(vdd->vp_reg.vstepmax_stepmax));
> +	(void) debugfs_create_x8("vp_vddmax", S_IRUGO, vdd-
> >debug_dir,
> +				&(vdd->vp_reg.vlimitto_vddmax));
> +	(void) debugfs_create_x8("vp_vddmin", S_IRUGO, vdd-
> >debug_dir,
> +				&(vdd->vp_reg.vlimitto_vddmin));
> +	(void) debugfs_create_x16("vp_timeout", S_IRUGO, vdd-
> >debug_dir,
> +				&(vdd->vp_reg.vlimitto_timeout));
> +	(void) debugfs_create_file("curr_vp_volt", S_IRUGO,
> vdd->debug_dir,
> +				(void *) vdd, &vp_volt_debug_fops);
> +	(void) debugfs_create_file("curr_nominal_volt",
> S_IRUGO,
> +				vdd->debug_dir, (void *) vdd,
> +				&nom_volt_debug_fops);

Recommend to add support for vc cmdval & vc bypass_val.

Best Regards,

Anand Sawant
>  }
>
>  /* Voltage scale and accessory APIs */
> --
> 1.7.0.4
