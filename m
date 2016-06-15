From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Wed, 15 Jun 2016 09:24:04 +0200
Message-ID: <20160615072404.GB26768@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Hello Linus,

On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
> On Tue, Jun 14, 2016 at 12:03 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Traditionally the n-th gpio device probed by the omap gpio driver g=
ot
> > the gpio number range [n*32 .. n*32+31].
> > When order of the devices probed by the driver changes (which can h=
appen
> > already now when some devices have a pinctrl and so the first probe
> > attempt returns -ENODEV) the numbering changes.
> >
> > To ensure a deterministical numbering use of_alias_get_id to determ=
ine
> > the number base for a given device. If no respective alias exists f=
all
> > back to the traditional numbering.
>=20
> I'm not too happy about this approach.
>=20
> The patch doesn't mention what practical problems it is trying to
> solve.

the practical problem is that a (binary-only and hardware specific)
application uses GPIO47 via /sys/class/gpio and this number refers to
the wrong GPIO since I introduced gpio-hogs in the device tree together
with pinctrl stuff to make the gpio-hogs work.

I agree that this doesn't need to be a reason to care for it from a
mainline POV.

> The GPIO numbering scheme is a matter of Linux internals and
> not about hardware description IMO.

Not sure if I should agree here or not. It's very usual that the
"internal" gpio numbers match the hardware reference manual. I know thi=
s
from imx, at91, all pre-dt platforms, I'm sure there are more, and I be=
t
I'm not the only one relying on this for omap.

And this is very usual in the dt world, too:

$ git grep -El 'gpio. =3D \&gpio' arch/arm/boot/dts | wc -l
37

> The way forward is to use the character device and use gpiochip
> devices with offset indexes and look up GPIOs by name from the
> character devices. If nothing substantial happens I am merging the
> final pieces of the GPIO chardev ABI for v4.8 and that is doing all t=
hat
> sysfs was doing and then some. I just need to change a small thing
> before sending the final version for review.

Hmm, so /sys/class/gpio was obsoleted before the substitution was ready=
?
I'd say an overlapping of several kernel versions would be good as we
cannot expect that userspace changes as fast as the kernel.

Independent of the inclusion of my patch series in the mainline kernel
I'll have to use it on my custom kernel to keep the hardware do what it
should.

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
