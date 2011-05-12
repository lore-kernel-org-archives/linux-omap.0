From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Thu, 12 May 2011 13:02:18 -0500
Message-ID: <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49773 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932198Ab1ELSCl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 14:02:41 -0400
Received: by mail-ww0-f51.google.com with SMTP id 26so1525314wwf.32
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 11:02:39 -0700 (PDT)
In-Reply-To: <1305221790-4944-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, May 12, 2011 at 12:36, Sanjeev Premi <premi@ti.com> wrote:
> There is an implicit assumption in current implementation that
> debugfs is always enabled.
thanks for doing this.
>
> When debugfs is disabled, these errors are noticed during boot:
> =A0omap_voltage_late_init: Unable to create voltage debugfs main dir
> =A0vdd_debugfs_init: Unable to create debugfs directory for vdd_mpu
> =A0vdd_debugfs_init: Unable to create debugfs directory for vdd_core
>
> This patch fixes these errors by enclosing code related to debugfs
> in #ifdef CONFIG_DEBUG_FS..#endif.

generic - couple of comments - I think the #defs should be isolated
off to headers - maybe the right approach may be to move the debugfs
entries off to a separate file? or pm-debug.c??

>
> Boot tested on OMAP3EVM.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> =A0Patch was created and tested on the pm branch at commit:
> =A0 d695569 : rebuild PM from branches

Could I suggest Kevin's volt cleanup series - based off _c branch if
there are cleanups to be done?

>
> =A0I am still finding my way around new code sructure. Haven't
> =A0been able to verify if smartreflex and voltage layer are
> =A0properly initialized. Though I do understand that smartreflex
> =A0won't work without debugfs.
>

Last I tried, with Vishwa's dvfs branch on panda without voltage
registrations, things could crash :( if I get some time I will try to
port Vishwa's series onto kevin's branch as well and test and provide
any patches necessary.


> =A0arch/arm/mach-omap2/smartreflex.c | =A0 15 +++++++++++++++
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 | =A0 =A08 ++++++++
> =A02 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/=
smartreflex.c
> index 2ce2fb7..b757632 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -54,7 +54,9 @@ struct omap_sr {
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node;
> =A0 =A0 =A0 =A0struct omap_sr_nvalue_table =A0 =A0 *nvalue_table;
> =A0 =A0 =A0 =A0struct voltagedomain =A0 =A0 =A0 =A0 =A0 =A0*voltdm;
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dbg=
_dir;
> +#endif
> =A0};
>
> =A0/* sr_list contains all the instances of smartreflex module */
> @@ -826,7 +828,9 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0struct omap_sr *sr_info =3D kzalloc(sizeof(struct omap=
_sr), GFP_KERNEL);
> =A0 =A0 =A0 =A0struct omap_sr_data *pdata =3D pdev->dev.platform_data=
;
> =A0 =A0 =A0 =A0struct resource *mem, *irq;
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0struct dentry *vdd_dbg_dir, *nvalue_dir;
> +#endif
> =A0 =A0 =A0 =A0struct omap_volt_data *volt_data;
> =A0 =A0 =A0 =A0int i, ret =3D 0;
>
> @@ -903,6 +907,7 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 * If the voltage domain debugfs directory is not crea=
ted, do
> =A0 =A0 =A0 =A0 * not try to create rest of the debugfs entries.
> =A0 =A0 =A0 =A0 */
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0vdd_dbg_dir =3D omap_voltage_get_dbgdir(sr_info->voltd=
m);
> =A0 =A0 =A0 =A0if (!vdd_dbg_dir) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> @@ -952,14 +957,22 @@ static int __init omap_sr_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void) debugfs_create_x32(name, S_IRUG=
O | S_IWUSR, nvalue_dir,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&(sr_i=
nfo->nvalue_table[i].nvalue));
> =A0 =A0 =A0 =A0}
> +#else
> + =A0 =A0 =A0 omap_voltage_get_volttable(sr_info->voltdm, &volt_data)=
;
> + =A0 =A0 =A0 if (!volt_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODATA;
> + =A0 =A0 =A0 }
> +#endif /* CONFIG_DEBUG_FS */
>
> =A0 =A0 =A0 =A0return ret;
>
> +#ifdef CONFIG_DEBUG_FS
> =A0err_debugfs:
> =A0 =A0 =A0 =A0debugfs_remove_recursive(sr_info->dbg_dir);
> =A0err_iounmap:
> =A0 =A0 =A0 =A0list_del(&sr_info->node);
> =A0 =A0 =A0 =A0iounmap(sr_info->base);
> +#endif
> =A0err_release_region:
> =A0 =A0 =A0 =A0release_mem_region(mem->start, resource_size(mem));
> =A0err_free_devinfo:
> @@ -988,8 +1001,10 @@ static int __devexit omap_sr_remove(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0if (sr_info->autocomp_active)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr_stop_vddautocomp(sr_info);
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0if (sr_info->dbg_dir)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0debugfs_remove_recursive(sr_info->dbg_=
dir);
> +#endif
>
> =A0 =A0 =A0 =A0list_del(&sr_info->node);
> =A0 =A0 =A0 =A0iounmap(sr_info->base);
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 9ef3789..6153211 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -250,6 +250,7 @@ static void __init vp_init(struct omap_vdd_info *=
vdd)
> =A0 =A0 =A0 =A0vdd->write_reg(vp_val, prm_mod_offs, vdd->vp_data->vli=
mitto);
> =A0}
>
> +#ifdef CONFIG_DEBUG_FS
> =A0static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
> =A0{
> =A0 =A0 =A0 =A0char *name;
> @@ -297,6 +298,7 @@ static void __init vdd_debugfs_init(struct omap_v=
dd_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->d=
ebug_dir, (void *) vdd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom_v=
olt_debug_fops);
> =A0}
> +#endif
>
> =A0/* Voltage scale and accessory APIs */
> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
> @@ -980,6 +982,7 @@ int omap_voltage_register_pmic(struct voltagedoma=
in *voltdm,
> =A0* add any debug entry for a particular voltage domain. Returns NUL=
L
> =A0* in case of error.
> =A0*/
> +#ifdef CONFIG_DEBUG_FS
> =A0struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltd=
m)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
> @@ -993,6 +996,7 @@ struct dentry *omap_voltage_get_dbgdir(struct vol=
tagedomain *voltdm)
>
> =A0 =A0 =A0 =A0return vdd->debug_dir;
> =A0}
> +#endif
>
> =A0/**
> =A0* omap_change_voltscale_method() - API to change the voltage scali=
ng method.
> @@ -1078,16 +1082,20 @@ int __init omap_voltage_late_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0voltage_dir =3D debugfs_create_dir("voltage", NULL);
> =A0 =A0 =A0 =A0if (IS_ERR(voltage_dir))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Unable to create voltage d=
ebugfs main dir\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> +#endif
> =A0 =A0 =A0 =A0for (i =3D 0; i < nr_scalable_vdd; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (omap_vdd_data_configure(vdd_info[i=
]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_vc_init(vdd_info[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vp_init(vdd_info[i]);
> +#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_debugfs_init(vdd_info[i]);
> +#endif
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
