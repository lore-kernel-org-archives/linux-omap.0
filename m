From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 7/8] Video driver of Always Innovating OMAP3-based Touch
 Book
Date: Fri, 20 Nov 2009 09:37:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404370D6FA1@dbde02.ent.ti.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <1258651091-31727-4-git-send-email-gregoire@gentil.com>
 <1258651091-31727-5-git-send-email-gregoire@gentil.com>
 <1258651091-31727-6-git-send-email-gregoire@gentil.com>
 <1258651091-31727-7-git-send-email-gregoire@gentil.com>
 <1258651091-31727-8-git-send-email-gregoire@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718AbZKTEHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 23:07:35 -0500
In-Reply-To: <1258651091-31727-8-git-send-email-gregoire@gentil.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gregoire Gentil
> Sent: Thursday, November 19, 2009 10:48 PM
> To: linux-omap@vger.kernel.org
> Cc: Gregoire Gentil; Tony Lindgren; Tim Yamin
> Subject: [PATCH 7/8] Video driver of Always Innovating OMAP3-based
> Touch Book
> 
> 
> Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
> ---
>  drivers/video/omap/lcd_omap3touchbook.c |  130
> +++++++++++++++++++++++++++++++
>  1 files changed, 130 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap/lcd_omap3touchbook.c
> 
> diff --git a/drivers/video/omap/lcd_omap3touchbook.c
> b/drivers/video/omap/lcd_omap3touchbook.c
> new file mode 100644
> index 0000000..5b58703
> --- /dev/null
> +++ b/drivers/video/omap/lcd_omap3touchbook.c
> @@ -0,0 +1,130 @@
> +/*
> + * LCD panel support for the Touch Book
> + *
> + * Author: Gregoire Gentil <gregoire@gentil.com>
> + *
> + * Derived from drivers/video/omap/lcd-omap3beagle.c
> + *
> + * This program is free software; you can redistribute it and/or
> modify it
> + * under the terms of the GNU General Public License as published
> by the
> + * Free Software Foundation; either version 2 of the License, or
> (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> License along
> + * with this program; if not, write to the Free Software
> Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#include <plat/mux.h>
> +#include <plat/omapfb.h>
> +#include <asm/mach-types.h>
> +
> +#define LCD_PANEL_ENABLE_GPIO       176
> +
> +static int omap3beagle_panel_init(struct lcd_panel *panel,
> +				struct omapfb_device *fbdev)
> +{
> +	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
> +	return 0;
> +}
> +
> +static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
> +{
> +	gpio_free(LCD_PANEL_ENABLE_GPIO);
> +}
> +
> +static int omap3beagle_panel_enable(struct lcd_panel *panel)
> +{
> +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> +	return 0;
> +}
> +
> +static void omap3beagle_panel_disable(struct lcd_panel *panel)
> +{
> +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> +}
> +
> +static unsigned long omap3beagle_panel_get_caps(struct lcd_panel
> *panel)
> +{
> +	return 0;
> +}
> +
> +struct lcd_panel omap3beagle_panel = {
> +	.name		= "omap3beagle",
> +	.config		= OMAP_LCDC_PANEL_TFT,
> +
> +	.bpp		= 16,
> +	.data_lines	= 24,
> +	.x_res		= 1024,
> +	.y_res		= 600,
> +	.hsw		= 3,
> +	.hfp		= 3,
> +	.hbp		= 39,
> +	.vsw		= 1,
> +	.vfp		= 2,
> +	.vbp		= 7,
> +
> +	.pixel_clock	= 64000,
> +
> +	.init		= omap3touchbook_panel_init,
> +	.cleanup	= omap3touchbook_panel_cleanup,
> +	.enable		= omap3touchbook_panel_enable,
> +	.disable	= omap3touchbook_panel_disable,
> +	.get_caps	= omap3touchbook_panel_get_caps,
[Hiremath, Vaibhav] Have you compiled this file? Here all references are for omap3touchbook_xxx and the function definitions are defined as omap3beagle_xxx.

And again I don't see any change except GPIO pin and LCD height from beagle here, can we try to reuse the driver.

Thanks,
Vaibhav

> +};
> +
> +static int omap3touchbook_panel_probe(struct platform_device *pdev)
> +{
> +	omapfb_register_panel(&omap3beagle_panel);
> +	return 0;
> +}
> +
> +static int omap3touchbook_panel_remove(struct platform_device
> *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap3touchbook_panel_suspend(struct platform_device
> *pdev,
> +				   pm_message_t mesg)
> +{
> +	return 0;
> +}
> +
> +static int omap3touchbook_panel_resume(struct platform_device
> *pdev)
> +{
> +	return 0;
> +}
> +
> +struct platform_driver omap3touchbook_panel_driver = {
> +	.probe		= omap3touchbook_panel_probe,
> +	.remove		= omap3touchbook_panel_remove,
> +	.suspend	= omap3touchbook_panel_suspend,
> +	.resume		= omap3touchbook_panel_resume,
> +	.driver		= {
> +		.name	= "omap3touchbook_lcd",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap3touchbook_panel_drv_init(void)
> +{
> +	return platform_driver_register(&omap3beagle_panel_driver);
> +}
> +
> +static void __exit omap3touchbook_panel_drv_exit(void)
> +{
> +	platform_driver_unregister(&omap3touchbook_panel_driver);
> +}
> +
> +module_init(omap3touchbook_panel_drv_init);
> +module_exit(omap3touchbook_panel_drv_exit);
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

