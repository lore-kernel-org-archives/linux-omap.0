From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 1/2] ads7846: fix gpio free without requesting
Date: Thu, 3 Feb 2011 10:55:22 +0530
Message-ID: <AANLkTimQaQNTNaLWMxCqJ2Y+peU1+tt8u3CitDZA6gba@mail.gmail.com>
References: <1296660624-28120-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41709 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713Ab1BCF0E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 00:26:04 -0500
In-Reply-To: <1296660624-28120-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>

Sourav,

On Wed, Feb 2, 2011 at 21:00, Sourav Poddar <sourav.poddar@ti.com> wrot=
e:
> gpio_pendown in ads7846_probe is not getting initalized (defaulted to=
 0)
> resulting in gpio_free being called without a gpio_request. This
> results in the following backtrace in bootup (at least on an OMAP3430=
 SDP).

NACK to this patch. see my comments below.

>
> ------------[ cut here ]------------
> WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
> Modules linked in:
> [<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>](warn_slowp=
ath_common+0x4c/0x64)
> [<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>](warn_=
slowpath_null+0x18/0x1c)
> [<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>](gpio_fr=
ee+0x100/0x12c)
> [<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>](ads7846_probe+=
0xa38/0xc5c)
> [<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>](spi_drv_pr=
obe+0x18/0x1c)
> [<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>](driver_probe=
_device+0xc8/0x184)
> [<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>](__dri=
ver_attach+0x68/0x8c)
> [<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>](bus_for_ea=
ch_dev+0x48/0x74)
> [<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>](bus_add_d=
river+0xa0/0x220)
> [<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>](driver_reg=
ister+0xa8/0x134)
> [<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>](do_one_in=
itcall+0xcc/0x1a4)
> [<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>](kernel_in=
it+0x14c/0x214)
> [<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>](kernel_threa=
d_exit+0x0/0x8)
> ---[ end trace 4053287f8a5ec18f ]---
>
> Initializing gpio_pendown in ads7846_probe to -1 before
> ads7846_setup_pendown function removes the above backtrace
> warning.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> =A0drivers/input/touchscreen/ads7846.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
> index 14ea54b..036f245 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1221,6 +1221,7 @@ static int __devinit ads7846_probe(struct spi_d=
evice *spi)
> =A0 =A0 =A0 =A0ts->input =3D input_dev;
> =A0 =A0 =A0 =A0ts->vref_mv =3D pdata->vref_mv;
> =A0 =A0 =A0 =A0ts->swap_xy =3D pdata->swap_xy;
> + =A0 =A0 =A0 ts->gpio_pendown =3D -1;

Going through the code, I see that ts->gpio_pendown is being filled
in ads7846_setup_pendown() which in turn is called by the
ads7846_probe().

Actually in ads7846_dev_init() [board-3430sdp.c], the gpio_pendown
pin has been requested already. The problem is with the following
line in ads7846_probe():
         if (pdata->get_pendown_state) {
                 ts->get_pendown_state =3D pdata->get_pendown_state;
                 return 0;
         }

Instead it should have been
         if (pdata->get_pendown_state( )) {
                 ts->get_pendown_state =3D pdata->get_pendown_state;
                 return 0;
         }

Also, filling ts->gpio_pendown =3D -1 should not be done in the driver =
file.
Instead pdata should either send a valid GPIO pin number or an -1
if it is not applicable to the board and this has to be done in the boa=
rd file.

Also in board-3430sdp.c file, I observed that pdata->gpio_pendown
is not filled at all. But the ads7846_setup_pendown() in the driver rel=
ies
on pdata->gpio_pendown. This also needs to be fixed.

-V Charulatha
>
> =A0 =A0 =A0 =A0mutex_init(&ts->lock);
> =A0 =A0 =A0 =A0init_waitqueue_head(&ts->wait);
> --
> 1.7.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
