From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod
 migration
Date: Thu, 20 Sep 2018 13:58:05 -0700
Message-ID: <20180920205805.GQ5662@atomide.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <1794253.R1RrZXVNCJ@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1794253.R1RrZXVNCJ@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180919 18:13]:
> On Monday, September 10, 2018 12:56:02 AM CEST Janusz Krzysztofik wrote:
> > 
> > This is a follow up of initial submission of a series consisted of 
> > 6 changes, 3 of which have been already applied or reworkeed.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> >       mtd: rawnand: ams-delta: use GPIO lookup table
> 
> Hi Tony,
> 
> Please ignore this patch. It may no longer be possible to merged it cleanly 
> with nand/next tree. I'll exclude it from the series, rebase on top of nand/
> next and submit via linux-mtd.

OK sounds good to me.

> That shouldn't affect the two remaining patches of the series which should 
> still apply and merge cleanly, but I can resend them renumbered if you wish.

Up to the mtd and fb folks as far as I'm concerned :)

Regards,

Tony
