From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/15] OMAP: SDP: Enable DSS2 for OMAP3 SDP board
Date: Wed, 5 Aug 2009 17:40:52 +0300
Message-ID: <20090805144052.GM7374@atomide.com>
References: <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-12-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-13-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55371 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933603AbZHEOk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:40:59 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-14-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |   31 +++++-
>  arch/arm/mach-omap2/board-3430sdp.c     |  171 +++++++++++++++++++++++++++----
>  2 files changed, 181 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
> index 73e0128..a0dce8f 100644
> --- a/arch/arm/configs/omap_3430sdp_defconfig
> +++ b/arch/arm/configs/omap_3430sdp_defconfig
> @@ -1336,10 +1336,35 @@ CONFIG_FB_CFB_IMAGEBLIT=y
>  #
>  # CONFIG_FB_S1D13XXX is not set
>  # CONFIG_FB_VIRTUAL is not set
> -CONFIG_FB_OMAP=y
> -# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> +# CONFIG_FB_OMAP_LCD_VGA is not set
> +# CONFIG_FB_OMAP_031M3R is not set
> +# CONFIG_FB_OMAP_048M3R is not set
> +# CONFIG_FB_OMAP_079M3R is not set
> +# CONFIG_FB_OMAP_092M9R is not set
>  # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> -CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> +CONFIG_OMAP2_DSS=y
> +CONFIG_OMAP2_VRAM_SIZE=6
> +CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +CONFIG_PANEL_GENERIC=y
> +# CONFIG_PANEL_SAMSUNG_LTE430WQ_F0C is not set
> +CONFIG_PANEL_SHARP_LS037V7DW01=y
> +CONFIG_FB_OMAP2=y
> +CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
> +# CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE is not set
> +CONFIG_FB_OMAP2_NUM_FBS=3
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>  
>  #
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 21b4a52..ef8cf4f 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -36,6 +36,7 @@
>  #include <mach/common.h>
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
> +#include <mach/display.h>
>  
>  #include <mach/control.h>
>  #include <mach/keypad.h>
> @@ -148,23 +149,149 @@ static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
>  	},
>  };
>  
> -static struct platform_device sdp3430_lcd_device = {
> -	.name		= "sdp2430_lcd",
> -	.id		= -1,
> +
> +#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
> +#define SDP3430_LCD_PANEL_ENABLE_GPIO		5
> +
> +static unsigned backlight_gpio;
> +static unsigned enable_gpio;
> +static int lcd_enabled;
> +static int dvi_enabled;
> +
> +static void __init sdp3430_display_init(void)
> +{
> +	int r;
> +
> +	enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
> +	backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
> +
> +	r = gpio_request(enable_gpio, "LCD reset");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD reset GPIO\n");
> +		goto err0;
> +	}
> +
> +	r = gpio_request(backlight_gpio, "LCD Backlight");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD backlight GPIO\n");
> +		goto err1;
> +	}
> +
> +	gpio_direction_output(enable_gpio, 0);
> +	gpio_direction_output(backlight_gpio, 0);
> +
> +	return;
> +err1:
> +	gpio_free(enable_gpio);
> +err0:
> +	return;
> +}
> +
> +static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	if (dvi_enabled) {
> +		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio_direction_output(enable_gpio, 1);
> +	gpio_direction_output(backlight_gpio, 1);
> +
> +	lcd_enabled = 1;
> +
> +	return 0;
> +}
> +
> +static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	lcd_enabled = 0;
> +
> +	gpio_direction_output(enable_gpio, 0);
> +	gpio_direction_output(backlight_gpio, 0);
> +}
> +
> +static int sdp3430_panel_enable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (lcd_enabled) {
> +		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	dvi_enabled = 1;
> +
> +	return 0;
> +}
> +
> +static void sdp3430_panel_disable_dvi(struct omap_dss_device *dssdev)
> +{
> +	dvi_enabled = 0;
> +}
> +
> +static int sdp3430_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +	return 0;
> +}
> +
> +static void sdp3430_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
> +}
> +
> +
> +static struct omap_dss_device sdp3430_lcd_device = {
> +	.name = "lcd",
> +	.driver_name = "sharp_ls_panel",
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.phy.dpi.data_lines = 16,
> +	.platform_enable = sdp3430_panel_enable_lcd,
> +	.platform_disable = sdp3430_panel_disable_lcd,
>  };

