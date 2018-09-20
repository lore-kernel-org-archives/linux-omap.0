From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Thu, 20 Sep 2018 08:33:07 -0700
Message-ID: <CACRpkdYcVmL=3VxfcW9O5TAGKMaEvt2sPFdHgd8w3-8XUdY6ww@mail.gmail.com>
References: <20180909225605.16463-3-jmkrzyszt@gmail.com> <20180919221729.21179-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919221729.21179-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 19, 2018 at 3:17 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
>
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents.
>
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Changelog:
> v5:
> - rebased on nand/next
> - resubmitted to linux-mtd as a stand-alone patch

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
