From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/3] video: fbdev: omapfb: lcd_ams_delta: use GPIO
 lookup table
Date: Mon, 10 Sep 2018 09:15:13 +0200
Message-ID: <CACRpkdaunjy-k+ssCxVQTHjzCqGdzn3JRHyon8uU9Q8a3d9BXg@mail.gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com> <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180909225605.16463-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 10, 2018 at 12:55 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
>
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
>
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Good work as usual:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

FWIW I think the entire drivers/video/fbdev/omap/*
could be pretty easy to migrate to DRM if you compare
the simple drivers/gpu/drm/pl111 or drivers/gpu/drm/tve200
drivers. Just inspiration! :)

Yours,
Linus Walleij
