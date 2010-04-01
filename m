From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: LCD LS037V7DW01: Add Backlight driver support
Date: Thu, 01 Apr 2010 15:00:15 +0300
Message-ID: <1270123215.2704.103.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1269263515-13912-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45639 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab0DAMAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:00:46 -0400
In-Reply-To: <1269263515-13912-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Two comments below

On Mon, 2010-03-22 at 14:11 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Tested on OMAP3EVM for OMAP3530 and AM/DM 3730.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c               |   32 ++++++++
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   75 ++++++++++++++++++++
>  2 files changed, 107 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index f2a52c3..ad74340 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -253,6 +253,36 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
>  	lcd_enabled = 0;
>  }
>  
> +/*
> + * PWMA/B register offsets (TWL4030_MODULE_PWMA)
> + */
> +#define TWL_LED_EN	0x0
> +#define TWL_LED_PWMON	0x0
> +#define TWL_LED_PWMOFF	0x1
> +
> +static void omap3evm_set_bl_intensity(struct omap_dss_device *dssdev, int level)
> +{
> +	unsigned char c;
> +
> +	if (level > 100)
> +		return;
> +	/*
> +	 * Enable LEDA for backlight
> +	 */
> +	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_EN);
> +
> +	c = ((125 * (100 - level)) / 100);
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
> +		c += 1;
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, TWL_LED_PWMOFF);
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_LED_PWMON);
> +	} else {
> +		c += 2;
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x1, TWL_LED_PWMON);
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_LED_PWMOFF);
> +	}
> +}
> +
>  static struct omap_dss_device omap3_evm_lcd_device = {
>  	.name			= "lcd",
>  	.driver_name		= "sharp_ls_panel",
> @@ -260,6 +290,8 @@ static struct omap_dss_device omap3_evm_lcd_device = {
>  	.phy.dpi.data_lines	= 18,
>  	.platform_enable	= omap3_evm_enable_lcd,
>  	.platform_disable	= omap3_evm_disable_lcd,
> +	.max_backlight_level	= 100,
> +	.set_backlight		= omap3evm_set_bl_intensity,
>  };
>  
>  static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> index 8d51a5e..d4fcd69 100644
> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> @@ -20,10 +20,16 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/backlight.h>
> +#include <linux/fb.h>
>  #include <linux/err.h>
>  
>  #include <plat/display.h>
>  
> +struct sharp_data {
> +	struct backlight_device *bl;
> +};
> +
>  static struct omap_video_timings sharp_ls_timings = {
>  	.x_res = 480,
>  	.y_res = 640,
> @@ -39,18 +45,87 @@ static struct omap_video_timings sharp_ls_timings = {
>  	.vbp		= 1,
>  };
>  
> +static int sharp_ls_bl_update_status(struct backlight_device *bl)
> +{
> +	struct omap_dss_device *dssdev = dev_get_drvdata(&bl->dev);
> +	int level;
> +
> +	if (!dssdev->set_backlight)
> +		return -EINVAL;
> +
> +	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
> +			bl->props.power == FB_BLANK_UNBLANK)
> +		level = bl->props.brightness;
> +	else
> +		level = 0;
> +
> +	return dssdev->set_backlight(dssdev, level);

I think you should check if dssdev->set_backlight is NULL. Some boards
may not have set_backlight.

Also, you could divide this to board file patch and panel patch. That
way I can queue up the panel patch, and the board patch may go through
Tony.

 Tomi


