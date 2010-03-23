From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/5] OMAP: RX51: Add LCD Panel support
Date: Tue, 23 Mar 2010 11:12:15 +0100
Message-ID: <74d0deb31003230312x1b1160b5v75f182fd3db8ac25@mail.gmail.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
	 <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58641 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab0CWKMR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 06:12:17 -0400
In-Reply-To: <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: tony@atomide.com, Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Mar 23, 2010 at 10:56 AM, Roger Quadros <roger.quadros@nokia.co=
m> wrote:
> From: Roger Quadros <roger.quadros@nokia.com>
>
> Adds basic support for LCD Panel on Nokia N900
>
> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
> =A0arch/arm/mach-omap2/board-rx51-peripherals.c | =A0 13 ++++
> =A0arch/arm/mach-omap2/board-rx51-video.c =A0 =A0 =A0 | =A0 95 ++++++=
++++++++++++++++++++
> =A03 files changed, 109 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 4b9fc57..b03cbb4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -122,6 +122,7 @@ obj-$(CONFIG_MACH_NOKIA_N8X0) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 +=3D board-n8x0.o
> =A0obj-$(CONFIG_MACH_NOKIA_RX51) =A0 =A0 =A0 =A0 =A0+=3D board-rx51.o=
 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 board-rx51-sdram.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 board-rx51-peripherals.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0board-rx51-video.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP_ZOOM2) =A0 =A0 =A0 =A0 =A0+=3D board-zoom2.=
o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 board-zoom-peripherals.o \
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/=
mach-omap2/board-rx51-peripherals.c
> index 4377a4c..f404537 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -45,6 +45,7 @@
> =A0/* list all spi devices here */
> =A0enum {
> =A0 =A0 =A0 =A0RX51_SPI_WL1251,
> + =A0 =A0 =A0 RX51_SPI_MIPID, =A0 =A0 =A0 =A0 /* LCD panel */
> =A0};
>
> =A0static struct wl12xx_platform_data wl1251_pdata;
> @@ -54,6 +55,11 @@ static struct omap2_mcspi_device_config wl1251_mcs=
pi_config =3D {
> =A0 =A0 =A0 =A0.single_channel =3D 1,
> =A0};
>
> +static struct omap2_mcspi_device_config mipid_mcspi_config =3D {
> + =A0 =A0 =A0 .turbo_mode =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .single_channel =3D 1,
> +};
> +
> =A0static struct spi_board_info rx51_peripherals_spi_board_info[] __i=
nitdata =3D {
> =A0 =A0 =A0 =A0[RX51_SPI_WL1251] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "wl1251",
> @@ -64,6 +70,13 @@ static struct spi_board_info rx51_peripherals_spi_=
board_info[] __initdata =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.controller_data =A0 =A0 =A0 =A0=3D &w=
l1251_mcspi_config,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0 =A0 =A0 =A0 =A0=3D =
&wl1251_pdata,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 [RX51_SPI_MIPID] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .modalias =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 "acx565akm",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_num =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chip_select =A0 =A0 =A0 =A0 =A0 =A0=3D=
 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_speed_hz =A0 =A0 =A0 =A0 =A0 =3D 6=
000000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .controller_data =A0 =A0 =A0 =A0=3D &mi=
pid_mcspi_config,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_=
MODULE)
> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-o=
map2/board-rx51-video.c
> new file mode 100644
> index 0000000..e3e22a8
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-rx51-video.c
> @@ -0,0 +1,95 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-rx51-peripherals.c

board-rx51-video.c

> + *
> + * Copyright (C) 2010 Nokia
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/mach-types.h>
> +#include <plat/mux.h>
> +#include <plat/display.h>
> +#include <plat/mcspi.h>
> +
> +#include "mux.h"
> +
> +#define RX51_LCD_RESET_GPIO =A0 =A090
> +
> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
> +
> +static int rx51_lcd_enable(struct omap_dss_device *dssdev)
> +{
> + =A0 =A0 =A0 gpio_set_value(dssdev->reset_gpio, 1);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void rx51_lcd_disable(struct omap_dss_device *dssdev)
> +{
> + =A0 =A0 =A0 gpio_set_value(dssdev->reset_gpio, 0);
> +}
> +
> +static struct omap_dss_device rx51_lcd_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "lcd",
> + =A0 =A0 =A0 .driver_name =A0 =A0 =A0 =A0 =A0 =A0=3D "panel-acx565ak=
m",
> + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP_DISP=
LAY_TYPE_SDI,
> + =A0 =A0 =A0 .phy.sdi.datapairs =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 .reset_gpio =A0 =A0 =A0 =A0 =A0 =A0 =3D RX51_LCD_RESET_=
GPIO,
> + =A0 =A0 =A0 .platform_enable =A0 =A0 =A0 =A0=3D rx51_lcd_enable,
> + =A0 =A0 =A0 .platform_disable =A0 =A0 =A0 =3D rx51_lcd_disable,
> +};
> +
> +static struct omap_dss_device *rx51_dss_devices[] =3D {
> + =A0 =A0 =A0 &rx51_lcd_device,
> +};
> +
> +static struct omap_dss_board_info rx51_dss_board_info =3D {
> + =A0 =A0 =A0 .num_devices =A0 =A0=3D ARRAY_SIZE(rx51_dss_devices),
> + =A0 =A0 =A0 .devices =A0 =A0 =A0 =A0=3D rx51_dss_devices,
> + =A0 =A0 =A0 .default_device =3D &rx51_lcd_device,
> +};
> +
> +struct platform_device rx51_display_device =3D {
> + =A0 =A0 =A0 .name =A0 =3D "omapdss",
> + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &rx51_dss_board_info=
,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct platform_device *rx51_video_devices[] __initdata =3D {
> + =A0 =A0 =A0 &rx51_display_device,
> +};
> +
> +static int __init rx51_video_init(void)
> +{
> + =A0 =A0 =A0 if (!machine_is_nokia_rx51())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OU=
TPUT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s cannot configure MUX for LCD=
 RESET\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (gpio_request(RX51_LCD_RESET_GPIO, "LCD ACX565AKM re=
set")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s failed to get LCD Reset GPIO=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
> +
> + =A0 =A0 =A0 platform_add_devices(rx51_video_devices,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_S=
IZE(rx51_video_devices));
> + =A0 =A0 =A0 return 0;
> +}
> +
> +subsys_initcall(rx51_video_init);
> +
> +#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE=
) */
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
