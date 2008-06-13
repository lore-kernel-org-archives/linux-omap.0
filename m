From: "iqbal" <iqbal@ti.com>
Subject: Re: [PATCH] Separate out 3430 LCD panel support from 2430 file
Date: Fri, 13 Jun 2008 12:52:20 +0530 (IST)
Message-ID: <3296.172.24.190.238.1213341740.squirrel@dbdmail.itg.ti.com>
References: <1213266272-8585-1-git-send-email-iqbal@ti.com>
    <afafe9c73f500ada378e662ea92fd1e5@felipebalbi.com>
Reply-To: iqbal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34730 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYFMHW3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2008 03:22:29 -0400
In-Reply-To: <afafe9c73f500ada378e662ea92fd1e5@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Iqbal: Thanks for your comments

>
> You're at least missing 3430sdp defconfig updates, Kconfig changes
> in drivers/media/video/omap and the removal of conditional code in
> lcd_2430sdp.c

I agree, the defconfig and the lcd_2430sdo.c cleanup can be done in a separate
patch, hope this is OK.

> Some more comments below
>
>>
>> Signed-off-by: Iqbal Shareef  <iqbal@ti.com>
>>
>> ---
>>  arch/arm/mach-omap2/board-3430sdp.c |    2 +-
>>  drivers/video/omap/Makefile         |    2 +-
>>  drivers/video/omap/lcd_3430sdp.c    |  161
>> +++++++++++++++++++++++++++++++++++
>> +static unsigned backlight_gpio;
>> +static unsigned enable_gpio;
>> +
>> +#define LCD_PIXCLOCK_MAX			167000
>> +#define PM_RECEIVER				TWL4030_MODULE_PM_RECEIVER
>
> PM_RECEIVER has no prefix. It's better to use TWL4030_MODULE_PM_RECEIVER
> to avoid namespace conflicts

I agree, I will change it.

>
>> +#define ENABLE_VAUX2_DEDICATED			0x03
>> +#define ENABLE_VAUX2_DEV_GRP			0x20
>> +#define ENABLE_VAUX3_DEDICATED			0x05
>> +#define ENABLE_VAUX3_DEV_GRP			0xE0
>> +
>> +static int sdp3430_panel_init(struct lcd_panel *panel,
>> +				struct omapfb_device *fbdev)
>> +{
>> +	enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
>> +	backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
>> +
>> +	omap_request_gpio(enable_gpio);			/* LCD panel */
>> +	omap_request_gpio(backlight_gpio);		/* LCD backlight */
>> +	omap_set_gpio_direction(enable_gpio, 0);	/* output */
>> +	omap_set_gpio_direction(backlight_gpio, 0);	/* output */
>
> better using gpiolib

Yes you are right, for now let's push this patch and have gpiolib for all lcd
dirvers in next set of patches, I don't have bandwidth to look at gpio lib now.

>> +
>> +	return 0;
>> +}
>> +
>> +static void sdp3430_panel_cleanup(struct lcd_panel *panel)
>> +{
>> +	omap_free_gpio(backlight_gpio);
>> +	omap_free_gpio(enable_gpio);
>
> gpiolib
>
>> +}
>> +
>> +static int sdp3430_panel_enable(struct lcd_panel *panel)
>> +{
>> +	omap_set_gpio_dataout(enable_gpio, 1);
>> +	omap_set_gpio_dataout(backlight_gpio, 1);
>
> gpiolib
>
>> +
>> +	if (0 != twl4030_i2c_write_u8(PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
>> +					TWL4030_VAUX3_DEDICATED))
>> +		return -EIO;
>> +	if (0 != twl4030_i2c_write_u8(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
>> +					TWL4030_VAUX3_DEV_GRP))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static void sdp3430_panel_disable(struct lcd_panel *panel)
>> +{
>> +	omap_set_gpio_dataout(enable_gpio, 0);
>> +	omap_set_gpio_dataout(backlight_gpio, 0);
>
> gpiolib
>
>> +}
>> +
>> +static unsigned long sdp3430_panel_get_caps(struct lcd_panel *panel)
>> +{
>> +	return 0;
>> +}
>> +
>> +struct lcd_panel sdp3430_panel = {
>> +	.name		= "sdp3430",
>> +	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
>> +			  OMAP_LCDC_INV_HSYNC,
>> +
>> +	.bpp		= 16,
>> +	.data_lines	= 16,
>> +	.x_res		= 240,
>> +	.y_res		= 320,
>> +	.hsw		= 3,		/* hsync_len (4) - 1 */
>> +	.hfp		= 3,		/* right_margin (4) - 1 */
>> +	.hbp		= 39,		/* left_margin (40) - 1 */
>> +	.vsw		= 1,		/* vsync_len (2) - 1 */
>> +	.vfp		= 2,		/* lower_margin */
>> +	.vbp		= 7,		/* upper_margin (8) - 1 */
>> +
>> +	.pixel_clock	= LCD_PIXCLOCK_MAX,
>> +
>> +	.init		= sdp3430_panel_init,
>> +	.cleanup	= sdp3430_panel_cleanup,
>> +	.enable		= sdp3430_panel_enable,
>> +	.disable	= sdp3430_panel_disable,
>> +	.get_caps	= sdp3430_panel_get_caps,
>> +};
>> +
>> +static int sdp3430_panel_probe(struct platform_device *pdev)
>> +{
>> +	omapfb_register_panel(&sdp3430_panel);
>> +	return 0;
>> +}
>> +
>> +static int sdp3430_panel_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int sdp3430_panel_suspend(struct platform_device *pdev,
>> +					pm_message_t mesg)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int sdp3430_panel_resume(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +struct platform_driver sdp3430_panel_driver = {
>> +	.probe		= sdp3430_panel_probe,
>> +	.remove		= sdp3430_panel_remove,
>> +	.suspend	= sdp3430_panel_suspend,
>> +	.resume		= sdp3430_panel_resume,
>> +	.driver		= {
>> +		.name		= "sdp3430_lcd",
>> +		.owner		= THIS_MODULE,
>> +	},
>> +};
>> +
>> +static int __init sdp3430_panel_drv_init(void)
>> +{
>> +	return platform_driver_register(&sdp3430_panel_driver);
>> +}
>> +
>> +static void __exit sdp3430_panel_drv_exit(void)
>> +{
>> +	platform_driver_unregister(&sdp3430_panel_driver);
>> +}
>> +
>> +module_init(sdp3430_panel_drv_init);
>> +module_exit(sdp3430_panel_drv_exit);
>
> platform devices should have MODULE_ALIAS("platform:<driver_name>");
>
> in this case would be:
>
> MODULE_ALIAS("platform:sdp3430_lcd");

Thanks, I will look at it.

>> --
>> 1.5.3.2

> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>


