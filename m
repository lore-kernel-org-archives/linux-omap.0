From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
Date: Mon, 13 Dec 2010 09:12:54 +0100
Message-ID: <4D05D586.6090408@ti.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab0LMINK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 03:13:10 -0500
In-Reply-To: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Omar,

On 12/11/2010 12:45 AM, Ramirez Luna, Omar wrote:
> Make the parameter received by omap_device_get_mpu_rt_va
> consistent with the functions meant to be called by drivers.
>
> Also move its header declaration to appear in the set of
> functions to be used by drivers, as per the comment there.

Please note that even if Paul submitted this API upon request from 
Santosh, we do not want driver to us it most of the time.

All drivers should us the generic Linux way to get physical mem resource 
and then ioremap it.

I assume that if you want to update this API, you are probably already 
using it.
Why cannot you use the generic way?

Regards,
Benoit

>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> Acked-by: Kevin Hilman<khilman@deeprootsystems.com>
> ---
>   arch/arm/plat-omap/include/plat/omap_device.h |    3 +--
>   arch/arm/plat-omap/omap_device.c              |    8 ++++++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 28e2d1a..1877c1a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -80,6 +80,7 @@ struct omap_device {
>   int omap_device_enable(struct platform_device *pdev);
>   int omap_device_idle(struct platform_device *pdev);
>   int omap_device_shutdown(struct platform_device *pdev);
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev);
>
>   /* Core code interface */
>
> @@ -101,8 +102,6 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>   int omap_device_register(struct omap_device *od);
>   int omap_early_device_register(struct omap_device *od);
>
> -void __iomem *omap_device_get_rt_va(struct omap_device *od);
> -
>   /* OMAP PM interface */
>   int omap_device_align_pm_lat(struct platform_device *pdev,
>   			     u32 new_wakeup_lat_limit);
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index abe933c..9d11195 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -681,7 +681,7 @@ struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)
>
>   /**
>    * omap_device_get_mpu_rt_va - return the MPU's virtual addr for the hwmod base
> - * @od: struct omap_device *
> + * @pdev: struct platform_device *
>    *
>    * Return the MPU's virtual address for the base of the hwmod, from
>    * the ioremap() that the hwmod code does.  Only valid if there is one
> @@ -690,8 +690,12 @@ struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)
>    * otherwise, passes along the return value from
>    * omap_hwmod_get_mpu_rt_va().
>    */
> -void __iomem *omap_device_get_rt_va(struct omap_device *od)
> +void __iomem *omap_device_get_rt_va(struct platform_device *pdev)
>   {
> +	struct omap_device *od;
> +
> +	od = _find_by_pdev(pdev);
> +
>   	if (od->hwmods_cnt != 1)
>   		return NULL;
>

