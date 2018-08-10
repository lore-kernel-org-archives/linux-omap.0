From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap
 API functions
Date: Fri, 10 Aug 2018 12:55:22 +0200
Message-ID: <CACRpkdbxSd+3jzFrs0+Ty-F4xHaDbPQOAR3TjRc0QChK=VsKxw@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-13-jmkrzyszt@gmail.com>
 <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
 <11711552.OvaP4pOjBH@z50> <20180807194722.5aabb6da@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807194722.5aabb6da@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 7, 2018 at 7:47 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>
> > On Tuesday, August 7, 2018 1:43:56 AM CEST Linus Walleij wrote:
> > > On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > wrote:
> > >
> > > Hi Janusz!
> > >
> > > > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > > > information on a single GPIO chip driving array member pins in hardware
> > > > order.  In such cases, bitmaps of values can be passed directly to the
> > > > chip callback functions without wasting time on iterations.
> > > >
> > > > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > > >
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > >
> > > I think it would be disappointing to leave all the users of the old
> > > array API without the performance improvement. I think we need to
> > > deal with this in a way such that everyone can benefit from it.
>
> I agree with Linus on that one. When I initially proposed the gpio
> bitbanging API I had something more advanced in mind where the GPIO
> framework would be responsible for toggling the GPIOs on its own when
> it's given an array of bytes to transmit (this way you avoid going
> back and forth between the GPIO user and the GPIO framework). But this
> approach would clearly be more invasive than what you propose
> here (turning the int array into a bitmap and optimizing). So, if we go
> for the "int array -> bitmap" approach I think all users should be
> converted so that we end up with a single API.

I thought about this the recent days and something must have gone
wrong in the development process of the array API because this
was the (mine atleast) intention all the time.

If we look at the GPIOchip driver API it looks like this:

        int                     (*get_multiple)(struct gpio_chip *chip,
                                                unsigned long *mask,
                                                unsigned long *bits);
        void                    (*set_multiple)(struct gpio_chip *chip,
                                                unsigned long *mask,
                                                unsigned long *bits);

So there is nothing hindering the drivers from optimizing a call
here into a single register write, which is what e.g. the gpio-mmio.c
driver does: if the hardware has a dedicated register for clearing
and setting lines, it will simply just write the register with
whatever is passed in, also cache the current value so it doesn't
need to read back the register every time.

When an array comes down to gpiod_set_array_value_complex()
it loops over the descriptors in order to handle e.g. open drain
settings separately. Then the remainder (lines that should just
be set 1/0) is pushed to the .set_multiple() callback if they
are on the same chip.

This is assuming:

1. The CPU is not the bottleneck so we can do a bit
  of complex looping over structs etc in each write.

2. We want to perform as much in a single register write
  as possible to avoid I/O and glitches as all lines (e.g.
  clock and data) get written at the same time, if possible.
  (No skew.)

It seems Janusz has problems with assumption (1) and therefore
is trying to optimize the read/write path. This can be done if all
descs are on the same chip and none of them is using open drain
or open source.

To keep track of "quick path" the array needs to have a state.
So a magic "cookie" or something like that needs to be passed
to the array API.

I would suggest that struct gpiod_descs contain a magic cookie
returned from [devm_]gpiod_get_array[_optional]()  that can be
passed along to get/set array operations or left as NULL to just
fall back to the default:

void gpiod_set_array_value(unsigned int array_size,
                           struct gpio_desc **desc_array, int *value_array,
                           struct gpiod_array_cookie *cookie);

Cookie is just a dummy name, I don't know what makes most
sense. It reflects a state for the entire array.

If this cookie exist in some struct gpio_chip state variable, it
informs gpiolib that this array:

- Has all descriptors in the same gpiochip
- Has no open drain or open source-flagged lines

It can thenbypass the complex check and just write the values
directly by calling down into .set_multiple().

Maybe this cookie could just be a bool that is true when the above
is fulfilled. But it's best if that is hidden from the consumers
I guess, they shouldn't try to half-guess if the criteria is true,
gpiolib should do that.

The current users would have to be augmented to store the
cookie and pass it along when getting/setting arrays, but it would
be pretty simple and straight-forward compared to adding a new
API.

Yours,
Linus Walleij
