From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Sun, 19 Jun 2016 03:08:23 +0200
Message-ID: <20160619010823.GC26875@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de>
 <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Linus,

On Sat, Jun 18, 2016 at 10:25:45AM +0200, Linus Walleij wrote:
> On Wed, Jun 15, 2016 at 9:24 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
>=20
> >> The GPIO numbering scheme is a matter of Linux internals and
> >> not about hardware description IMO.
> >
> > Not sure if I should agree here or not. It's very usual that the
> > "internal" gpio numbers match the hardware reference manual. I know=
 this
> > from imx, at91, all pre-dt platforms, I'm sure there are more, and =
I bet
> > I'm not the only one relying on this for omap.
>=20
> I think it will still match nicely against the chip-local offsets of =
the
> primary gpiochip so it'll be fine with a chardev too. The same was/is

I cannot follow. What is the primary gpiochip? The first one? What is a
"chip-local offset". Just 3 for the fourth gpio of a given gpio bank?
I guess the problem is that I didn't follow development of the gpio
chardev.

> the case of the first interrupts on x86 I think, but with the plethor=
a of
> irqchips and dependency on probe order etc the assumption is
> nowadays to dangerous.
>=20
> >
> > And this is very usual in the dt world, too:
> >
> > $ git grep -El 'gpio. =3D \&gpio' arch/arm/boot/dts | wc -l
> > 37
>=20
> Aha I didn't even know. Well I guess I could allow it for OMAP too
> then, but I want an ACK from one of the DT binding maintainers.

I added Rob, Frank, Mark and the device tree list to the recipients of
this mail. Can you please comment? There is already a v2 that you can
find at http://thread.gmane.org/gmane.linux.kernel.gpio/17399/ in case
it didn't hit your mailbox. If you tell me that you want it, I can also
bounce you the series.

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
