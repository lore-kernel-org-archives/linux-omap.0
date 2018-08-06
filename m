From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap
 API functions
Date: Tue, 7 Aug 2018 01:43:56 +0200
Message-ID: <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-13-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-13-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

Hi Janusz!

> Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> information on a single GPIO chip driving array member pins in hardware
> order.  In such cases, bitmaps of values can be passed directly to the
> chip callback functions without wasting time on iterations.
>
> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

I think it would be disappointing to leave all the users of the old
array API without the performance improvement. I think we need to
deal with this in a way such that everyone can benefit from it.

Also it is kludgy if users (consumers) would need to handle the case
where all lines are on the same chip separately, through the bitmap
API.

What we need is an API that:

- All drivers handling arrays can use (including current users).

- Enables speed-up if the lines are all on the same chip/register.

- Doesn't require consumers to know if they are all on the same
  chip or not.

This means a deep API with a small surface.

How do we achieve this the best way?

Yours,
Linus Walleij
