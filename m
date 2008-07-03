From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH]Separate out 3430 LCD panel support from 2430
	file
Date: Thu, 3 Jul 2008 13:32:30 +0300
Message-ID: <20080703103228.GM14276@atomide.com>
References: <1215001464-12691-1-git-send-email-iqbal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55788 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYGCMRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:17:03 -0400
Content-Disposition: inline
In-Reply-To: <1215001464-12691-1-git-send-email-iqbal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iqbal@ti.com
Cc: linux-omap@vger.kernel.org

* iqbal@ti.com <iqbal@ti.com> [080702 15:25]:
> From: Iqbal Shareef <iqbal@ti.com>
> 
> Separate out 3430 LCD panel support from 2430 SDP.
> 
> Currently the support for the LCD on 3430SDP is added in the lcd_2430sdp.c
> file. This patch separates it out to a new file.

Pushing today.

Tony


> Signed-off-by: Iqbal Shareef  <iqbal@ti.com>
> 
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |    2 +-
>  drivers/video/omap/Makefile         |    2 +-
>  drivers/video/omap/lcd_3430sdp.c    |  162 +++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_3430sdp.c
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index f6cd08b..7a216cc 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -204,7 +204,7 @@ static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
>  };
>  
>  static struct platform_device sdp3430_lcd_device = {
> -	.name		= "sdp2430_lcd",
> +	.name		= "sdp3430_lcd",
>  	.id		= -1,
>  };
>  
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index fe7ee5d..a72a2d9 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -30,7 +30,7 @@ objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
>  
>  objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
>  objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> -objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
> +objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_3430sdp.o
>  objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
>  objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
>  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
> diff --git a/drivers/video/omap/lcd_3430sdp.c b/drivers/video/omap/lcd_3430sdp.c
> new file mode 100644
> index 0000000..20ac0e5
> --- /dev/null
> +++ b/drivers/video/omap/lcd_3430sdp.c
> @@ -0,0 +1,162 @@
> +/*
> + * LCD panel support for the TI 3430SDP board
> + *
> + * Copyright (C) 2008 Texas Instruments
> + * Author: Iqbal Shareef <iqbal@ti.com>
> + *
> + * Derived from drivers/video/omap/lcd_2430sdp.c
> + * Copyright (C) 2007 MontaVista
> + * Author: Hunyue Yau <hyau@mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/omapfb.h>
> +
> +#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
> +#define SDP3430_LCD_PANEL_ENABLE_GPIO		5
> +
> +static unsigned backlight_gpio;
> +static unsigned enable_gpio;
> +
> +#define LCD_PIXCLOCK_MAX			167000
> +#define ENABLE_VAUX2_DEDICATED			0x03
> +#define ENABLE_VAUX2_DEV_GRP			0x20
> +#define ENABLE_VAUX3_DEDICATED			0x05
> +#define ENABLE_VAUX3_DEV_GRP			0xE0
> +
> +static int sdp3430_panel_init(struct lcd_panel *panel,
> +				struct omapfb_device *fbdev)
> +{
> +	enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
> +	backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
> +
> +	omap_request_gpio(enable_gpio);			/* LCD panel */
> +	omap_request_gpio(backlight_gpio);		/* LCD backlight */
> +	omap_set_gpio_direction(enable_gpio, 0);	/* output */
> +	omap_set_gpio_direction(backlight_gpio, 0);	/* output */
> +
> +	return 0;
> +}
> +
> +static void sdp3430_panel_cleanup(struct lcd_panel *panel)
> +{
> +	omap_free_gpio(backlight_gpio);
> +	omap_free_gpio(enable_gpio);
> +}
> +
> +static int sdp3430_panel_enable(struct lcd_panel *panel)
> +{
> +	omap_set_gpio_dataout(enable_gpio, 1);
> +	omap_set_gpio_dataout(backlight_gpio, 1);
> +
> +	if (0 != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, ENABLE_VAUX3_DEDICATED,
> +					TWL4030_VAUX3_DEDICATED))
> +		return -EIO;
> +	if (0 != twl4030_i2c_write_u8(PM_RECEIVER, ENABLE_VAUX3_DEV_GRP,
> +					TWL4030_VAUX3_DEV_GRP))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void sdp3430_panel_disable(struct lcd_panel *panel)
> +{
> +	omap_set_gpio_dataout(enable_gpio, 0);
> +	omap_set_gpio_dataout(backlight_gpio, 0);
> +}
> +
> +static unsigned long sdp3430_panel_get_caps(struct lcd_panel *panel)
> +{
> +	return 0;
> +}
> +
> +struct lcd_panel sdp3430_panel = {
> +	.name		= "sdp3430",
> +	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> +			  OMAP_LCDC_INV_HSYNC,
> +
> +	.bpp		= 16,
> +	.data_lines	= 16,
> +	.x_res		= 240,
> +	.y_res		= 320,
> +	.hsw		= 3,		/* hsync_len (4) - 1 */
> +	.hfp		= 3,		/* right_margin (4) - 1 */
> +	.hbp		= 39,		/* left_margin (40) - 1 */
> +	.vsw		= 1,		/* vsync_len (2) - 1 */
> +	.vfp		= 2,		/* lower_margin */
> +	.vbp		= 7,		/* upper_margin (8) - 1 */
> +
> +	.pixel_clock	= LCD_PIXCLOCK_MAX,
> +
> +	.init		= sdp3430_panel_init,
> +	.cleanup	= sdp3430_panel_cleanup,
> +	.enable		= sdp3430_panel_enable,
> +	.disable	= sdp3430_panel_disable,
> +	.get_caps	= sdp3430_panel_get_caps,
> +};
> +
> +static int sdp3430_panel_probe(struct platform_device *pdev)
> +{
> +	omapfb_register_panel(&sdp3430_panel);
> +	return 0;
> +}
> +
> +static int sdp3430_panel_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int sdp3430_panel_suspend(struct platform_device *pdev,
> +					pm_message_t mesg)
> +{
> +	return 0;
> +}
> +
> +static int sdp3430_panel_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +struct platform_driver sdp3430_panel_driver = {
> +	.probe		= sdp3430_panel_probe,
> +	.remove		= sdp3430_panel_remove,
> +	.suspend	= sdp3430_panel_suspend,
> +	.resume		= sdp3430_panel_resume,
> +	.driver		= {
> +		.name		= "sdp3430_lcd",
> +		.owner		= THIS_MODULE,
> +	},
> +};
> +
> +static int __init sdp3430_panel_drv_init(void)
> +{
> +	return platform_driver_register(&sdp3430_panel_driver);
> +}
> +
> +static void __exit sdp3430_panel_drv_exit(void)
> +{
> +	platform_driver_unregister(&sdp3430_panel_driver);
> +}
> +
> +module_init(sdp3430_panel_drv_init);
> +module_exit(sdp3430_panel_drv_exit);
> +
> +MODULE_ALIAS("platform:sdp3430_lcd");
> -- 
> 1.5.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
