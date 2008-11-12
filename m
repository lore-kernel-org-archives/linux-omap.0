From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix section mismatch warnings on some OMAP1 boards
Date: Tue, 11 Nov 2008 16:36:38 -0800
Message-ID: <20081112003637.GU3984@atomide.com>
References: <20081111225720.GA3162@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53769 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbYKLAgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 19:36:41 -0500
Content-Disposition: inline
In-Reply-To: <20081111225720.GA3162@earth.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [081111 15:43]:
> I got some section mismatch warnings when compiling latest git for
> MACH_AMS_DELTA this evening; this seems to be due to a missing
> __initdata on the omap_board_config_kernel. Adding it fixes the
> warnings. I noticed that although this had been done for other OMAP1
> boards fsample, innovator and voiceblue were all lacking it too, so I
> fixed them up at the same time.

These cannot be __initdata as they are used by get_config() in
plat-omap/common.c, and omap_get_config() is called in some drivers
that could be modules.

Let's rather just get rid of all the omap_board_config_kernel stuff
and use platform_data instead.

Tony


> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> 
> -----
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 2e61839..682cb91 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -172,7 +172,7 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
>  	.pins[0]	= 2,
>  };
>  
> -static struct omap_board_config_kernel ams_delta_config[] = {
> +static struct omap_board_config_kernel ams_delta_config[] __initdata = {
>  	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
>  	{ OMAP_TAG_UART,	&ams_delta_uart_config },
>  	{ OMAP_TAG_USB,		&ams_delta_usb_config },
> diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
> index db78946..38f4f18 100644
> --- a/arch/arm/mach-omap1/board-fsample.c
> +++ b/arch/arm/mach-omap1/board-fsample.c
> @@ -216,7 +216,7 @@ static struct omap_lcd_config fsample_lcd_config __initdata = {
>  	.ctrl_name	= "internal",
>  };
>  
> -static struct omap_board_config_kernel fsample_config[] = {
> +static struct omap_board_config_kernel fsample_config[] __initdata = {
>  	{ OMAP_TAG_UART,	&fsample_uart_config },
>  	{ OMAP_TAG_LCD,		&fsample_lcd_config },
>  };
> diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
> index 7a97f6b..b86eb95 100644
> --- a/arch/arm/mach-omap1/board-innovator.c
> +++ b/arch/arm/mach-omap1/board-innovator.c
> @@ -408,7 +408,7 @@ static struct omap_uart_config innovator_uart_config __initdata = {
>  	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
> -static struct omap_board_config_kernel innovator_config[] = {
> +static struct omap_board_config_kernel innovator_config[] __initdata = {
>  	{ OMAP_TAG_USB,         NULL },
>  	{ OMAP_TAG_LCD,		NULL },
>  	{ OMAP_TAG_UART,	&innovator_uart_config },
> diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
> index 3ab5bbf..93de7e0 100644
> --- a/arch/arm/mach-omap1/board-voiceblue.c
> +++ b/arch/arm/mach-omap1/board-voiceblue.c
> @@ -145,7 +145,7 @@ static struct omap_uart_config voiceblue_uart_config __initdata = {
>  	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
> -static struct omap_board_config_kernel voiceblue_config[] = {
> +static struct omap_board_config_kernel voiceblue_config[] __initdata = {
>  	{ OMAP_TAG_USB,  &voiceblue_usb_config },
>  	{ OMAP_TAG_UART, &voiceblue_uart_config },
>  };
> -----
> 
> J.
> 
> -- 
>                                             jid: noodles@jabber.earth.li
> Are you out of my mind?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
