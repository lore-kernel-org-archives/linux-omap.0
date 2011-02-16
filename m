From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 2/2] omap3: devkit8000: Add and use 4.3 inch display
Date: Wed, 16 Feb 2011 15:42:08 +0100
Message-ID: <4D5BE240.8080002@corscience.de>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com> <1297530130-10355-3-git-send-email-daniel.morsing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61863 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1BPOnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 09:43:03 -0500
In-Reply-To: <1297530130-10355-3-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomba@iki.fi>, Bryan Wu <bryan.wu@canonical.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hello Daniel,

Am 12.02.2011 18:02, schrieb Daniel Morsing:
> This patch adds a generic panel entry for the 4.3 inch display that is
> sold with the devkit8000 and modifies the board file to use this
> display.
> 
> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
> ---
> Note that this patch depends on the previous one in the series.
> 
>  arch/arm/mach-omap2/board-devkit8000.c           |    2 +-
>  drivers/video/omap2/displays/panel-generic-dpi.c |   26 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 9a2a31e..6dab13e 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -148,7 +148,7 @@ static struct regulator_consumer_supply devkit8000_vio_supply =
>  	REGULATOR_SUPPLY("vcc", "spi2.0");
>  
>  static struct panel_generic_dpi_data lcd_panel = {
> -	.name			= "generic",
> +	.name			= "devkit_43",
>  	.platform_enable        = devkit8000_panel_enable_lcd,
>  	.platform_disable       = devkit8000_panel_disable_lcd,
>  };
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index b52a28f..ee9e7ea 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -83,6 +83,32 @@ static struct panel_config generic_dpi_panels[] = {
>  		.name			= "generic",
>  	},
>  
> +	/* Devkit8000 4.3 Inch display */
> +	{
> +		{
> +			.x_res		= 480,
> +			.y_res		= 272,
> +
> +			.pixel_clock	= 10000,
> +
> +			.hfp		= 2,
> +			.hsw		= 41,
> +			.hbp		= 2,
> +
> +			.vfp		= 2,
> +			.vsw		= 10,
> +			.vbp		= 2,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x0,
> +		.recommended_bpp	= 16,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +						OMAP_DSS_LCD_IHS,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "devkit_43",
> +	},
> +
>  	/* Sharp LQ043T1DG01 */
>  	{
>  		{

can you try these settings.
I have these settings from other users of the 4.3 inch display.
I think only the pixel clock is a little bit slower.


//.name         = "4.3inch_LCD",
.x_res          = 480,
.y_res          = 272,
.hsw            = 41,           /* hsync_len (4) - 1 */
.hfp            = 2,            /* right_margin (4) - 1 */
.hbp            = 2,            /* left_margin (40) - 1 */
.vsw            = 10,           /* vsync_len (2) - 1 */
.vfp            = 2,            /* lower_margin */
.vbp            = 2,            /* upper_margin (8) - 1 */
.pixel_clock    = 9600,

Regards,
Thomas
