From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: panda: add statics to remove warnings
Date: Tue, 24 Apr 2012 10:16:31 -0700
Message-ID: <20120424171630.GQ3739@atomide.com>
References: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25466 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab2DXRQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 13:16:33 -0400
Content-Disposition: inline
In-Reply-To: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120423 00:43]:
> Add statics to board-omap4-panda.c's internal functions and data
> structures to remove warnings.

Care to update with the warnings produced?

Tony
 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 1b782ba..8216e5f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -231,7 +231,7 @@ static struct platform_device omap_vwlan_device = {
>  	},
>  };
>  
> -struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
> +static struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
>  	/* PANDA ref clock is 38.4 MHz */
>  	.board_ref_clock = 2,
>  };
> @@ -438,7 +438,7 @@ static struct panel_dvi_platform_data omap4_dvi_panel = {
>  	.i2c_bus_num = 3,
>  };
>  
> -struct omap_dss_device omap4_panda_dvi_device = {
> +static struct omap_dss_device omap4_panda_dvi_device = {
>  	.type			= OMAP_DISPLAY_TYPE_DPI,
>  	.name			= "dvi",
>  	.driver_name		= "dvi",
> @@ -448,7 +448,7 @@ struct omap_dss_device omap4_panda_dvi_device = {
>  	.channel		= OMAP_DSS_CHANNEL_LCD2,
>  };
>  
> -int __init omap4_panda_dvi_init(void)
> +static int __init omap4_panda_dvi_init(void)
>  {
>  	int r;
>  
> @@ -509,7 +509,7 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
>  	.default_device	= &omap4_panda_dvi_device,
>  };
>  
> -void __init omap4_panda_display_init(void)
> +static void __init omap4_panda_display_init(void)
>  {
>  	int r;
>  
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
