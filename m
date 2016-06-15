From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Wed, 15 Jun 2016 08:56:58 +0200
Message-ID: <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 14, 2016 at 12:03 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can hap=
pen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
>
> To ensure a deterministical numbering use of_alias_get_id to determin=
e
> the number base for a given device. If no respective alias exists fal=
l
> back to the traditional numbering.

I'm not too happy about this approach.

The patch doesn't mention what practical problems it is trying to
solve.

I am very much suspecting the sysfs ABI to be what you're trying to
get consistent, and that is OBSOLETED, see
fe95046e960b4b76e73dc1486955d93f47276134
"gpio: ABI: mark the sysfs ABI as obsolete"

The GPIO numbering scheme is a matter of Linux internals and
not about hardware description IMO.

The way forward is to use the character device and use gpiochip
devices with offset indexes and look up GPIOs by name from the
character devices. If nothing substantial happens I am merging the
final pieces of the GPIO chardev ABI for v4.8 and that is doing all tha=
t
sysfs was doing and then some. I just need to change a small thing
before sending the final version for review.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
