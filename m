From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: LCD LS037V7DW01: Add Backlight driver support
Date: Tue, 30 Mar 2010 13:42:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBF3A7@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1269263515-13912-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47778 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab0C3IMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 04:12:55 -0400
In-Reply-To: <1269263515-13912-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, March 22, 2010 6:42 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: [PATCH] OMAP: LCD LS037V7DW01: Add Backlight driver support
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Tested on OMAP3EVM for OMAP3530 and AM/DM 3730.
> 
[Hiremath, Vaibhav] Tomi,

This patch is also pending, can you please review the same and provide your comments (if any) or merge it to your tree.

Thanks,
Vaibhav

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c               |   32 ++++++++
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   75
> ++++++++++++++++++++
>  2 files changed, 107 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index f2a52c3..ad74340 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -253,6 +253,36 @@ static void omap3_evm_disable_lcd(struct
> omap_dss_device *dssdev)
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
> +static void omap3evm_set_bl_intensity(struct omap_dss_device *dssdev, int
> level)
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
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
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
> +}
> +
> +static int sharp_ls_bl_get_brightness(struct backlight_device *bl)
> +{
> +	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
> +			bl->props.power == FB_BLANK_UNBLANK)
> +		return bl->props.brightness;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops sharp_ls_bl_ops = {
> +	.get_brightness = sharp_ls_bl_get_brightness,
> +	.update_status  = sharp_ls_bl_update_status,
> +};
> +
> +
> +
>  static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
>  {
> +	struct backlight_device *bl;
> +	struct sharp_data *sd;
> +	int r;
> +
>  	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>  		OMAP_DSS_LCD_IHS;
>  	dssdev->panel.acb = 0x28;
>  	dssdev->panel.timings = sharp_ls_timings;
> 
> +	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
> +	if (!sd)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&dssdev->dev, sd);
> +
> +	bl = backlight_device_register("sharp-ls", &dssdev->dev, dssdev,
> +			&sharp_ls_bl_ops);
> +	if (IS_ERR(bl)) {
> +		r = PTR_ERR(bl);
> +		kfree(sd);
> +		return r;
> +	}
> +	sd->bl = bl;
> +
> +	bl->props.fb_blank = FB_BLANK_UNBLANK;
> +	bl->props.power = FB_BLANK_UNBLANK;
> +	bl->props.max_brightness = dssdev->max_backlight_level;
> +	bl->props.brightness = dssdev->max_backlight_level;
> +
> +	r = sharp_ls_bl_update_status(bl);
> +	if (r < 0)
> +		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
> +
>  	return 0;
>  }
> 
>  static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
>  {
> +	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
> +	struct backlight_device *bl = sd->bl;
> +
> +	bl->props.power = FB_BLANK_POWERDOWN;
> +	sharp_ls_bl_update_status(bl);
> +	backlight_device_unregister(bl);
> +
> +	kfree(sd);
>  }
> 
>  static int sharp_ls_power_on(struct omap_dss_device *dssdev)
> --
> 1.6.2.4

