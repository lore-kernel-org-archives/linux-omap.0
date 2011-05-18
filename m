From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 18:34:18 +0200
Message-ID: <87fwocrmr9.fsf@ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35010 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756834Ab1ERQen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 12:34:43 -0400
Received: by wye20 with SMTP id 20so1572899wye.20
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 09:34:32 -0700 (PDT)
In-Reply-To: <1305221790-4944-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Thu, 12 May 2011 23:06:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> There is an implicit assumption in current implementation that
> debugfs is always enabled.
>
> When debugfs is disabled, these errors are noticed during boot:
>   omap_voltage_late_init: Unable to create voltage debugfs main dir
>   vdd_debugfs_init: Unable to create debugfs directory for vdd_mpu
>   vdd_debugfs_init: Unable to create debugfs directory for vdd_core
>
> This patch fixes these errors by enclosing code related to debugfs
> in #ifdef CONFIG_DEBUG_FS..#endif.
>
> Boot tested on OMAP3EVM.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Sorry for the delay here, I've been on the road and finally catching up
on the list.

Basically, I'm in the process of a pretty major cleanup of the VC/VP and
SR layers.  For example, in my pm-wip/voltdm_* branches, the debugfs
interface to the voltage layer has been completely removed.  I'm also
thinking of removing the SR debugfs interface also, as I don't really
think we need a userspace interface for this.  A board-level interface
is probably enough (/me waits for flame from Nishanth :)

That being said, your approach below isn't quite right in its usage of
#ifdefs.  Use of #ifdefs like this is frowned upon for many reasons.
For starters, take a look the '#ifdefs are ugly' section of
Documentation/SubmittingPatches.

Kevin

> ---
>  Patch was created and tested on the pm branch at commit:
>    d695569 : rebuild PM from branches
>
>  I am still finding my way around new code sructure. Haven't
>  been able to verify if smartreflex and voltage layer are
>  properly initialized. Though I do understand that smartreflex
>  won't work without debugfs.
>
>  arch/arm/mach-omap2/smartreflex.c |   15 +++++++++++++++
>  arch/arm/mach-omap2/voltage.c     |    8 ++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 2ce2fb7..b757632 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -54,7 +54,9 @@ struct omap_sr {
>  	struct list_head		node;
>  	struct omap_sr_nvalue_table	*nvalue_table;
>  	struct voltagedomain		*voltdm;
> +#ifdef CONFIG_DEBUG_FS
>  	struct dentry			*dbg_dir;
> +#endif
>  };
>  
>  /* sr_list contains all the instances of smartreflex module */
> @@ -826,7 +828,9 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
>  	struct omap_sr_data *pdata = pdev->dev.platform_data;
>  	struct resource *mem, *irq;
> +#ifdef CONFIG_DEBUG_FS
>  	struct dentry *vdd_dbg_dir, *nvalue_dir;
> +#endif
>  	struct omap_volt_data *volt_data;
>  	int i, ret = 0;
>  
> @@ -903,6 +907,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	 * If the voltage domain debugfs directory is not created, do
>  	 * not try to create rest of the debugfs entries.
>  	 */
> +#ifdef CONFIG_DEBUG_FS
>  	vdd_dbg_dir = omap_voltage_get_dbgdir(sr_info->voltdm);
>  	if (!vdd_dbg_dir) {
>  		ret = -EINVAL;
> @@ -952,14 +957,22 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
>  				&(sr_info->nvalue_table[i].nvalue));
>  	}
> +#else
> +	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
> +	if (!volt_data) {
> +		ret = -ENODATA;
> +	}
> +#endif /* CONFIG_DEBUG_FS */
>  
>  	return ret;
>  
> +#ifdef CONFIG_DEBUG_FS
>  err_debugfs:
>  	debugfs_remove_recursive(sr_info->dbg_dir);
>  err_iounmap:
>  	list_del(&sr_info->node);
>  	iounmap(sr_info->base);
> +#endif
>  err_release_region:
>  	release_mem_region(mem->start, resource_size(mem));
>  err_free_devinfo:
> @@ -988,8 +1001,10 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
> +#ifdef CONFIG_DEBUG_FS
>  	if (sr_info->dbg_dir)
>  		debugfs_remove_recursive(sr_info->dbg_dir);
> +#endif
>  
>  	list_del(&sr_info->node);
>  	iounmap(sr_info->base);
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 9ef3789..6153211 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -250,6 +250,7 @@ static void __init vp_init(struct omap_vdd_info *vdd)
>  	vdd->write_reg(vp_val, prm_mod_offs, vdd->vp_data->vlimitto);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
>  static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  {
>  	char *name;
> @@ -297,6 +298,7 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  				vdd->debug_dir, (void *) vdd,
>  				&nom_volt_debug_fops);
>  }
> +#endif
>  
>  /* Voltage scale and accessory APIs */
>  static int _pre_volt_scale(struct omap_vdd_info *vdd,
> @@ -980,6 +982,7 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>   * add any debug entry for a particular voltage domain. Returns NULL
>   * in case of error.
>   */
> +#ifdef CONFIG_DEBUG_FS
>  struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm)
>  {
>  	struct omap_vdd_info *vdd;
> @@ -993,6 +996,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm)
>  
>  	return vdd->debug_dir;
>  }
> +#endif
>  
>  /**
>   * omap_change_voltscale_method() - API to change the voltage scaling method.
> @@ -1078,16 +1082,20 @@ int __init omap_voltage_late_init(void)
>  		return -EINVAL;
>  	}
>  
> +#ifdef CONFIG_DEBUG_FS
>  	voltage_dir = debugfs_create_dir("voltage", NULL);
>  	if (IS_ERR(voltage_dir))
>  		pr_err("%s: Unable to create voltage debugfs main dir\n",
>  			__func__);
> +#endif
>  	for (i = 0; i < nr_scalable_vdd; i++) {
>  		if (omap_vdd_data_configure(vdd_info[i]))
>  			continue;
>  		omap_vc_init(vdd_info[i]);
>  		vp_init(vdd_info[i]);
> +#ifdef CONFIG_DEBUG_FS
>  		vdd_debugfs_init(vdd_info[i]);
> +#endif
>  	}
>  
>  	return 0;