Please check the formatting of data so they're tabbed.

  
> -static struct regulator_consumer_supply sdp3430_vdac_supply = {
> -	.supply		= "vdac",
> -	.dev		= &sdp3430_lcd_device.dev,
> +static struct omap_dss_device sdp3430_dvi_device = {
> +	.name = "dvi",
> +	.driver_name = "generic_panel",
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.phy.dpi.data_lines = 24,
> +	.platform_enable = sdp3430_panel_enable_dvi,
> +	.platform_disable = sdp3430_panel_disable_dvi,
>  };
>  
> -static struct regulator_consumer_supply sdp3430_vdvi_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &sdp3430_lcd_device.dev,
> +static struct omap_dss_device sdp3430_tv_device = {
> +	.name = "tv",
> +	.driver_name = "venc",
> +	.type = OMAP_DISPLAY_TYPE_VENC,
> +	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
> +	.platform_enable = sdp3430_panel_enable_tv,
> +	.platform_disable = sdp3430_panel_disable_tv,
>  };

Here too, and in the other board-*.c files.

>  
> -static struct platform_device *sdp3430_devices[] __initdata = {
> +
> +static struct omap_dss_device *sdp3430_dss_devices[] = {
>  	&sdp3430_lcd_device,
> +	&sdp3430_dvi_device,
> +	&sdp3430_tv_device,
> +};
> +
> +static struct omap_dss_board_info sdp3430_dss_data = {
> +	.num_devices = ARRAY_SIZE(sdp3430_dss_devices),
> +	.devices = sdp3430_dss_devices,
> +	.default_device = &sdp3430_lcd_device,
> +};
> +
> +static struct platform_device sdp3430_dss_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = &sdp3430_dss_data,
> +	},
> +};
> +
> +static struct regulator_consumer_supply sdp3430_vdda_dac_supply = {
> +	.supply		= "vdda_dac",
> +	.dev		= &sdp3430_dss_device.dev,
> +};
> +
> +static struct platform_device *sdp3430_devices[] __initdata = {
> +	&sdp3430_dss_device,
>  };
>  
>  static void __init omap_3430sdp_init_irq(void)
> @@ -178,13 +305,8 @@ static struct omap_uart_config sdp3430_uart_config __initdata = {
>  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
> -static struct omap_lcd_config sdp3430_lcd_config __initdata = {
> -	.ctrl_name	= "internal",
> -};
> -
>  static struct omap_board_config_kernel sdp3430_config[] __initdata = {
>  	{ OMAP_TAG_UART,	&sdp3430_uart_config },
> -	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
>  };

Thanks for helping getting rid of the OMAP_TAGs :)

Feel free to add my ack after the data tabbing is done.

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony

  
>  static int sdp3430_batt_table[] = {
> @@ -391,22 +513,34 @@ static struct regulator_init_data sdp3430_vdac = {
>  					| REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &sdp3430_vdac_supply,
> +	.consumer_supplies	= &sdp3430_vdda_dac_supply,
>  };
>  
>  /* VPLL2 for digital video outputs */
> +static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
> +	{
> +		.supply		= "vdvi",
> +		.dev		= &sdp3430_lcd_device.dev,
> +	},
> +	{
> +		.supply		= "vdds_dsi",
> +		.dev		= &sdp3430_dss_device.dev,
> +	}
> +};
> +
>  static struct regulator_init_data sdp3430_vpll2 = {
>  	.constraints = {
>  		.name			= "VDVI",
>  		.min_uV			= 1800000,
>  		.max_uV			= 1800000,
> +		.apply_uV		= true,
>  		.valid_modes_mask	= REGULATOR_MODE_NORMAL
>  					| REGULATOR_MODE_STANDBY,
>  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &sdp3430_vdvi_supply,
> +	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vpll2_supplies),
> +	.consumer_supplies	= sdp3430_vpll2_supplies,
>  };
>  
>  static struct twl4030_platform_data sdp3430_twldata = {
> @@ -496,6 +630,7 @@ static void __init omap_3430sdp_init(void)
>  	usb_musb_init();
>  	board_smc91x_init();
>  	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
> +	sdp3430_display_init();
>  }
>  
>  static void __init omap_3430sdp_map_io(void)
> -- 
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
