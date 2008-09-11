From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/15] OMAP3 camera driver: OMAP34XXCAM: Camera Base
	Address.
Date: Wed, 10 Sep 2008 17:16:35 -0700
Message-ID: <20080911001635.GC21163@atomide.com>
References: <A24693684029E5489D1D202277BE89441191E335@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53268 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYIKAQr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 20:16:47 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89441191E335@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [080829 16:34]:
> From: Sergio Aguirre <saaguirre@ti.com>
> 
> ARM: OMAP: OMAP34XXCAM: Camera Base Address.
> 
> Adding OMAP 3 Camera registers base address, and Platform Device.

Pushing today.

Tony


> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Signed-off-by: Sameer Venkatraman <sameerv@ti.com>
> Signed-off-by: Mohit Jalori <mjalori@ti.com>
> ---
>  arch/arm/plat-omap/include/mach-omap2/devices.c              |   26 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat-omap/include/mach/omap34xx.h |    1 +
>  2 files changed, 27 insertions(+)
> 
> --- a/arch/arm/plat-omap/include/mach/omap34xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap34xx.h
> @@ -63,6 +63,7 @@
>  #define OMAP2_CM_BASE			OMAP3430_CM_BASE
>  #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
>  #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
> +#define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
>  
>  #endif
>  
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -50,6 +50,32 @@
>  {
>  	platform_device_register(&omap_cam_device);
>  }
> +
> +#elif defined(CONFIG_VIDEO_OMAP3) || defined(CONFIG_VIDEO_OMAP3_MODULE)
> +
> +static struct resource cam_resources[] = {
> +	{
> +		.start		= OMAP34XX_CAMERA_BASE,
> +		.end		= OMAP34XX_CAMERA_BASE + 0x1B70,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= INT_34XX_CAM_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device omap_cam_device = {
> +	.name		= "omap34xxcam",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(cam_resources),
> +	.resource	= cam_resources,
> +};
> +
> +static inline void omap_init_camera(void)
> +{
> +	platform_device_register(&omap_cam_device);
> +}
>  #else
>  static inline void omap_init_camera(void)
>  {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
