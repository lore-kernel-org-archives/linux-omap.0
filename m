From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Wed, 24 Oct 2012 19:01:48 +0200
Message-ID: <CACRpkdbjfp9BvQ3Py3e+Bf-H3=ONs+Mct8Zma4Y=ZWNxprOX9A@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
	<20121022155028.GA13791@core.coreip.homeip.net>
	<508660D4.9030507@ti.com>
	<20121023200249.GA2712@core.coreip.homeip.net>
	<CACRpkdYwA7O8AqB8YFCK-c3e6-7FcbhMOiPEUq-cKJni_PO-Ow@mail.gmail.com>
	<20121024161801.GB16350@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121024161801.GB16350@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 24, 2012 at 6:18 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 24, 2012 at 02:54:23PM +0200, Linus Walleij wrote:
>>
>> A third alternative as outlined is to use notifiers and some
>> resource core in drivers/base/*
>
> OK, so with drivers/base/, have you considered doing default pinctrl
> selection in bus's probe() methods? Yo would select the default
> configuration before starting probing the device and maybe select idle
> when probe fails or device is unbound? That would still keep the link
> between device object and pinctrl and there less busses than device
> drivers out there.

One of our major important busses is the AMBA (PrimeCell) bus.

As it happens, this bus actually already do limited resource handling
by requesting the silicon block clock for the device, which is necessary
to perform auto-probing on the bus level. (You won't be able to read
the auto-detect registers unless the silicon is clocked...)

When it comes to pin control is turns out in the AMBA drivers we
have that we need to do more complex stuff than just select a
default configuration. (I assure this is not just for fun, it is saving
considerable amounts of power).

So the examples I outlined just in the previous mail:
drivers/tty/serial/amba-pl011.c
drivers/spi/spi-pl022.c
drivers/i2c/busses/i2c-nomadik.c

Hm it turns out that Wolfram has not yet merged the i2c patch,
here it is:
http://marc.info/?l=linux-i2c&m=134986995731695&w=2

There are complex state switches involved. It can arguably be
centralized, but then it needs to go into drivers/base/[power]
or similar, not into a specific piece of bus code, because the
needs won't be any different for e.g. a platform device.

Yours,
Linus Walleij
