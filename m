From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Sat, 2 Jan 2016 09:06:57 -0800
Message-ID: <20160102170657.GB12622@atomide.com>
References: <201601021545.35201@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601021545.35201@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:46]:
> --- a/drivers/media/rc/ir-rx51.c
> +++ b/drivers/media/rc/ir-rx51.c
> @@ -25,9 +25,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
> +#include <linux/clk.h>
> =20
> -#include <plat/dmtimer.h>
> -#include <plat/clock.h>
> +#include "../../../arch/arm/plat-omap/include/plat/dmtimer.h"

Well we don't want to export the dmtimer functions to drivers..But
we now have the PWM driver that can be already used for most of the
ir-rx51.c.

>  #include <media/lirc.h>
>  #include <media/lirc_dev.h>
> @@ -208,7 +208,7 @@ static int lirc_rx51_init_port(struct lirc_rx51 *=
lirc_rx51)
>  	}
> =20
>  	clk_fclk =3D omap_dm_timer_get_fclk(lirc_rx51->pwm_timer);
> -	lirc_rx51->fclk_khz =3D clk_fclk->rate / 1000;
> +	lirc_rx51->fclk_khz =3D clk_get_rate(clk_fclk) / 1000;
> =20
>  	return 0;
> =20
>=20
> So Tony, you are author of that commit (a62a6e98c3) which broke ir-rx=
51
> module for Nokia N900. Do you know how to fix this driver for upstrea=
m
> kernel? It would be great to have driver working and not to have it i=
n
> this dead state...

Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PWM suppor=
t
using dual-mode timers". Chances are we still need to set up the dmtime=
r
code to provide also irqchip functions. That way ir-rx51.c can just do
request_irq on the selected dmtimer for interrupts.

> Also platform data for this driver are only in legacy board code.
> Support in DTS is missing, so driver (after fixing above problem) can=
not
> be used on DT booted kernel.

Yeah those parts should be already doable with the PWM timer code AFAIK=
=2E

Regards,

Tony
