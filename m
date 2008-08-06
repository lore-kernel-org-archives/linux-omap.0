From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resending - PATCH] OMAP2EVM: add LCD panel support
Date: Wed, 6 Aug 2008 11:48:02 +0300
Message-ID: <20080806084801.GD19813@atomide.com>
References: <c656a4d20807030754ta845d4dx7bfd54fb66634a0e@mail.gmail.com> <20080805132552.GF7193@atomide.com> <c656a4d20808052215l28997a15na4427a5932a9884b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51946 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764226AbYHFIsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:48:06 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20808052215l28997a15na4427a5932a9884b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* arun c <arun.edarath@gmail.com> [080806 08:15]:
> omap2evm LCD supports VGA and QVGA resolution, by default its in VGA mode.

Thanks, pushing today.

Tony

> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap2evm.c |   15 +++-
>  drivers/video/omap/Makefile          |    2 +
>  drivers/video/omap/lcd_omap2evm.c    |  195 ++++++++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_omap2evm.c
> 
> diff --git a/arch/arm/mach-omap2/board-omap2evm.c
> b/arch/arm/mach-omap2/board-omap2evm.c
> index 0baf704..13c53cc 100644
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -62,6 +62,15 @@ static inline void __init omap2evm_init_smc911x(void)
> 
>  }
> 
> +static struct platform_device omap2_evm_lcd_device = {
> +	.name		= "omap2evm_lcd",
> +	.id		= -1,
> +};
> +
> +static struct omap_lcd_config omap2_evm_lcd_config __initdata = {
> +	.ctrl_name	= "internal",
> +};
> +
>  static void __init omap2_evm_init_irq(void)
>  {
>  	omap2_init_common_hw(NULL);
> @@ -75,7 +84,8 @@ static struct omap_uart_config omap2_evm_uart_config
> __initdata = {
>  };
> 
>  static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
> -	{OMAP_TAG_UART, &omap2_evm_uart_config},
> +	{ OMAP_TAG_UART,	&omap2_evm_uart_config },
> +	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
>  };
> 
>  static int __init omap2_evm_i2c_init(void)
> @@ -90,7 +100,8 @@ static int __init omap2_evm_i2c_init(void)
>  }
> 
>  static struct platform_device *omap2_evm_devices[] __initdata = {
> -    &omap2evm_smc911x_device,
> +	&omap2_evm_lcd_device,
> +	&omap2evm_smc911x_device,
>  };
> 
>  static void __init omap2_evm_init(void)
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index fe7ee5d..662dff9 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -31,6 +31,8 @@ objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
>  objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
>  objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
>  objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
> +objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
> +objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_3430sdp.o
>  objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
>  objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
>  objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
> diff --git a/drivers/video/omap/lcd_omap2evm.c
> b/drivers/video/omap/lcd_omap2evm.c
> new file mode 100644
> index 0000000..8311cac
> --- /dev/null
> +++ b/drivers/video/omap/lcd_omap2evm.c
> @@ -0,0 +1,195 @@
> +/*
> + * LCD panel support for the MISTRAL OMAP2EVM board
> + *
> + * Author: Arun C <arunedarath@mistralsolutions.com>
> + *
> + * Derived from drivers/video/omap/lcd_omap3evm.c
> + * Derived from drivers/video/omap/lcd-apollon.c
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
> +#include <asm/arch/mux.h>
> +#include <asm/arch/omapfb.h>
> +#include <asm/mach-types.h>
> +
> +#define LCD_PANEL_ENABLE_GPIO	154
> +#define LCD_PANEL_LR		128
> +#define LCD_PANEL_UD		129
> +#define LCD_PANEL_INI		152
> +#define LCD_PANEL_QVGA		148
> +#define LCD_PANEL_RESB		153
> +
> +#define LCD_XRES		480
> +#define LCD_YRES		640
> +#define LCD_PIXCLOCK_MAX	20000 /* in kHz */
> +
> +#define TWL_LED_LEDEN		0x00
> +#define TWL_PWMA_PWMAON		0x00
> +#define TWL_PWMA_PWMAOFF	0x01
> +
> +static unsigned int bklight_level;
> +
> +static int omap2evm_panel_init(struct lcd_panel *panel,
> +				struct omapfb_device *fbdev)
> +{
> +	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
> +	omap_request_gpio(LCD_PANEL_LR);
> +	omap_request_gpio(LCD_PANEL_UD);
> +	omap_request_gpio(LCD_PANEL_INI);
> +	omap_request_gpio(LCD_PANEL_QVGA);
> +	omap_request_gpio(LCD_PANEL_RESB);
> +
> +	omap_set_gpio_direction(LCD_PANEL_ENABLE_GPIO, 0);
> +	omap_set_gpio_direction(LCD_PANEL_LR, 0);
> +	omap_set_gpio_direction(LCD_PANEL_UD, 0);
> +	omap_set_gpio_direction(LCD_PANEL_INI, 0);
> +	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
> +	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
> +
> +	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
> +	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
> +	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
> +	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
> +	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
> +
> +	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> +	bklight_level = 100;
> +
> +	return 0;
> +}
> +
> +static void omap2evm_panel_cleanup(struct lcd_panel *panel)
> +{
> +}
> +
> +static int omap2evm_panel_enable(struct lcd_panel *panel)
> +{
> +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
> +	return 0;
> +}
> +
> +static void omap2evm_panel_disable(struct lcd_panel *panel)
> +{
> +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
> +}
> +
> +static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
> +{
> +	return 0;
> +}
> +
> +static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
> +						unsigned int level)
> +{
> +	u8 c;
> +	if ((level >= 0) && (level <= 100)) {
> +		c = (125 * (100 - level)) / 100 + 2;
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
> +		bklight_level = level;
> +	}
> +	return 0;
> +}
> +
> +static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
> +{
> +	return bklight_level;
> +}
> +
> +static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
> +{
> +	return 100;
> +}
> +
> +struct lcd_panel omap2evm_panel = {
> +	.name		= "omap2evm",
> +	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> +			  OMAP_LCDC_INV_HSYNC,
> +
> +	.bpp		= 16,
> +	.data_lines	= 18,
> +	.x_res		= LCD_XRES,
> +	.y_res		= LCD_YRES,
> +	.hsw		= 3,
> +	.hfp		= 0,
> +	.hbp		= 28,
> +	.vsw		= 2,
> +	.vfp		= 1,
> +	.vbp		= 0,
> +
> +	.pixel_clock	= LCD_PIXCLOCK_MAX,
> +
> +	.init		= omap2evm_panel_init,
> +	.cleanup	= omap2evm_panel_cleanup,
> +	.enable		= omap2evm_panel_enable,
> +	.disable	= omap2evm_panel_disable,
> +	.get_caps	= omap2evm_panel_get_caps,
> +	.set_bklight_level      = omap2evm_bklight_setlevel,
> +	.get_bklight_level      = omap2evm_bklight_getlevel,
> +	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
> +};
> +
> +static int omap2evm_panel_probe(struct platform_device *pdev)
> +{
> +	omapfb_register_panel(&omap2evm_panel);
> +	return 0;
> +}
> +
> +static int omap2evm_panel_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap2evm_panel_suspend(struct platform_device *pdev,
> +				   pm_message_t mesg)
> +{
> +	return 0;
> +}
> +
> +static int omap2evm_panel_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +struct platform_driver omap2evm_panel_driver = {
> +	.probe		= omap2evm_panel_probe,
> +	.remove		= omap2evm_panel_remove,
> +	.suspend	= omap2evm_panel_suspend,
> +	.resume		= omap2evm_panel_resume,
> +	.driver		= {
> +		.name	= "omap2evm_lcd",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap2evm_panel_drv_init(void)
> +{
> +	return platform_driver_register(&omap2evm_panel_driver);
> +}
> +
> +static void __exit omap2evm_panel_drv_exit(void)
> +{
> +	platform_driver_unregister(&omap2evm_panel_driver);
> +}
> +
> +module_init(omap2evm_panel_drv_init);
> +module_exit(omap2evm_panel_drv_exit);
> -- 
> 1.5.6.4
