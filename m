From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] [OMAP] htcherald: Add board support and LCD for
 HTC Herald
Date: Tue, 10 Nov 2009 15:40:27 -0800
Message-ID: <20091110234026.GF23952@atomide.com>
References: <6cb013310910032157p19438de3h672fb68a100f7f90@mail.gmail.com>
 <6cb013310910040941k19f07c4fr831820aaeed93b6d@mail.gmail.com>
 <6cb013310910040942o241097am36915b561f2e9805@mail.gmail.com>
 <6cb013310910041032p2abbb4adycd2dfe6f79e4956f@mail.gmail.com>
 <6cb013310910041033m2c606d24g6db199326800ee14@mail.gmail.com>
 <6cb013310910041405q6e3d52b6tbdc38a14c7314916@mail.gmail.com>
 <6cb013310910041406l3c6c3094raa4b92bbec78281a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53933 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909AbZKJXkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 18:40:25 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310910041406l3c6c3094raa4b92bbec78281a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

Tried adding this to omap for-next, can you please refresh
and repost the whole series against current omap for-next branch?

Also few minor comments below.

* Cory Maccarrone <darkstar6262@gmail.com> [091004 14:21]:
> This patch introduces support for the HTC Herald (T-Mobile
> Wing, etc.) series of smart phones -- board support and LCD
> panel settings.
>=20
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/board-htcherald.c |  246 +++++++++++++++++++++++=
++++++++++
>  drivers/video/omap/lcd_htcherald.c    |  129 +++++++++++++++++
>  2 files changed, 375 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/board-htcherald.c
>  create mode 100644 drivers/video/omap/lcd_htcherald.c
>=20
> diff --git a/arch/arm/mach-omap1/board-htcherald.c
> b/arch/arm/mach-omap1/board-htcherald.c
> new file mode 100644
> index 0000000..e21cf9a
> --- /dev/null
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -0,0 +1,246 @@
> +/*
> + * HTC Herald board configuration
> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> + * Copyright (C) 2009 Wing Linux
> + *
> + * Based on the board-htcwizard.c file from the linwizard project:
> + * Copyright (C) 2006 Unai Uribarri
> + * Copyright (C) 2008 linwizard.sourceforge.net
> + *
> + * This  program is  free  software; you  can  redistribute it  and/=
or
> + * modify  it under the  terms of  the GNU  General Public  License =
as
> + * published by the Free Software  Foundation; either version 2 of t=
he
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  =
of
> + * MERCHANTABILITY or  FITNESS FOR A PARTICULAR PURPOSE.   See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have  received a copy of the  GNU General Public Licen=
se
> + * along  with  this program;  if  not,  write  to the  Free  Softwa=
re
> + * Foundation,  Inc.,  51 Franklin  Street,  Fifth  Floor, Boston,  =
MA
> + * 02110-1301, USA.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/omap7xx.h>
> +#include <asm/page.h>
> +#include <asm/memory.h>
> +#include <mach/common.h>
> +#include <mach/board.h>
> +
> +#include <mach/io.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>
> +#include <mach/keypad.h>

Please use linux/io.h and linux/gpio.h.


> +
> +#include <linux/delay.h>
> +
> +/* LCD register definition */
> +#define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
> +#define       OMAP_LCDC_STATUS                (0xfffec000 + 0x10)
> +#define       OMAP_DMA_LCD_CCR                (0xfffee300 + 0xc2)
> +#define       OMAP_DMA_LCD_CTRL               (0xfffee300 + 0xc4)
> +#define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
> +#define       OMAP_LCDC_STAT_DONE             (1 << 0)
> +
> +static struct omap_lcd_config htcherald_lcd_config __initdata =3D {
> +	.ctrl_name	=3D "internal",
> +};
> +
> +static struct omap_board_config_kernel htcherald_config[] __initdata=
 =3D
