From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Fix Memory Leaks in Smartreflex driver.
Date: Mon, 14 Feb 2011 14:29:52 +0530
Message-ID: <AANLkTikd9o421P-JQczT29Aj36hB6jgdpZwypArG2BRk@mail.gmail.com>
References: <1297165948-28386-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57257 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab1BNI7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 03:59:55 -0500
Received: by bwz12 with SMTP id 12so5063278bwz.13
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 00:59:52 -0800 (PST)
In-Reply-To: <1297165948-28386-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

Any comments on this Patch??
On Tue, Feb 8, 2011 at 5:22 PM, Shweta Gulati <shweta.gulati@ti.com> wr=
ote:
> This Patch frees all the dynamically allocated memory
> which couldn't have been released in some error hitting cases.
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
> =A0arch/arm/mach-omap2/smartreflex.c | =A0 18 ++++++++++++------
> =A01 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/=
smartreflex.c
> index d7deadf..a904625 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -282,6 +282,7 @@ error:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&sr_info->pdev->dev, "%s: ERRO=
R in registering"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"interrupt handler. Sm=
artreflex will"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not function as desir=
ed\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(sr_info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -880,7 +881,7 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D sr_late_init(sr_info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Error =
in SR late init\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -891,14 +892,17 @@ static int __init omap_sr_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0 * not try to create rest of the debugfs entries.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0vdd_dbg_dir =3D omap_voltage_get_dbgdir(sr_info->voltd=
m);
> - =A0 =A0 =A0 if (!vdd_dbg_dir)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (!vdd_dbg_dir) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0dbg_dir =3D debugfs_create_dir("smartreflex", vdd_dbg_=
dir);
> =A0 =A0 =A0 =A0if (IS_ERR(dbg_dir)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "%s: Unable to cre=
ate debugfs directory\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(dbg_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(dbg_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0(void) debugfs_create_file("autocomp", S_IRUGO | S_IWU=
GO, dbg_dir,
> @@ -914,7 +918,8 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0if (IS_ERR(nvalue_dir)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "%s: Unable to cre=
ate debugfs directory"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"for n-values\n", __fu=
nc__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(nvalue_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(nvalue_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0omap_voltage_get_volttable(sr_info->voltdm, &volt_data=
);
> @@ -923,7 +928,8 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" corresponding vdd vd=
d_%s. Cannot create debugfs"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"entries for n-values\=
n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, sr_info->vol=
tdm->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < sr_info->nvalue_count; i++) {
> --
> 1.7.0.4
>
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
