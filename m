From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 08/17] OMAP2,3: DSS2: Build omap_device for each DSS HWIP
Date: Fri, 07 Jan 2011 15:34:32 -0800
Message-ID: <87zkrci8zb.fsf@ti.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
	<1294399551-10457-9-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33983 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751231Ab1AGXeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 18:34:36 -0500
Received: by gwj20 with SMTP id 20so7501628gwj.8
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 15:34:36 -0800 (PST)
In-Reply-To: <1294399551-10457-9-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Fri, 7 Jan 2011 16:55:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Sumit Semwal <sumit.semwal@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Looks up the hwmod database for each of the given DSS HW IP and builds
> omap_device which inturn does the platform device register for each of DSS HW IP
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/mach-omap2/display.c             |   44 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/display.h |    6 ++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 26d3feb..276b800 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -36,10 +36,54 @@ static struct platform_device omap_display_device = {
>  	},
>  };
>  
> +static struct omap_device_pm_latency omap_dss_latency[] = {
> +	[0] = {
> +		.deactivate_func        = omap_device_idle_hwmods,
> +		.activate_func          = omap_device_enable_hwmods,

Without any latency numbers or AUTO_ADJUST you're going to have noisy
output from omap_device.

> +	},
> +};
> +
>  int __init omap_display_init(struct omap_dss_board_info
>  					*board_data)
>  {
>  	int r = 0;
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	int i;
> +	struct omap_display_platform_data pdata;
> +	char *oh_name[] = { 	"dss_dss",	/* omap2,3 */
> +				"dss_dispc",	/* omap2,3 */
> +				"dss_rfbi",	/* omap2,3 */
> +				"dss_venc",	/* omap2,3 */
> +				"dss_dsi1" };	/* omap3 */

Why all the extra whitespace before the strings?

> +	char *dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
> +				"omap_venc", "omap_dsi1" };

ditto

> +	int oh_count;
> +
> +	if (cpu_is_omap24xx()) {
> +		oh_count = ARRAY_SIZE(oh_name) - 1;
> +		/* last hwmod dev in oh_name is not available for omap2 */
> +	} else {
> +		oh_count = ARRAY_SIZE(oh_name);
> +	}

braces not needed

> +	pdata.board_data	=	board_data;

extra whitespace not necessary

> +	pdata.board_data->get_last_off_on_transaction_id = NULL;

instead, you should probably zero all of pdata before using it since it
is on the stack

> +	for (i = 0; i < oh_count; i++) {
> +		oh = omap_hwmod_lookup(oh_name[i]);
> +		if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name[i]);
> +			return r;
> +		}
> +		od = omap_device_build(dev_name[i], -1, oh, &pdata,
> +				sizeof(struct omap_display_platform_data),
> +				omap_dss_latency,
> +				ARRAY_SIZE(omap_dss_latency), 0);
> +
> +		WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
> +				oh_name[i]);

yet code below will still try and register it?

> +	}
>  	omap_display_device.dev.platform_data = board_data;
>  
>  	r = platform_device_register(&omap_display_device);
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 871bbae..23afd6d 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <asm/atomic.h>
>  
> +

stray whitespace change

>  #define DISPC_IRQ_FRAMEDONE		(1 << 0)
>  #define DISPC_IRQ_VSYNC			(1 << 1)
>  #define DISPC_IRQ_EVSYNC_EVEN		(1 << 2)
> @@ -224,6 +225,11 @@ struct omap_dss_board_info {
>  /* Init with the board info */
>  extern int omap_display_init(struct omap_dss_board_info *board_data);
>  
> +struct omap_display_platform_data {
> +	struct omap_dss_board_info *board_data;
> +	/* TODO: Additional members to be added when PM is considered */
> +};
> +
>  struct omap_video_timings {
>  	/* Unit: pixels */
>  	u16 x_res;

Kevin
