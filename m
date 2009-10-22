From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix omap-keypad by restoring old keypad.h
	without breaking omap2 boards that use matrix_keypad
Date: Thu, 22 Oct 2009 11:49:59 -0700
Message-ID: <20091022184958.GS16230@atomide.com>
References: <200910211620.30538.jkrzyszt@tis.icnet.pl> <20091021155940.GJ16230@atomide.com> <200910212009.39066.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59331 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZJVSt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 14:49:58 -0400
Content-Disposition: inline
In-Reply-To: <200910212009.39066.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091021 11:10]:
> Wednesday 21 October 2009 17:59:40 Tony Lindgren napisa=C5=82(a):
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091021 07:21]:
> > > Hi,
> > > Commit 4f5433324d1e29cf234d5b1b14782c0fc2948298 had made machines=
 that
> > > use new matrix_keypad based drivers happy while breaking those th=
at still
> > > use old omap-keypad driver. The patch fixes omap-keypad device fo=
r my
> > > Amstrad Delta (tested) and probably 11 more OMAP1 based machines.=
 It
> > > leaves a potential similiar problem on OMAP2 H4 machine not addre=
ssed.
> > >
> > > I would say that those new, matrix_keypad based drivers should be
> > > corrected to simply not include arch/arm/plat-omap/include/mach/k=
eypad.h,
> > > which should keep serving omap-keypad based machines until they a=
re all
> > > upgraded to use matrix_keypad.
> >
> > Hmm, yeah let's try to do that instead.
> > ...
> >
> > Maybe we should add:
> >
> > #warning: Please update the board to use matrix_keypad.h instead
>=20
> Here you are.
>=20
> Created against linux-2.6.32-rc5.
> Compile tested with omap_3430sdp_defconfig and rx51_defconfig.

Thanks, adding this to omap-fixes.

Tony
=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>=20
> ---
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-3430sdp.c l=
inux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-3430sdp.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-3430sdp.c	2009-10=
-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-3430sdp.c	2009-1=
0-21 19:28:48.000000000 +0200
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl4030.h>
> @@ -38,7 +39,6 @@
>  #include <mach/gpmc.h>
> =20
>  #include <mach/control.h>
> -#include <mach/keypad.h>
>  #include <mach/gpmc-smc91x.h>
> =20
>  #include "sdram-qimonda-hyb18m512160af-6.h"
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-ldp.c linux=
-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-ldp.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-ldp.c	2009-10-16 =
02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-ldp.c	2009-10-21=
 19:30:03.000000000 +0200
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/workqueue.h>
>  #include <linux/err.h>
> @@ -41,7 +42,6 @@
>  #include <asm/delay.h>
>  #include <mach/control.h>
>  #include <mach/usb.h>
> -#include <mach/keypad.h>
> =20
>  #include "mmc-twl4030.h"
> =20
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-omap3evm.c =
linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-omap3evm.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-omap3evm.c	2009-1=
0-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-omap3evm.c	2009-=
10-21 19:30:16.000000000 +0200
> @@ -20,6 +20,7 @@
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/leds.h>
> =20
>  #include <linux/spi/spi.h>
> @@ -37,7 +38,6 @@
>  #include <mach/usb.h>
>  #include <mach/common.h>
>  #include <mach/mcspi.h>
> -#include <mach/keypad.h>
> =20
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mmc-twl4030.h"
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-omap3pandor=
a.c linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-omap3pandora.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-omap3pandora.c	20=
09-10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-omap3pandora.c	2=
009-10-21 19:28:03.000000000 +0200
> @@ -27,6 +27,7 @@
>  #include <linux/i2c/twl4030.h>
>  #include <linux/leds.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/gpio_keys.h>
> =20
>  #include <asm/mach-types.h>
> @@ -39,7 +40,6 @@
>  #include <mach/hardware.h>
>  #include <mach/mcspi.h>
>  #include <mach/usb.h>
> -#include <mach/keypad.h>
>  #include <mach/mux.h>
> =20
>  #include "sdram-micron-mt46h32m32lf-6.h"
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-rx51-periph=
erals.c linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-rx51-periphera=
ls.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-rx51-peripherals.=
c	2009-10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-rx51-peripherals=
=2Ec	2009-10-21 19:29:31.000000000 +0200
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/spi/spi.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl4030.h>
> @@ -27,7 +28,6 @@
>  #include <mach/common.h>
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
> -#include <mach/keypad.h>
>  #include <mach/onenand.h>
>  #include <mach/gpmc-smc91x.h>
> =20
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-rx51.c linu=
x-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-rx51.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-rx51.c	2009-10-16=
 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-rx51.c	2009-10-2=
1 19:25:33.000000000 +0200
> @@ -26,7 +26,6 @@
>  #include <mach/mux.h>
>  #include <mach/board.h>
>  #include <mach/common.h>
> -#include <mach/keypad.h>
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
>  #include <mach/usb.h>
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-zoom2.c lin=
ux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-zoom2.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap2/board-zoom2.c	2009-10-1=
6 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap2/board-zoom2.c	2009-10-=
21 19:29:52.000000000 +0200
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c/twl4030.h>
>  #include <linux/regulator/machine.h>
> @@ -22,7 +23,6 @@
> =20
>  #include <mach/common.h>
>  #include <mach/usb.h>
> -#include <mach/keypad.h>
> =20
>  #include "mmc-twl4030.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> diff -upr linux-2.6.32-rc5.orig/arch/arm/plat-omap/include/mach/keypa=
d.h linux-2.6.32-rc5.fixed/arch/arm/plat-omap/include/mach/keypad.h
> --- linux-2.6.32-rc5.orig/arch/arm/plat-omap/include/mach/keypad.h	20=
09-10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/plat-omap/include/mach/keypad.h	2=
009-10-21 19:41:35.000000000 +0200
> @@ -10,7 +10,7 @@
>  #ifndef ASMARM_ARCH_KEYPAD_H
>  #define ASMARM_ARCH_KEYPAD_H
> =20
> -#include <linux/input/matrix_keypad.h>
> +#warning: Please update the board to use matrix_keypad.h instead
> =20
>  struct omap_kp_platform_data {
>  	int rows;
> @@ -37,6 +37,9 @@ struct omap_kp_platform_data {
> =20
>  #define KEY_PERSISTENT		0x00800000
>  #define KEYNUM_MASK		0x00EFFFFF
> +#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
> +#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
> +						KEY_PERSISTENT)
> =20
>  #endif
> =20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
