From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
Date: Wed, 19 Sep 2018 20:10:54 +0200
Message-ID: <1794253.R1RrZXVNCJ@z50>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com> <20180909225605.16463-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Monday, September 10, 2018 12:56:02 AM CEST Janusz Krzysztofik wrote:
> 
> This is a follow up of initial submission of a series consisted of 
> 6 changes, 3 of which have been already applied or reworkeed.
> 
> 
> Janusz Krzysztofik (3):
>       video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
>       mtd: rawnand: ams-delta: use GPIO lookup table

Hi Tony,

Please ignore this patch. It may no longer be possible to merged it cleanly 
with nand/next tree. I'll exclude it from the series, rebase on top of nand/
next and submit via linux-mtd.

That shouldn't affect the two remaining patches of the series which should 
still apply and merge cleanly, but I can resend them renumbered if you wish.

Thanks,
Janusz

>       ARM: OMAP1: ams-delta: make board header file local to mach-omap1
> 
> 
> I'm submitting the three patches in series because the last one depends
> on the other two.
> 
> Tony, please set up an immutable tag for this series to be used by MTD
> as there are more changes on Amstrad Delta NAND driver coming in.
> 
> Thanks,
> Janusz
> 
> 
> Changelog:
> v3:
> - rebased on top of v4.19-rc1
> - added Acked-by: received from Miquel
> 
> v2:
> [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
> 	- already in mainline, commit 68e62a15a914
> [PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
> 	- reworked and submitted as a series, already in linux-omap,
> 	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
> 	  table for serio device") followed by 9 more
> [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
> 	- already in mainline, commit d65777d1a2cd
> [PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 1/3 v2]
> 	v2: Remove problematic error code conversion no longer
> 	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine")
> 	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next
> [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
> 	- resubmitting as [PATCH v2 2/3 v4]
> 	v2: Fix handling of devm_gpiod_get_optional() return values -
> 	    thanks to Andy Shevchenko.
> 	v3: Remove problematic error code conversion no longer needed
> 	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
> 	    ams-delta: move late devices back to init_machine") and
> 	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
> 	    find_chip_by_name() failure") already in linux-next - thanks
> 	    to Boris Brezillon
> 	v4: fix style issue - thanks to Boris Brezillon
> [PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
> 	mach-omap1
> 	- resending as [PATCH v2 3/3]
> 
> All dependencies mentioned in v2 changelog are satisfied in v4.19-rc1.
> 
> 
> diffstat:
>  arch/arm/mach-omap1/ams-delta-fiq-handler.S |    2 
>  arch/arm/mach-omap1/ams-delta-fiq.c         |    3 
>  arch/arm/mach-omap1/board-ams-delta.c       |    2 
>  arch/arm/mach-omap1/board-ams-delta.h       |    2 
>  drivers/mtd/nand/raw/ams-delta.c            |  126 +++++++++++++
+--------------
>  drivers/video/fbdev/omap/lcd_ams_delta.c    |   55 ++++--------
>  6 files changed, 93 insertions(+), 97 deletions(-)
> 
> 