> +{
> +	{ OMAP_TAG_LCD, &htcherald_lcd_config },
> +};
> +
> +/* Keyboard definition */
> +
> +static int htc_herald_keymap[] =3D {
> +	KEY(0,0,KEY_RECORD), /* Mail button */
> +	KEY(0,1,KEY_CAMERA), /* Camera */
> +	KEY(0,2,KEY_PHONE), /* Send key */
> +	KEY(0,3,KEY_VOLUMEUP), /* Volume up */
> +	KEY(0,4,KEY_F2),  /* Right bar (landscape) */
> +	KEY(0,5,KEY_MAIL), /* Win key (portrait) */
> +	KEY(0,6,KEY_DIRECTORY), /* Right bar (protrait) */
> +	KEY(1,0,KEY_LEFTCTRL), /* Windows key */
> +	KEY(1,1,KEY_COMMA),
> +	KEY(1,2,KEY_M),
> +	KEY(1,3,KEY_K),
> +	KEY(1,4,KEY_SLASH), /* OK key */
> +	KEY(1,5,KEY_I),
> +	KEY(1,6,KEY_U),
> +	KEY(2,0,KEY_LEFTALT),
> +	KEY(2,1,KEY_TAB),
> +	KEY(2,2,KEY_N),
> +	KEY(2,3,KEY_J),
> +	KEY(2,4,KEY_ENTER),
> +	KEY(2,5,KEY_H),
> +	KEY(2,6,KEY_Y),
> +	KEY(3,0,KEY_SPACE),
> +	KEY(3,1,KEY_L),
> +	KEY(3,2,KEY_B),
> +	KEY(3,3,KEY_V),
> +	KEY(3,4,KEY_BACKSPACE),
> +	KEY(3,5,KEY_G),
> +	KEY(3,6,KEY_T),
> +	KEY(4,0,KEY_CAPSLOCK), /* Shift */
> +	KEY(4,1,KEY_C),
> +	KEY(4,2,KEY_F),
> +	KEY(4,3,KEY_R),
> +	KEY(4,4,KEY_O),
> +	KEY(4,5,KEY_E),
> +	KEY(4,6,KEY_D),
> +	KEY(5,0,KEY_X),
> +	KEY(5,1,KEY_Z),
> +	KEY(5,2,KEY_S),
> +	KEY(5,3,KEY_W),
> +	KEY(5,4,KEY_P),
> +	KEY(5,5,KEY_Q),
> +	KEY(5,6,KEY_A),
> +	KEY(6,0,KEY_CONNECT), /* Voice button */
> +	KEY(6,2,KEY_CANCEL), /* End key */
> +	KEY(6,3,KEY_VOLUMEDOWN), /* Volume down */
> +	KEY(6,4,KEY_F1), /* Left bar (landscape) */
> +	KEY(6,5,KEY_WWW), /* OK button (portrait) */
> +	KEY(6,6,KEY_CALENDAR), /* Left bar (portrait) */
> +	0
> +};
> +
> +struct omap_kp_platform_data htcherald_kp_data =3D {
> +	.rows	=3D 7,
> +	.cols	=3D 7,
> +	.delay =3D 20,
> +	.rep =3D 1,
> +	.keymap =3D htc_herald_keymap,
> +};
> +
> +static struct resource kp_resources[] =3D {
> +	[0] =3D {
> +		.start	=3D INT_7XX_MPUIO_KEYPAD,
> +		.end	=3D INT_7XX_MPUIO_KEYPAD,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device kp_device =3D {
> +	.name		=3D "omap-keypad",
> +	.id		=3D -1,
> +	.dev		=3D {
> +		.platform_data =3D &htcherald_kp_data,
> +	},
> +	.num_resources	=3D ARRAY_SIZE(kp_resources),
> +	.resource	=3D kp_resources,
> +};
> +
> +/* LCD Device resources */
> +static struct platform_device lcd_device =3D {
> +	.name           =3D "lcd_htcherald",
> +	.id             =3D -1,
> +};
> +
> +static struct platform_device *devices[] __initdata =3D {
> +	&kp_device,
> +	&lcd_device,
> +};
> +
> +/*
> + * Init functions from here on
> + */
> +
> +static void __init htcherald_lcd_init(void)
> +{
> +	u32 reg;
> +	unsigned int tries =3D 200;
> +
> +	/* disable controller if active */
> +	reg =3D omap_readl(OMAP_LCDC_CONTROL);
> +	if (reg & OMAP_LCDC_CTRL_LCD_EN) {
> +		reg &=3D ~OMAP_LCDC_CTRL_LCD_EN;
> +		omap_writel(reg, OMAP_LCDC_CONTROL);
> +
> +		/* wait for end of frame */
> +		while (!(omap_readl(OMAP_LCDC_STATUS) & OMAP_LCDC_STAT_DONE) && --=
tries);
> +		if (!tries) {
> +			printk(KERN_WARNING "Timeout waiting for end of frame -- LCD may
> not be available\n");
> +		}

Bad wrapping in the patch at least here that causes it not to apply.


> +
> +		/* turn off DMA */
> +		reg =3D omap_readw(OMAP_DMA_LCD_CCR);
> +		reg &=3D ~(1 << 7);
> +		omap_writew(reg, OMAP_DMA_LCD_CCR);
> +
> +		reg =3D omap_readw(OMAP_DMA_LCD_CTRL);
> +		reg &=3D ~(1 << 8);
> +		omap_writew(reg, OMAP_DMA_LCD_CTRL);
> +	}
> +}
> +
> +static void __init htcherald_map_io(void)
> +{
> +	omap1_map_common_io();
> +
> +	/*
> +	 * The LCD panel must be disabled and DMA turned off here, as doing
> +	 * it later causes the LCD never to reinitialize.
> +	 */
> +	htcherald_lcd_init();
> +
> +	printk(KERN_INFO "htcherald_map_io done.\n");
> +}
> +
> +static void __init htcherald_disable_watchdog(void)
> +{
> +	/* Disable watchdog if running */
> +	if (omap_readl(OMAP_WDT_TIMER_MODE) & 0x8000) {
> +		/*
> +		 * disable a potentially running watchdog timer before
> +		 * it kills us.
> +		 */
> +		printk(KERN_WARNING "OMAP850 Watchdog seems to be activated,
> disabling it for now.\n");
> +		omap_writel(0xF5, OMAP_WDT_TIMER_MODE);
> +		omap_writel(0xA0, OMAP_WDT_TIMER_MODE);
> +	}

Wrapped here too.


> +}
> +
> +static void __init htcherald_init(void)
> +{
> +	printk(KERN_INFO "HTC Herald init.\n");
> +
> +	omap_gpio_init();
> +
> +	omap_board_config =3D htcherald_config;
> +	omap_board_config_size =3D ARRAY_SIZE(htcherald_config);
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +
> +	htcherald_disable_watchdog();
> +}
> +
> +static void __init htcherald_init_irq(void)
> +{
> +	printk(KERN_INFO "htcherald_init_irq.\n");
> +	omap1_init_common_hw();
> +	omap_init_irq();
> +}
> +
> +MACHINE_START(HERALD, "HTC Herald")
> +	/* Maintainer: Cory Maccarrone <darkstar6262@gmail.com> */
> +	/* Maintainer: wing-linux.sourceforge.net */
> +	.phys_io        =3D 0xfff00000,
> +	.io_pg_offst    =3D ((0xfef00000) >> 18) & 0xfffc,
> +	.boot_params    =3D 0x10000100,
> +	.map_io         =3D htcherald_map_io,
> +	.init_irq       =3D htcherald_init_irq,
> +	.init_machine   =3D htcherald_init,
> +	.timer          =3D &omap_timer,
> +MACHINE_END
> diff --git a/drivers/video/omap/lcd_htcherald.c
> b/drivers/video/omap/lcd_htcherald.c
> new file mode 100644
> index 0000000..c203f92
> --- /dev/null
> +++ b/drivers/video/omap/lcd_htcherald.c
> @@ -0,0 +1,129 @@
> +/*
> + * File: drivers/video/omap/lcd-htcherald.c
> + *
> + * LCD panel support for the HTC Herald
> + *
> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> + * Copyright (C) 2009 Wing Linux
> + *
> + * Based on the lcd_htcwizard.c file from the linwizard project:
> + * Copyright (C) linwizard.sourceforge.net
> + * Author: Angelo Arrifano <miknix@gmail.com>
> + * Based on lcd_h4 by Imre Deak <imre.deak@nokia.com>
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
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/omapfb.h>
> +
> +static int htcherald_panel_init(struct lcd_panel *panel,
> +                                struct omapfb_device *fbdev)
> +{
> +	return 0;
> +}
> +
> +static void htcherald_panel_cleanup(struct lcd_panel *panel)
> +{
> +}
> +
> +static int htcherald_panel_enable(struct lcd_panel *panel)
> +{
> +	return 0;
> +}
> +
> +static void htcherald_panel_disable(struct lcd_panel *panel)
> +{
> +}
> +
> +static unsigned long htcherald_panel_get_caps(struct lcd_panel *pane=
l)
> +{
> +	return 0;
> +}
> +
> +/* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) */
> +struct lcd_panel htcherald_panel_1 =3D {
> +	.name		=3D "lcd_herald",
> +	.config		=3D OMAP_LCDC_PANEL_TFT |
> +			  OMAP_LCDC_INV_HSYNC |
> +			  OMAP_LCDC_INV_VSYNC |
> +			  OMAP_LCDC_INV_PIX_CLOCK,
> +	.bpp		=3D 16,
> +	.data_lines	=3D 16,
> +	.x_res		=3D 240,
> +	.y_res		=3D 320,
> +	.pixel_clock	=3D 6093,
> +	.pcd		=3D 0, /* 15 */
> +	.hsw		=3D 10,
> +	.hfp		=3D 10,
> +	.hbp		=3D 20,
> +	.vsw		=3D 3,
> +	.vfp		=3D 2,
> +	.vbp		=3D 2,
> +
> +	.init		=3D htcherald_panel_init,
> +	.cleanup	=3D htcherald_panel_cleanup,
> +	.enable		=3D htcherald_panel_enable,
> +	.disable	=3D htcherald_panel_disable,
> +	.get_caps	=3D htcherald_panel_get_caps,
> +};
> +
> +static int htcherald_panel_probe(struct platform_device *pdev)
> +{
> +	omapfb_register_panel(&htcherald_panel_1);
> +	return 0;
> +}
> +
> +static int htcherald_panel_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int htcherald_panel_suspend(struct platform_device *pdev,
> pm_message_t mesg)
> +{
> +	return 0;
> +}
> +
> +static int htcherald_panel_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +struct platform_driver htcherald_panel_driver =3D {
> +	.probe		=3D htcherald_panel_probe,
> +	.remove		=3D htcherald_panel_remove,
> +	.suspend	=3D htcherald_panel_suspend,
> +	.resume		=3D htcherald_panel_resume,
> +	.driver		=3D {
> +		.name	=3D "lcd_htcherald",
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +static int htcherald_panel_drv_init(void)
> +{
> +	return platform_driver_register(&htcherald_panel_driver);
> +}
> +
> +static void htcherald_panel_drv_cleanup(void)
> +{
> +	platform_driver_unregister(&htcherald_panel_driver);
> +}
> +
> +module_init(htcherald_panel_drv_init);
> +module_exit(htcherald_panel_drv_cleanup);
> +
> --=20
> 1.5.6.3
>=20
>=20
> On Sun, Oct 4, 2009 at 2:05 PM, Cory Maccarrone <darkstar6262@gmail.c=
om> wrote:
> > After doing more testing, it seems that putting the LCD disable cod=
e
> > in lcd_htcherald.c is too late in the bootup -- it only worked
> > intermittently at best, failing to work most of the time.
> >
> > As such, I've moved that code back into the board file and call it
> > just after omap1_map_common_io(). =A0With this in place, the frameb=
uffer
> > is reliably enabled.
> >
> > This should hopefully be the last revision of this patch I make --
> > sorry for all the patch spam.
> >
> > - Cory
> >
> > On Sun, Oct 4, 2009 at 10:33 AM, Cory Maccarrone <darkstar6262@gmai=
l.com> wrote:
> >> This patch introduces support for the HTC Herald (T-Mobile
> >> Wing, etc.) series of smart phones -- board support and LCD
> >> panel settings.
> >>
> >> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> >> ---
> >> =A0arch/arm/mach-omap1/board-htcherald.c | =A0203 ++++++++++++++++=
+++++++++++++++++
> >> =A0drivers/video/omap/lcd_htcherald.c =A0 =A0| =A0164 ++++++++++++=
++++++++++++++
> >> =A02 files changed, 367 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 arch/arm/mach-omap1/board-htcherald.c
> >> =A0create mode 100644 drivers/video/omap/lcd_htcherald.c
> >>
> >> diff --git a/arch/arm/mach-omap1/board-htcherald.c
> >> b/arch/arm/mach-omap1/board-htcherald.c
> >> new file mode 100644
> >> index 0000000..93f8903
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap1/board-htcherald.c
> >> @@ -0,0 +1,203 @@
> >> +/*
> >> + * HTC Herald board configuration
> >> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> >> + * Copyright (C) 2009 Wing Linux
> >> + *
> >> + * Based on the board-htcwizard.c file from the linwizard project=
:
> >> + * Copyright (C) 2006 Unai Uribarri
> >> + * Copyright (C) 2008 linwizard.sourceforge.net
> >> + *
> >> + * This =A0program is =A0free =A0software; you =A0can =A0redistri=
bute it =A0and/or
> >> + * modify =A0it under the =A0terms of =A0the GNU =A0General Publi=
c =A0License as
> >> + * published by the Free Software =A0Foundation; either version 2=
 of the
> >> + * License, or (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful=
, but
> >> + * WITHOUT =A0ANY =A0WARRANTY; =A0without =A0 even =A0the =A0impl=
ied =A0warranty =A0of
> >> + * MERCHANTABILITY or =A0FITNESS FOR A PARTICULAR PURPOSE. =A0 Se=
e the GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have =A0received a copy of the =A0GNU General Publi=
c License
> >> + * along =A0with =A0this program; =A0if =A0not, =A0write =A0to th=
e =A0Free =A0Software
> >> + * Foundation, =A0Inc., =A051 Franklin =A0Street, =A0Fifth =A0Flo=
or, Boston, =A0MA
> >> + * 02110-1301, USA.
> >> + *
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/init.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/input.h>
> >> +#include <linux/bootmem.h>
> >> +
> >> +#include <asm/mach-types.h>
> >> +#include <asm/mach/arch.h>
> >> +#include <asm/mach/map.h>
> >> +#include <mach/omap7xx.h>
> >> +#include <asm/page.h>
> >> +#include <asm/memory.h>
> >> +#include <mach/common.h>
> >> +#include <mach/board.h>
> >> +
> >> +#include <mach/io.h>
> >> +#include <mach/irqs.h>
> >> +#include <mach/gpio.h>
> >> +#include <mach/keypad.h>
> >> +
> >> +#include <linux/delay.h>
> >> +
> >> +static struct omap_lcd_config htcherald_lcd_config __initdata =3D=
 {
> >> + =A0 =A0 =A0 .ctrl_name =A0 =A0 =A0=3D "internal",
> >> +};
> >> +
> >> +static struct omap_board_config_kernel htcherald_config[] __initd=
ata =3D
> >> +{
> >> + =A0 =A0 =A0 { OMAP_TAG_LCD, &htcherald_lcd_config },
> >> +};
> >> +
> >> +/* Keyboard definition */
> >> +
> >> +static int htc_herald_keymap[] =3D {
> >> + =A0 =A0 =A0 KEY(0,0,KEY_RECORD), /* Mail button */
> >> + =A0 =A0 =A0 KEY(0,1,KEY_CAMERA), /* Camera */
> >> + =A0 =A0 =A0 KEY(0,2,KEY_PHONE), /* Send key */
> >> + =A0 =A0 =A0 KEY(0,3,KEY_VOLUMEUP), /* Volume up */
> >> + =A0 =A0 =A0 KEY(0,4,KEY_F2), =A0/* Right bar (landscape) */
> >> + =A0 =A0 =A0 KEY(0,5,KEY_MAIL), /* Win key (portrait) */
> >> + =A0 =A0 =A0 KEY(0,6,KEY_DIRECTORY), /* Right bar (protrait) */
> >> + =A0 =A0 =A0 KEY(1,0,KEY_LEFTCTRL), /* Windows key */
> >> + =A0 =A0 =A0 KEY(1,1,KEY_COMMA),
> >> + =A0 =A0 =A0 KEY(1,2,KEY_M),
> >> + =A0 =A0 =A0 KEY(1,3,KEY_K),
> >> + =A0 =A0 =A0 KEY(1,4,KEY_SLASH), /* OK key */
> >> + =A0 =A0 =A0 KEY(1,5,KEY_I),
> >> + =A0 =A0 =A0 KEY(1,6,KEY_U),
> >> + =A0 =A0 =A0 KEY(2,0,KEY_LEFTALT),
> >> + =A0 =A0 =A0 KEY(2,1,KEY_TAB),
> >> + =A0 =A0 =A0 KEY(2,2,KEY_N),
> >> + =A0 =A0 =A0 KEY(2,3,KEY_J),
> >> + =A0 =A0 =A0 KEY(2,4,KEY_ENTER),
> >> + =A0 =A0 =A0 KEY(2,5,KEY_H),
> >> + =A0 =A0 =A0 KEY(2,6,KEY_Y),
> >> + =A0 =A0 =A0 KEY(3,0,KEY_SPACE),
> >> + =A0 =A0 =A0 KEY(3,1,KEY_L),
> >> + =A0 =A0 =A0 KEY(3,2,KEY_B),
> >> + =A0 =A0 =A0 KEY(3,3,KEY_V),
> >> + =A0 =A0 =A0 KEY(3,4,KEY_BACKSPACE),
> >> + =A0 =A0 =A0 KEY(3,5,KEY_G),
> >> + =A0 =A0 =A0 KEY(3,6,KEY_T),
> >> + =A0 =A0 =A0 KEY(4,0,KEY_CAPSLOCK), /* Shift */
> >> + =A0 =A0 =A0 KEY(4,1,KEY_C),
> >> + =A0 =A0 =A0 KEY(4,2,KEY_F),
> >> + =A0 =A0 =A0 KEY(4,3,KEY_R),
> >> + =A0 =A0 =A0 KEY(4,4,KEY_O),
> >> + =A0 =A0 =A0 KEY(4,5,KEY_E),
> >> + =A0 =A0 =A0 KEY(4,6,KEY_D),
> >> + =A0 =A0 =A0 KEY(5,0,KEY_X),
> >> + =A0 =A0 =A0 KEY(5,1,KEY_Z),
> >> + =A0 =A0 =A0 KEY(5,2,KEY_S),
> >> + =A0 =A0 =A0 KEY(5,3,KEY_W),
> >> + =A0 =A0 =A0 KEY(5,4,KEY_P),
> >> + =A0 =A0 =A0 KEY(5,5,KEY_Q),
> >> + =A0 =A0 =A0 KEY(5,6,KEY_A),
> >> + =A0 =A0 =A0 KEY(6,0,KEY_CONNECT), /* Voice button */
> >> + =A0 =A0 =A0 KEY(6,2,KEY_CANCEL), /* End key */
> >> + =A0 =A0 =A0 KEY(6,3,KEY_VOLUMEDOWN), /* Volume down */
> >> + =A0 =A0 =A0 KEY(6,4,KEY_F1), /* Left bar (landscape) */
> >> + =A0 =A0 =A0 KEY(6,5,KEY_WWW), /* OK button (portrait) */
> >> + =A0 =A0 =A0 KEY(6,6,KEY_CALENDAR), /* Left bar (portrait) */
> >> + =A0 =A0 =A0 0
> >> +};
> >> +
> >> +struct omap_kp_platform_data htcherald_kp_data =3D {
> >> + =A0 =A0 =A0 .rows =A0 =3D 7,
> >> + =A0 =A0 =A0 .cols =A0 =3D 7,
> >> + =A0 =A0 =A0 .delay =3D 20,
> >> + =A0 =A0 =A0 .rep =3D 1,
> >> + =A0 =A0 =A0 .keymap =3D htc_herald_keymap,
> >> +};
> >> +
> >> +static struct resource kp_resources[] =3D {
> >> + =A0 =A0 =A0 [0] =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D INT_7XX_MPUIO_KEYPAD,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D INT_7XX_MPUIO_KEYPAD=
,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> >> + =A0 =A0 =A0 },
> >> +};
> >> +
> >> +static struct platform_device kp_device =3D {
> >> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-keypad",
> >> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> >> + =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &htcherald_kp_dat=
a,
> >> + =A0 =A0 =A0 },
> >> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(kp_resources),
> >> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D kp_resources,
> >> +};
> >> +
> >> +/* LCD Device resources */
> >> +static struct platform_device lcd_device =3D {
> >> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "lcd_htcherald",
> >> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> >> +};
> >> +
> >> +static struct platform_device *devices[] __initdata =3D {
> >> + =A0 =A0 =A0 &kp_device,
> >> + =A0 =A0 =A0 &lcd_device,
> >> +};
> >> +
> >> +/*
> >> + * Init functions from here on
> >> + */
> >> +
> >> +static void __init htcherald_map_io(void)
> >> +{
> >> + =A0 =A0 =A0 omap1_map_common_io();
> >> + =A0 =A0 =A0 printk(KERN_INFO "htcherald_map_io done.\n");
> >> +}
> >> +
> >> +static void __init htcherald_disable_watchdog(void)
> >> +{
> >> + =A0 =A0 =A0 /* Disable watchdog if running */
> >> + =A0 =A0 =A0 if (omap_readl(OMAP_WDT_TIMER_MODE) & 0x8000) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* disable a potentially running w=
atchdog timer before
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it kills us.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "OMAP850 Watchdo=
g seems to be activated,
> >> disabling it for now.\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0xF5, OMAP_WDT_TIMER_MOD=
E);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0xA0, OMAP_WDT_TIMER_MOD=
E);
> >> + =A0 =A0 =A0 }
> >> +}
> >> +
> >> +static void __init htcherald_init(void)
> >> +{
> >> + =A0 =A0 =A0 printk(KERN_INFO "HTC Herald init.\n");
> >> +
> >> + =A0 =A0 =A0 omap_gpio_init();
> >> +
> >> + =A0 =A0 =A0 omap_board_config =3D htcherald_config;
> >> + =A0 =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(htcherald_conf=
ig);
> >> + =A0 =A0 =A0 platform_add_devices(devices, ARRAY_SIZE(devices));
> >> +
> >> + =A0 =A0 =A0 htcherald_disable_watchdog();
> >> +}
> >> +
> >> +static void __init htcherald_init_irq(void)
> >> +{
> >> + =A0 =A0 =A0 printk(KERN_INFO "htcherald_init_irq.\n");
> >> + =A0 =A0 =A0 omap1_init_common_hw();
> >> + =A0 =A0 =A0 omap_init_irq();
> >> +}
> >> +
> >> +MACHINE_START(HERALD, "HTC Herald")
> >> + =A0 =A0 =A0 /* Maintainer: Cory Maccarrone <darkstar6262@gmail.c=
om> */
> >> + =A0 =A0 =A0 /* Maintainer: wing-linux.sourceforge.net */
> >> + =A0 =A0 =A0 .phys_io =A0 =A0 =A0 =A0=3D 0xfff00000,
> >> + =A0 =A0 =A0 .io_pg_offst =A0 =A0=3D ((0xfef00000) >> 18) & 0xfff=
c,
> >> + =A0 =A0 =A0 .boot_params =A0 =A0=3D 0x10000100,
> >> + =A0 =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D htcherald_map_io,
> >> + =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D htcherald_init_irq,
> >> + =A0 =A0 =A0 .init_machine =A0 =3D htcherald_init,
> >> + =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> >> +MACHINE_END
> >> diff --git a/drivers/video/omap/lcd_htcherald.c
> >> b/drivers/video/omap/lcd_htcherald.c
> >> new file mode 100644
> >> index 0000000..eb0dc2c
> >> --- /dev/null
> >> +++ b/drivers/video/omap/lcd_htcherald.c
> >> @@ -0,0 +1,164 @@
> >> +/*
> >> + * File: drivers/video/omap/lcd-htcherald.c
> >> + *
> >> + * LCD panel support for the HTC Herald
> >> + *
> >> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> >> + * Copyright (C) 2009 Wing Linux
> >> + *
> >> + * Based on the lcd_htcwizard.c file from the linwizard project:
> >> + * Copyright (C) linwizard.sourceforge.net
> >> + * Author: Angelo Arrifano <miknix@gmail.com>
> >> + * Based on lcd_h4 by Imre Deak <imre.deak@nokia.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or =
modify it
> >> + * under the terms of the GNU General Public License as published=
 by the
> >> + * Free Software Foundation; either version 2 of the License, or =
(at your
> >> + * option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful=
, but
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e GNU
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public Lice=
nse along
> >> + * with this program; if not, write to the Free Software Foundati=
on, Inc.,
> >> + * 59 Temple Place - Suite 330, Boston, MA =A002111-1307, USA.
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include <mach/omapfb.h>
> >> +#include <mach/io.h>
> >> +
> >> +/* LCD register definition */
> >> +#define =A0 =A0 =A0 OMAP_LCDC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (0xfffec000 + 0x00)
> >> +#define =A0 =A0 =A0 OMAP_LCDC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0xfffec000 + 0x10)
> >> +#define =A0 =A0 =A0 OMAP_DMA_LCD_CCR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0xfffee300 + 0xc2)
> >> +#define =A0 =A0 =A0 OMAP_DMA_LCD_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (0xfffee300 + 0xc4)
> >> +#define =A0 =A0 =A0 OMAP_LCDC_CTRL_LCD_EN =A0 =A0 =A0 =A0 =A0 (1 =
<< 0)
> >> +#define =A0 =A0 =A0 OMAP_LCDC_STAT_DONE =A0 =A0 =A0 =A0 =A0 =A0 (=
1 << 0)
> >> +
> >> +static int htcherald_panel_init(struct lcd_panel *panel,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct omapfb_device *fbdev)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +static void htcherald_panel_cleanup(struct lcd_panel *panel)
> >> +{
> >> +}
> >> +
> >> +static int htcherald_panel_enable(struct lcd_panel *panel)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +static void htcherald_panel_disable(struct lcd_panel *panel)
> >> +{
> >> +}
> >> +
> >> +static unsigned long htcherald_panel_get_caps(struct lcd_panel *p=
anel)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +/* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) =
*/
> >> +struct lcd_panel htcherald_panel_1 =3D {
> >> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "lcd_herald",
> >> + =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =3D OMAP_LCDC_PANEL_TFT |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_HS=
YNC |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_VS=
YNC |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_PI=
X_CLOCK,
> >> + =A0 =A0 =A0 .bpp =A0 =A0 =A0 =A0 =A0 =A0=3D 16,
> >> + =A0 =A0 =A0 .data_lines =A0 =A0 =3D 16,
> >> + =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=3D 240,
> >> + =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=3D 320,
> >> + =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 6093,
> >> + =A0 =A0 =A0 .pcd =A0 =A0 =A0 =A0 =A0 =A0=3D 0, /* 15 */
> >> + =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=3D 10,
> >> + =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=3D 10,
> >> + =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=3D 20,
> >> + =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=3D 3,
> >> + =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> >> + =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> >> +
> >> + =A0 =A0 =A0 .init =A0 =A0 =A0 =A0 =A0 =3D htcherald_panel_init,
> >> + =A0 =A0 =A0 .cleanup =A0 =A0 =A0 =A0=3D htcherald_panel_cleanup,
> >> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D htcherald_panel_enable,
> >> + =A0 =A0 =A0 .disable =A0 =A0 =A0 =A0=3D htcherald_panel_disable,
> >> + =A0 =A0 =A0 .get_caps =A0 =A0 =A0 =3D htcherald_panel_get_caps,
> >> +};
> >> +
> >> +static int htcherald_panel_probe(struct platform_device *pdev)
> >> +{
> >> + =A0 =A0 =A0 u32 reg;
> >> + =A0 =A0 =A0 unsigned int tries =3D 200;
> >> +
> >> + =A0 =A0 =A0 /* disable controller if active */
> >> + =A0 =A0 =A0 reg =3D omap_readl(OMAP_LCDC_CONTROL);
> >> + =A0 =A0 =A0 if (reg & OMAP_LCDC_CTRL_LCD_EN) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_LCDC_CTRL_LCD_EN;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(reg, OMAP_LCDC_CONTROL);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait for end of frame */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(OMAP_LCDC_STATUS=
) & OMAP_LCDC_STAT_DONE) && --tries);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tries) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING =
"lcd_htcherald: Unable to confirm controller
> >> is disabled -- LCD might not work\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* turn off DMA */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_readw(OMAP_DMA_LCD_CCR)=
;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 7);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writew(reg, OMAP_DMA_LCD_CCR);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_readw(OMAP_DMA_LCD_CTRL=
);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 8);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writew(reg, OMAP_DMA_LCD_CTRL);
> >> + =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 omapfb_register_panel(&htcherald_panel_1);
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int htcherald_panel_remove(struct platform_device *pdev)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int htcherald_panel_suspend(struct platform_device *pdev,
> >> pm_message_t mesg)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int htcherald_panel_resume(struct platform_device *pdev)
> >> +{
> >> + =A0 =A0 =A0 return 0;
> >> +}
> >> +
> >> +struct platform_driver htcherald_panel_driver =3D {
> >> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D htcherald_panel_probe,
> >> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D htcherald_panel_remove,
> >> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D htcherald_panel_suspend,
> >> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D htcherald_panel_resume,
> >> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "lcd_htcherald",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> >> + =A0 =A0 =A0 },
> >> +};
> >> +
> >> +static int htcherald_panel_drv_init(void)
> >> +{
> >> + =A0 =A0 =A0 return platform_driver_register(&htcherald_panel_dri=
ver);
> >> +}
> >> +
> >> +static void htcherald_panel_drv_cleanup(void)
> >> +{
> >> + =A0 =A0 =A0 platform_driver_unregister(&htcherald_panel_driver);
> >> +}
> >> +
> >> +module_init(htcherald_panel_drv_init);
> >> +module_exit(htcherald_panel_drv_cleanup);
> >> +
> >> --
> >> 1.5.6.3
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
