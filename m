From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to
 bitmap API functions
Date: Tue, 7 Aug 2018 19:47:22 +0200
Message-ID: <20180807194722.5aabb6da@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-13-jmkrzyszt@gmail.com>
        <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
        <11711552.OvaP4pOjBH@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11711552.OvaP4pOjBH@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Tue, 07 Aug 2018 19:29:53 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Tuesday, August 7, 2018 1:43:56 AM CEST Linus Walleij wrote:
> > On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com>   
> wrote:
> > 
> > Hi Janusz!
> >   
> > > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > > information on a single GPIO chip driving array member pins in hardware
> > > order.  In such cases, bitmaps of values can be passed directly to the
> > > chip callback functions without wasting time on iterations.
> > >
> > > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > >
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>  
> > 
> > I think it would be disappointing to leave all the users of the old
> > array API without the performance improvement. I think we need to
> > deal with this in a way such that everyone can benefit from it.  

I agree with Linus on that one. When I initially proposed the gpio
bitbanging API I had something more advanced in mind where the GPIO
framework would be responsible for toggling the GPIOs on its own when
it's given an array of bytes to transmit (this way you avoid going
back and forth between the GPIO user and the GPIO framework). But this
approach would clearly be more invasive than what you propose
here (turning the int array into a bitmap and optimizing). So, if we go
for the "int array -> bitmap" approach I think all users should be
converted so that we end up with a single API.

> 
> There are a few issues to be resolved:
> 
> 1) array size limited by bitmap size:
>     - are we ready to limit array size to a single bitmap for all users?
>     - if not, how can we pass a bitmap of an arbitrary size?
>     - if as an array of bitmaps, is that still clear enough and easy to use?
>     - other ideas?

What we call a bitmap is an array of unsigned longs each entry
containing NBITS_PER_LONG bits, so yes, it's an arbitrary size (see the
bitmap API here [1]).

> 
> 2) arbitrary array support:
>      - are we ready to drop that?
>      - if not, do we agree to require all users to pack their arbitrary arrays 
>         inside the gpio_descs structure?

I could only find one user, and it's the core itself (for the ioctl),
so that shouldn't be too hard to convert all users. Did you find more.

> 
> Maybe more.
> 
> > Also it is kludgy if users (consumers) would need to handle the case
> > where all lines are on the same chip separately, through the bitmap
> > API.  
> 
> Not true as long as array size fits (arbitrary arrays can be packed by users), 
> but I see your point.

I think the API should be the same and the framework should decide to
take the fast path if all gpios belong to the same chip (which AFAICT
is already the case, except it's putting the result in an int array
instead of a bitmap)

> 
> > What we need is an API that:
> > 
> > - All drivers handling arrays can use (including current users).
> > 
> > - Enables speed-up if the lines are all on the same chip/register.
> > 
> > - Doesn't require consumers to know if they are all on the same
> >   chip or not.
> > 
> > This means a deep API with a small surface.
> > 
> > How do we achieve this the best way?  
> 
> I think widely accepted solutions to those two issues I've mentioned above can 
> give the answer.

I'd still like to see how far we are from the initial perfs (the one
poking the GPIO regs directly) with this approach, and what's the
improvement compared to the int array solution we already have in place.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.18-rc8/source/include/linux/bitmap.h
