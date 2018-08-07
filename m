From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
Date: Tue, 07 Aug 2018 19:29:53 +0200
Message-ID: <11711552.OvaP4pOjBH@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-13-jmkrzyszt@gmail.com> <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Jonathan Corbet <corbet@lwn.net>, =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, August 7, 2018 1:43:56 AM CEST Linus Walleij wrote:
> On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
> 
> Hi Janusz!
> 
> > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > information on a single GPIO chip driving array member pins in hardware
> > order.  In such cases, bitmaps of values can be passed directly to the
> > chip callback functions without wasting time on iterations.
> >
> > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> I think it would be disappointing to leave all the users of the old
> array API without the performance improvement. I think we need to
> deal with this in a way such that everyone can benefit from it.

There are a few issues to be resolved:

1) array size limited by bitmap size:
    - are we ready to limit array size to a single bitmap for all users?
    - if not, how can we pass a bitmap of an arbitrary size?
    - if as an array of bitmaps, is that still clear enough and easy to use?
    - other ideas?

2) arbitrary array support:
     - are we ready to drop that?
     - if not, do we agree to require all users to pack their arbitrary arrays 
        inside the gpio_descs structure?

Maybe more.

> Also it is kludgy if users (consumers) would need to handle the case
> where all lines are on the same chip separately, through the bitmap
> API.

Not true as long as array size fits (arbitrary arrays can be packed by users), 
but I see your point.

> What we need is an API that:
> 
> - All drivers handling arrays can use (including current users).
> 
> - Enables speed-up if the lines are all on the same chip/register.
> 
> - Doesn't require consumers to know if they are all on the same
>   chip or not.
> 
> This means a deep API with a small surface.
> 
> How do we achieve this the best way?

I think widely accepted solutions to those two issues I've mentioned above can 
give the answer.

Thanks,
Janusz
