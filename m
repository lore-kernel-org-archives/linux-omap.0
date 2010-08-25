From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 02/20] Move DSS driver register from board to mach_omap2
Date: Wed, 25 Aug 2010 11:31:16 +0300
Message-ID: <1282725076.9299.94.camel@tubuntu.research.nokia.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	 <1282579089-10487-2-git-send-email-svadivu@ti.com>
	 <1282579089-10487-3-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:27178 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0HYIbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:31:22 -0400
In-Reply-To: <1282579089-10487-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@ti.com" <khilman@ti.com>

On Mon, 2010-08-23 at 17:57 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Move the DSS driver register from board file to devices.c.
> Regulator initialisation done with driver name instead of the device name.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---

>  
>  /*---------------------------------------------------------------------------*/
> +#ifdef CONFIG_OMAP2_DSS
> +
> +static struct platform_device omap_display_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = NULL,
> +	},
> +};

Could we call these "dss" instead of "display". Display sounds that it
could include panel.

> +
> +void __init omap_display_init(struct omap_dss_board_info
> +					*board_data)
> +{
> +
> +	omap_display_device.dev.platform_data = board_data;
> +
> +	if (platform_device_register(&omap_display_device) < 0)
> +		printk(KERN_ERR "Unable to register OMAP-Display device\n");
> +
> +
> +	return ;
> +}
> +
> +#else
> +void __init omap_display_init(struct omap_dss_board_info *board_data)
> +{
> +}
> +#endif
> +
> +
> +/*---------------------------------------------------------------------------*/
>  
>  #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
>  	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 1c529ce..f5da4ae 100644
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
> @@ -251,6 +252,9 @@ struct omap_dss_board_info {
>  	struct omap_dss_device *default_device;
>  };
>  
> +/* Init with the board info */
> +extern void omap_display_init(struct omap_dss_board_info *board_data);
> +
>  struct omap_video_timings {
>  	/* Unit: pixels */
>  	u16 x_res;
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index b3a498f..bcbb077 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -52,6 +52,7 @@ static struct {
>  	struct regulator *vdds_dsi_reg;
>  	struct regulator *vdds_sdi_reg;
>  	struct regulator *vdda_dac_reg;
> +	struct omap_dss_board_info *pdata;
>  } core;
>  
>  static void dss_clk_enable_all_no_ctx(void);
> @@ -501,6 +502,7 @@ static int omap_dss_probe(struct platform_device *pdev)
>  	int i;
>  
>  	core.pdev = pdev;
> +	core.pdata = pdev->dev.platform_data;

Why is pdata stored? It is available through pdev anyway.

 Tomi


