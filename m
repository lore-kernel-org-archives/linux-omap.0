From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/4] Add support for DEVKIT8000 LCD
Date: Thu, 12 Nov 2009 16:28:22 +0530
Message-ID: <ce9ab5790911120258t3f34ec0cl2140863b25fb8581@mail.gmail.com>
References: <838d5a2d54d0668ad72fffee7196d595@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44961 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbZKLK6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:58:39 -0500
Received: by fxm21 with SMTP id 21so2072860fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 02:58:44 -0800 (PST)
In-Reply-To: <838d5a2d54d0668ad72fffee7196d595@djdvant.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Botherway <kbotherway@djdvant.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

'Signed-off-by' missing.

On Thu, Nov 12, 2009 at 3:53 PM, Kim Botherway <kbotherway@djdvant.com>=
 wrote:
> This patch add support for the Timll DEVKIT8000 LCD panel
>
>
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefil=
e
> index b63b198..b906d25 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -33,6 +33,7 @@ objs-y$(CONFIG_MACH_OMAP_LDP) +=3D lcd_ldp.o
> =A0objs-y$(CONFIG_MACH_OMAP2EVM) +=3D lcd_omap2evm.o
> =A0objs-y$(CONFIG_MACH_OMAP3EVM) +=3D lcd_omap3evm.o
> =A0objs-y$(CONFIG_MACH_OMAP3_BEAGLE) +=3D lcd_omap3beagle.o
> +objs-y$(CONFIG_MACH_OMAP3_DEVKIT8000) +=3D lcd_omap3devkit8000.o
> =A0objs-y$(CONFIG_FB_OMAP_LCD_MIPID) +=3D lcd_mipid.o
> =A0objs-y$(CONFIG_MACH_OVERO) +=3D lcd_overo.o
>
> diff --git a/drivers/video/omap/lcd_omap3devkit8000.c
> b/drivers/video/omap/lcd_omap3devkit8000.c
> new file mode 100644
> index 0000000..242cece
> --- /dev/null
> +++ b/drivers/video/omap/lcd_omap3devkit8000.c
> @@ -0,0 +1,132 @@
> +/*
> + * LCD panel support for the TI OMAP3 Beagle board
> + *
> + * Author: Koen Kooi <koen@openembedded.org>
> + *
> + * Derived from drivers/video/omap/lcd-omap3evm.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA =A002111-1307, USA.
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
> +#define LCD_PANEL_ENABLE_GPIO =A0 =A0 =A0 170
> +
> +static int omap3devkit8000_panel_init(struct lcd_panel *panel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
omapfb_device *fbdev)
> +{
> + =A0 =A0 =A0 gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void omap3devkit8000_panel_cleanup(struct lcd_panel *panel)
> +{
> + =A0 =A0 =A0 gpio_free(LCD_PANEL_ENABLE_GPIO);
> +}
> +
> +static int omap3devkit8000_panel_enable(struct lcd_panel *panel)
> +{
> + =A0 =A0 =A0 gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void omap3devkit8000_panel_disable(struct lcd_panel *panel)
> +{
> + =A0 =A0 =A0 gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> +}
> +
> +static unsigned long omap3devkit8000_panel_get_caps(struct lcd_panel
> *panel)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct lcd_panel omap3devkit8000_panel =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap3devkit8000",
> + =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =3D OMAP_LCDC_PANEL_TFT,
> + =A0 =A0 =A0 .bpp =A0 =A0 =A0 =A0 =A0 =A0=3D 16,
> + =A0 =A0 =A0 .data_lines =A0 =A0 =3D 24,
> +
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "7inch_LCD",
> + =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=3D 800,
> + =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=3D 480,
> + =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=3D 48, =A0 /* hsync_len (4=
) - 1 */
> + =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=3D 1, =A0 =A0 =A0/* right_=
margin (4) - 1 */
> + =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=3D 1, =A0 =A0 =A0/* left_m=
argin (40) - 1 */
> + =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=3D 3, =A0 =A0 =A0 /* vsync=
_len (2) - 1 */
> + =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=3D 12, =A0 =A0 /* lower_ma=
rgin */
> + =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 25, =A0 =A0 /* upper_ma=
rgin (8) - 1 */
> + =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 36000,
> +
> + =A0 =A0 =A0 .init =A0 =A0 =A0 =A0 =A0 =3D omap3devkit8000_panel_ini=
t,
> + =A0 =A0 =A0 .cleanup =A0 =A0 =A0 =A0=3D omap3devkit8000_panel_clean=
up,
> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D omap3devkit8000_panel_enabl=
e,
> + =A0 =A0 =A0 .disable =A0 =A0 =A0 =A0=3D omap3devkit8000_panel_disab=
le,
> + =A0 =A0 =A0 .get_caps =A0 =A0 =A0 =3D omap3devkit8000_panel_get_cap=
s,
> +
> +};
> +
> +
> +static int omap3devkit8000_panel_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 omapfb_register_panel(&omap3devkit8000_panel);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap3devkit8000_panel_remove(struct platform_device *pdev=
)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap3devkit8000_panel_suspend(struct platform_device *pde=
v,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pm_message_t mesg)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap3devkit8000_panel_resume(struct platform_device *pdev=
)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct platform_driver omap3devkit8000_panel_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap3devkit8000_panel_pro=
be,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap3devkit8000_panel_remov=
e,
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D omap3devkit8000_panel_suspe=
nd,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D omap3devkit8000_panel_resum=
e,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap3devkit8000_lcd",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init omap3devkit8000_panel_drv_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&omap3devkit8000_panel_=
driver);
> +}
> +
> +static void __exit omap3devkit8000_panel_drv_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&omap3devkit8000_panel_drive=
r);
> +}
> +
> +module_init(omap3devkit8000_panel_drv_init);
> +module_exit(omap3devkit8000_panel_drv_exit);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
