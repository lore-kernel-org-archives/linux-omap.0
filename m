From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Tue, 14 Jun 2016 14:01:52 +0200
Message-ID: <20160614120152.GW26768@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <575FE7F0.6090200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575FE7F0.6090200@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hello Grygorii,

On Tue, Jun 14, 2016 at 02:18:08PM +0300, Grygorii Strashko wrote:
> On 06/14/2016 01:03 PM, Uwe Kleine-K=F6nig wrote:
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index b98ede78c9d8..6814245a54aa 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_ba=
nk *bank, struct irq_chip *irqc)
> >   	static int gpio;
> >   	int irq_base =3D 0;
> >   	int ret;
> > +	int gpio_alias_id;
> >  =20
> >   	/*
> >   	 * REVISIT eventually switch from OMAP-specific gpio structs
> > @@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_b=
ank *bank, struct irq_chip *irqc)
> >   		bank->chip.label =3D "gpio";
> >   		bank->chip.base =3D gpio;
>=20
> I think, the gpio base correction should be done here

What is the upside of doing it here? It has the downside that it needs
one more indention level. The only difference I see is that it doesn't
apply for mpuio devices then and wonder if that is relevant.
=20
> >   	}
> > +
> > +	/*
> > +	 * Traditionally the base is given out in first-come-first-serve =
order.
> > +	 * This might shuffle the numbering of gpios if the probe order c=
hanges.
> > +	 * So make the base deterministical if the device tree specifies =
alias
> > +	 * ids.
> > +	 */
> > +	gpio_alias_id =3D of_alias_get_id(bank->chip.of_node, "gpio");
> > +	if (gpio_alias_id >=3D 0)
> > +		bank->chip.base =3D bank->width * gpio_alias_id;
> > +
>=20
> Unfortunately, this driver is still used by non-DT platforms, so abov=
e code will
>  break build if !OF && !OF_GPIO

Without CONFIG_OF of_alias_get_id still exists and returns -ENOSYS whic=
h
should make the added code a nop. Does your compiler agree with you tha=
t
my patch breaks building the driver?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
