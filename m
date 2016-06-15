From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
Date: Wed, 15 Jun 2016 01:27:06 -0700
Message-ID: <20160615082705.GW22406@atomide.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615072404.GB26768@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [160615 00:27]=
:
> On Wed, Jun 15, 2016 at 08:56:58AM +0200, Linus Walleij wrote:
> > The way forward is to use the character device and use gpiochip
> > devices with offset indexes and look up GPIOs by name from the
> > character devices. If nothing substantial happens I am merging the
> > final pieces of the GPIO chardev ABI for v4.8 and that is doing all=
 that
> > sysfs was doing and then some. I just need to change a small thing
> > before sending the final version for review.
>=20
> Hmm, so /sys/class/gpio was obsoleted before the substitution was rea=
dy?
> I'd say an overlapping of several kernel versions would be good as we
> cannot expect that userspace changes as fast as the kernel.

Well the /sys/class/gpio is an interface, and we'll have to maintain
it basically forever as we all know. It also works just fine for simple
things, so let's make sure it is usable. Having it inconsistent can
cause nasty side effects upgrading kernels.

Naturally I don't have any objections for adding a character device :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
