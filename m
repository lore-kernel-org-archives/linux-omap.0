From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap: define _toggle_gpio_edge_triggering only for
 OMAP1
Date: Mon, 25 Jan 2010 16:28:32 -0800
Message-ID: <20100126002832.GD2879@atomide.com>
References: <1264280500-22878-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <87sk9u6o4l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751823Ab0AZA2s@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sk9u6o4l.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100125 10:20]:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > The only usage of _toggle_gpio_edge_triggering is in an
> > CONFIG_ARCH_OMAP1 is defined, too.
> >
> > This fixes a compiler warning:
> >
> > 	arch/arm/plat-omap/gpio.c:758: warning: '_toggle_gpio_edge_trigger=
ing' defined but not used
> >
> > when compiling for ARCH_OMAP2, ARCH_OMAP3 or ARCH_OMAP4.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>=20
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Ack, I'll add this into omap-fixes for the -rc cycle.

Regards,

Tony
=20
> > ---
> >  arch/arm/plat-omap/gpio.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> > index d17620c..d2422c7 100644
> > --- a/arch/arm/plat-omap/gpio.c
> > +++ b/arch/arm/plat-omap/gpio.c
> > @@ -750,6 +750,7 @@ static inline void set_24xx_gpio_triggering(str=
uct gpio_bank *bank, int gpio,
> >  }
> >  #endif
> > =20
> > +#ifdef CONFIG_ARCH_OMAP1
> >  /*
> >   * This only applies to chips that can't do both rising and fallin=
g edge
> >   * detection at once.  For all other chips, this function is a noo=
p.
> > @@ -760,11 +761,9 @@ static void _toggle_gpio_edge_triggering(struc=
t gpio_bank *bank, int gpio)
> >  	u32 l =3D 0;
> > =20
> >  	switch (bank->method) {
> > -#ifdef CONFIG_ARCH_OMAP1
> >  	case METHOD_MPUIO:
> >  		reg +=3D OMAP_MPUIO_GPIO_INT_EDGE;
> >  		break;
> > -#endif
> >  #ifdef CONFIG_ARCH_OMAP15XX
> >  	case METHOD_GPIO_1510:
> >  		reg +=3D OMAP1510_GPIO_INT_CONTROL;
> > @@ -787,6 +786,7 @@ static void _toggle_gpio_edge_triggering(struct=
 gpio_bank *bank, int gpio)
> > =20
> >  	__raw_writel(l, reg);
> >  }
> > +#endif
> > =20
> >  static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, =
int trigger)
> >  {
> > --=20
> > 1.6.6
