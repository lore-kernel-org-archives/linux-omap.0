From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH] OMAP: device: make rt_va easily avaialable to drivers
Date: Thu, 9 Dec 2010 16:15:19 -0600
Message-ID: <AANLkTi=_xRUX_jGwWUzUnGrCZ7pdi23PAKCtoYC+0XtK@mail.gmail.com>
References: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:55084 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab0LIWPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 17:15:21 -0500
Received: by gxk19 with SMTP id 19so1810663gxk.11
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 14:15:21 -0800 (PST)
In-Reply-To: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 8, 2010 at 5:59 PM, Omar Ramirez Luna <omar.ramirez@ti.com>=
 wrote:
> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1]=
,
> introduces omap_device_get_rt_va which is meant to be called
> by drivers to retrieve the _mpu_rt_va, however this function
> receives a pointer to an omap_device; since there is no
> practical way for a driver to get this parameter without
> fiddling with pdev and container_of macro, and omap_device code
> already does this, it is better for it to handle this case.
>
> Also moved header declaration to appear in the set of
> functions to be used by drivers, as per the comment there.
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D127808467703366&w=3D2
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---

Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>

> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A03 +--
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A08 ++++++--
> =A02 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm=
/plat-omap/include/plat/omap_device.h
> index 28e2d1a..1877c1a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -80,6 +80,7 @@ struct omap_device {
> =A0int omap_device_enable(struct platform_device *pdev);
> =A0int omap_device_idle(struct platform_device *pdev);
> =A0int omap_device_shutdown(struct platform_device *pdev);
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev);
>
> =A0/* Core code interface */
>
> @@ -101,8 +102,6 @@ struct omap_device *omap_device_build_ss(const ch=
ar *pdev_name, int pdev_id,
> =A0int omap_device_register(struct omap_device *od);
> =A0int omap_early_device_register(struct omap_device *od);
>
> -void __iomem *omap_device_get_rt_va(struct omap_device *od);
> -
> =A0/* OMAP PM interface */
> =A0int omap_device_align_pm_lat(struct platform_device *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 new_wakeu=
p_lat_limit);
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index abe933c..9d11195 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -681,7 +681,7 @@ struct powerdomain *omap_device_get_pwrdm(struct =
omap_device *od)
>
> =A0/**
> =A0* omap_device_get_mpu_rt_va - return the MPU's virtual addr for th=
e hwmod base
> - * @od: struct omap_device *
> + * @pdev: struct platform_device *
> =A0*
> =A0* Return the MPU's virtual address for the base of the hwmod, from
> =A0* the ioremap() that the hwmod code does. =A0Only valid if there i=
s one
> @@ -690,8 +690,12 @@ struct powerdomain *omap_device_get_pwrdm(struct=
 omap_device *od)
> =A0* otherwise, passes along the return value from
> =A0* omap_hwmod_get_mpu_rt_va().
> =A0*/
> -void __iomem *omap_device_get_rt_va(struct omap_device *od)
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct omap_device *od;
> +
> + =A0 =A0 =A0 od =3D _find_by_pdev(pdev);
> +
> =A0 =A0 =A0 =A0if (od->hwmods_cnt !=3D 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
