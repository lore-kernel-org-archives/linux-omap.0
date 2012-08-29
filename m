From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/9] ARM: OMAP1: move omap1_bl pdata out of arch/arm/*
Date: Wed, 29 Aug 2012 18:04:24 +0300
Message-ID: <1346252664.12380.0.camel@deskari>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
	 <1346195937-6383-7-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sWOIskJ53CoVrGQgsj41"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:36371 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042Ab2H2PEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 11:04:30 -0400
Received: by bkwj10 with SMTP id j10so340093bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 08:04:27 -0700 (PDT)
In-Reply-To: <1346195937-6383-7-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org


--=-sWOIskJ53CoVrGQgsj41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-29 at 02:18 +0300, Igor Grinberg wrote:
> omap1 backlight platform data resides inside plat/board.h while it
> should be inside include/linux/...
> Move the omap1 backlight platform data to
> include/linux/platform_data/.
>=20
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap1/board-osk.c         |    1 +
>  arch/arm/mach-omap1/board-palmte.c      |    1 +
>  arch/arm/mach-omap1/board-palmtt.c      |    1 +
>  arch/arm/mach-omap1/board-palmz71.c     |    1 +
>  arch/arm/plat-omap/include/plat/board.h |    7 -------
>  drivers/video/backlight/omap1_bl.c      |    2 +-
>  include/linux/platform_data/omap1_bl.h  |   11 +++++++++++
>  7 files changed, 16 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/platform_data/omap1_bl.h
>=20
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-=
osk.c
> index 8784705..569b687 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -39,6 +39,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/i2c/tps65010.h>
> +#include <linux/platform_data/omap1_bl.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/boa=
rd-palmte.c
> index 26bcb9d..7bf00ba 100644
> --- a/arch/arm/mach-omap1/board-palmte.c
> +++ b/arch/arm/mach-omap1/board-palmte.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/apm-emulation.h>
>  #include <linux/omapfb.h>
> +#include <linux/platform_data/omap1_bl.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/boa=
rd-palmtt.c
> index 4d09944..2cce505 100644
> --- a/arch/arm/mach-omap1/board-palmtt.c
> +++ b/arch/arm/mach-omap1/board-palmtt.c
> @@ -27,6 +27,7 @@
>  #include <linux/omapfb.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/platform_data/omap1_bl.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/bo=
ard-palmz71.c
> index 3559803..45ab9f0 100644
> --- a/arch/arm/mach-omap1/board-palmz71.c
> +++ b/arch/arm/mach-omap1/board-palmz71.c
> @@ -30,6 +30,7 @@
>  #include <linux/omapfb.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/platform_data/omap1_bl.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap=
/include/plat/board.h
> index 5938c72..d0bc46e 100644
> --- a/arch/arm/plat-omap/include/plat/board.h
> +++ b/arch/arm/plat-omap/include/plat/board.h
> @@ -19,13 +19,6 @@ struct omap_lcd_config {
>  	u8   data_lines;
>  };
> =20
> -struct device;
> -struct fb_info;
> -struct omap_backlight_config {
> -	int default_intensity;
> -	int (*set_power)(struct device *dev, int state);
> -};
> -
>  /* for TI reference platforms sharing the same debug card */
>  extern int debug_card_init(u32 addr, unsigned gpio);
> =20
> diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight=
/omap1_bl.c
> index bfdc5fb..92257ef 100644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -27,9 +27,9 @@
>  #include <linux/fb.h>
>  #include <linux/backlight.h>
>  #include <linux/slab.h>
> +#include <linux/platform_data/omap1_bl.h>
> =20
>  #include <mach/hardware.h>
> -#include <plat/board.h>
>  #include <plat/mux.h>
> =20
>  #define OMAPBL_MAX_INTENSITY		0xff
> diff --git a/include/linux/platform_data/omap1_bl.h b/include/linux/platf=
orm_data/omap1_bl.h
> new file mode 100644
> index 0000000..881a8e9
> --- /dev/null
> +++ b/include/linux/platform_data/omap1_bl.h
> @@ -0,0 +1,11 @@
> +#ifndef __OMAP1_BL_H__
> +#define __OMAP1_BL_H__
> +
> +#include <linux/device.h>

You could use struct device; here.

> +
> +struct omap_backlight_config {
> +	int default_intensity;
> +	int (*set_power)(struct device *dev, int state);
> +};
> +
> +#endif

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--=-sWOIskJ53CoVrGQgsj41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQPi94AAoJEPo9qoy8lh71y3IQAJdFXxsihv+BJgx4uvYsv3f2
Eu0t3/n+E3K66tjnLljxxSXeotDx0JNanH0UEYVv41lhK3WU+xMcnsU5RJfQKPc3
RN+yfOU/oyfxmT0XxdIoACciIDjVIg1jvqJ0imEwfc1/3SAJIxkEYn+nj+8YKWwY
6E+86eCKFTEWqDH6eut0WgL/P2NAgaYWfVsqOO0EH6gbKdSUJjxFYCgLpJY9YEGH
I4iZ0zjqjVTdSZZgTl34kepRwjuNr7QMYwFWInWFlSy1Eu3ciZn5cwPs+WhM00Ru
nt9bBe0/HvDfuYHGslvyTXj1xD9rYlG0lhfQ4srAcHSK3MaQ37koNaI6e71F5Vu4
WVVxvYjLEekhwUsrnhxp8J2Tw/OgvUIh9klZqpGylGYWJtiiO7ckQrut+KSu5dKN
16bD4AcC7mLYXuXp9BnQOsXNAbVm09QUy0+VYtnADL9uqWQn5Fw91R0UZF+qseyU
Jo3zNZNW2y9UbKFGnFu92dnTtdCDnqM14I3c7BWN0PTbiSgBVj6kaiOH3S72VI6r
H1k09/7XQGr5WXTi7bdxKR0Xmdzy5Ou4N2OFlZ8hNoE7k8Ubj+Dli1yVwk9A+4il
2uW70ZFI5pXsG0OcYSe7a6nVpG6RarLlIjf3eHNOlcBlmlfFKoFCJ33TXJ+GISFi
GRyZuGKTBL0zwceWaNY6
=HIRY
-----END PGP SIGNATURE-----

--=-sWOIskJ53CoVrGQgsj41--

