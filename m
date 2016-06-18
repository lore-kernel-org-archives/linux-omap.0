From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Sat, 18 Jun 2016 10:25:45 +0200
Message-ID: <CACRpkdYK1C5px+A_O1sF99KTPTob9qTQpipEaRLHnNx5=AokLg@mail.gmail.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com> <20160615072404.GB26768@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160615072404.GB26768@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 15, 2016 at 9:24 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:

>> The GPIO numbering scheme is a matter of Linux internals and
>> not about hardware description IMO.
>
> Not sure if I should agree here or not. It's very usual that the
> "internal" gpio numbers match the hardware reference manual. I know t=
his
> from imx, at91, all pre-dt platforms, I'm sure there are more, and I =
bet
> I'm not the only one relying on this for omap.

I think it will still match nicely against the chip-local offsets of th=
e
primary gpiochip so it'll be fine with a chardev too. The same was/is
the case of the first interrupts on x86 I think, but with the plethora =
of
irqchips and dependency on probe order etc the assumption is
nowadays to dangerous.

>
> And this is very usual in the dt world, too:
>
> $ git grep -El 'gpio. =3D \&gpio' arch/arm/boot/dts | wc -l
> 37

Aha I didn't even know. Well I guess I could allow it for OMAP too
then, but I want an ACK from one of the DT binding maintainers.

>> The way forward is to use the character device and use gpiochip
>> devices with offset indexes and look up GPIOs by name from the
>> character devices. If nothing substantial happens I am merging the
>> final pieces of the GPIO chardev ABI for v4.8 and that is doing all =
that
>> sysfs was doing and then some. I just need to change a small thing
>> before sending the final version for review.
>
> Hmm, so /sys/class/gpio was obsoleted before the substitution was rea=
dy?

Yeah, the sysfs was so broken that it could not be maintained.

> I'd say an overlapping of several kernel versions would be good as we
> cannot expect that userspace changes as fast as the kernel.

This is why it is scheduled for removal in 2020 and not tomorrow.

> Independent of the inclusion of my patch series in the mainline kerne=
l
> I'll have to use it on my custom kernel to keep the hardware do what =
it
> should.

Nah well, let's discuss it.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
