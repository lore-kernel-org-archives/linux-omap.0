From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 05/17] OMAP2,3 DSS Driver register moved to
 mach_omap2
Date: Tue, 21 Dec 2010 15:49:20 +0200
Message-ID: <1292939360.22441.57.camel@tubuntu>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
	 <1291031503-21036-6-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:55754 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab0LUNt3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 08:49:29 -0500
In-Reply-To: <1291031503-21036-6-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

On Mon, 2010-11-29 at 17:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Move DSS driver register from board file to devices.c
> Changed device name from omapdss to omap_display as the
> driver takes care of panel information.

Here you do two separate things, adding the omap_display_init() and
changing the driver name. The latter should be in the previous patch, I
suppose.

 Tomi

> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c             |   32 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/display.h |    4 +++
>  drivers/video/omap2/dss/core.c            |    2 +-
>  3 files changed, 37 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5a0c148..0f6eabe 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -28,6 +28,7 @@
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
>  #include <plat/dma.h>
> +#include <plat/display.h>
>  #include <plat/omap_hwmod.h>
>  #include <plat/omap_device.h>
>  
> @@ -923,6 +924,37 @@ static inline void omap_hdq_init(void) {}
>  #endif
>  
>  /*---------------------------------------------------------------------------*/
> +#ifdef CONFIG_OMAP2_DSS
> +
> +static struct platform_device omap_display_device = {
> +	.name          = "omap_display",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = NULL,
> +	},
> +};
> +
> +int __init omap_display_init(struct omap_dss_board_info
> +					*board_data)
> +{
> +	int r = 0;
> +	omap_display_device.dev.platform_data = board_data;
> +
> +	r = platform_device_register(&omap_display_device);
> +	if (r < 0)
> +		printk(KERN_ERR "Unable to register OMAP-Display device\n");
> +
> +	return r;
> +}
> +
> +#else
> +int __init omap_display_init(struct omap_dss_board_info *board_data)
> +{
> +return 0;
> +}
> +#endif
> +
> +/*---------------------------------------------------------------------------*/
>  
>  #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
>  	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index c915a66..871bbae 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -23,6 +23,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/device.h>
> +#include <linux/platform_device.h>
>  #include <asm/atomic.h>
>  
>  #define DISPC_IRQ_FRAMEDONE		(1 << 0)
> @@ -220,6 +221,9 @@ struct omap_dss_board_info {
>  	struct omap_dss_device *default_device;
>  };
>  
> +/* Init with the board info */
> +extern int omap_display_init(struct omap_dss_board_info *board_data);
> +
>  struct omap_video_timings {
>  	/* Unit: pixels */
>  	u16 x_res;
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 8e89f60..48d20d8 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -715,7 +715,7 @@ static struct platform_driver omap_dss_driver = {
>  	.suspend	= omap_dss_suspend,
>  	.resume		= omap_dss_resume,
>  	.driver         = {
> -		.name   = "omapdss",
> +		.name   = "omap_display",
>  		.owner  = THIS_MODULE,
>  	},
>  };


