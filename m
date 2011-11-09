From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] ARM: OMAP: omap_device: Expose omap_device_{alloc,
 delete, register}
Date: Wed, 9 Nov 2011 11:34:13 +0200
Message-ID: <CAK=WgbZ=h0OdeqLmNFwz31MN+o52-2ZNisFKgnJgwVLAyTTLCw@mail.gmail.com>
References: <1318851662-637-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58441 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1KIJee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 04:34:34 -0500
Received: by iage36 with SMTP id e36so1543496iag.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Nov 2011 01:34:34 -0800 (PST)
In-Reply-To: <1318851662-637-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Cousson Benoit <b-cousson@ti.com>

Hi Kevin,

On Mon, Oct 17, 2011 at 1:41 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Expose omap_device_{alloc, delete, register} so we can use them outsi=
de
> of omap_device.c.

Can you please take this one ?

Please tell me if you want a refreshed version against 3.2-rc1.

Thanks!
Ohad.

>
> This approach allows users, which need to manipulate an archdata memb=
er
> of a device before it is registered, to do so. This is also useful
> for users who have their devices created very early so they can be us=
ed
> at ->reserve() time to reserve CMA memory.
>
> The immediate use case for this is to set the private iommu archdata
> member, which binds a device to its associated iommu controller.
> This way, generic code will be able to attach omap devices to their
> iommus, without calling any omap-specific API.
>
> With this in hand, we can further clean the existing mainline OMAP io=
mmu
> driver and its mainline users, and focus on generic IOMMU approaches
> for future users (rpmsg/remoteproc and the upcoming generic DMA API).
>
> This patch is still considered an interim solution until DT fully mat=
erializes
> for omap; at that point, this functionality will be removed as DT wil=
l
> take care of creating the devices and configuring them correctly.
>
> Tested on OMAP4 with a generic rpmsg/remoteproc that doesn't use any
> omap-specific IOMMU API anymore.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A07 +++++++
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
13 +++----------
> =A02 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm=
/plat-omap/include/plat/omap_device.h
> index 12c5b0c..28d7a38 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -100,6 +100,13 @@ struct platform_device *omap_device_build_ss(con=
st char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct omap_device_pm_latency *pm_lats,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int pm_lats_cnt, int is_early_device);
>
> +struct omap_device *omap_device_alloc(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_hwmod **ohs, int oh_cnt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_device_pm_latency *pm_lats,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int pm_lats_cnt);
> +void omap_device_delete(struct omap_device *od);
> +int omap_device_register(struct platform_device *pdev);
> +
> =A0void __iomem *omap_device_get_rt_va(struct omap_device *od);
> =A0struct device *omap_device_get_by_hwmod_name(const char *oh_name);
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index cd90bed..913179c 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -96,14 +96,7 @@
> =A0#define USE_WAKEUP_LAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0#define IGNORE_WAKEUP_LAT =A0 =A0 =A0 =A0 =A0 =A0 =A01
>
> -static int omap_device_register(struct platform_device *pdev);
> =A0static int omap_early_device_register(struct platform_device *pdev=
);
> -static struct omap_device *omap_device_alloc(struct platform_device =
*pdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_hwmod **ohs, int oh_cnt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct omap_device_pm_latency *pm_lats,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int pm_lats_cnt);
> -static void omap_device_delete(struct omap_device *od);
> -
>
> =A0static struct omap_device_pm_latency omap_default_latency[] =3D {
> =A0 =A0 =A0 =A0{
> @@ -508,7 +501,7 @@ static int omap_device_fill_resources(struct omap=
_device *od,
> =A0*
> =A0* Returns an struct omap_device pointer or ERR_PTR() on error;
> =A0*/
> -static struct omap_device *omap_device_alloc(struct platform_device =
*pdev,
> +struct omap_device *omap_device_alloc(struct platform_device *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_hwmod **ohs, int oh_cnt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_device_pm_latency *pm_lats,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int pm_lats_cnt)
> @@ -590,7 +583,7 @@ oda_exit1:
> =A0 =A0 =A0 =A0return ERR_PTR(ret);
> =A0}
>
> -static void omap_device_delete(struct omap_device *od)
> +void omap_device_delete(struct omap_device *od)
> =A0{
> =A0 =A0 =A0 =A0if (!od)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -816,7 +809,7 @@ static struct dev_pm_domain omap_device_pm_domain=
 =3D {
> =A0* platform_device_register() on the underlying platform_device.
> =A0* Returns the return value of platform_device_register().
> =A0*/
> -static int omap_device_register(struct platform_device *pdev)
> +int omap_device_register(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0pr_debug("omap_device: %s: registering\n", pdev->name)=
;
>
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
