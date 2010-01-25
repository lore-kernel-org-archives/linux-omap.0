From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] omap: define _toggle_gpio_edge_triggering only for OMAP1
Date: Mon, 25 Jan 2010 10:22:18 -0800
Message-ID: <87sk9u6o4l.fsf@deeprootsystems.com>
References: <1264280500-22878-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754128Ab0AYSXO@vger.kernel.org>
In-Reply-To: <1264280500-22878-2-git-send-email-u.kleine-koenig@pengutronix.de> ("Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig=22's?= message of "Sat\, 23 Jan 2010
 22\:01\:40 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:

> The only usage of _toggle_gpio_edge_triggering is in an
> CONFIG_ARCH_OMAP1 is defined, too.
>
> This fixes a compiler warning:
>
> 	arch/arm/plat-omap/gpio.c:758: warning: '_toggle_gpio_edge_triggerin=
g' defined but not used
>
> when compiling for ARCH_OMAP2, ARCH_OMAP3 or ARCH_OMAP4.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/plat-omap/gpio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index d17620c..d2422c7 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -750,6 +750,7 @@ static inline void set_24xx_gpio_triggering(struc=
t gpio_bank *bank, int gpio,
>  }
>  #endif
> =20
> +#ifdef CONFIG_ARCH_OMAP1
>  /*
>   * This only applies to chips that can't do both rising and falling =
edge
>   * detection at once.  For all other chips, this function is a noop.
> @@ -760,11 +761,9 @@ static void _toggle_gpio_edge_triggering(struct =
gpio_bank *bank, int gpio)
>  	u32 l =3D 0;
> =20
>  	switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP1
>  	case METHOD_MPUIO:
>  		reg +=3D OMAP_MPUIO_GPIO_INT_EDGE;
>  		break;
> -#endif
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	case METHOD_GPIO_1510:
>  		reg +=3D OMAP1510_GPIO_INT_CONTROL;
> @@ -787,6 +786,7 @@ static void _toggle_gpio_edge_triggering(struct g=
pio_bank *bank, int gpio)
> =20
>  	__raw_writel(l, reg);
>  }
> +#endif
> =20
>  static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, in=
t trigger)
>  {
> --=20
> 1.6.6
