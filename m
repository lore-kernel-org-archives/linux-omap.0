From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
Date: Wed, 18 Jul 2018 01:14:45 +0200
Message-ID: <20180717231448.14958-1-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchen>
List-Id: linux-omap@vger.kernel.org


This is a follow up of initial submission of a series consisted of 
6 changes, 3 of which have been already applied or reworkeed.

V2 changelog:
[PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
	- already in mainline, commit 68e62a15a914
[PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
	- reworked and submitted as a series, already in linux-omap,
	  commit 68e62a15a914 ("ARM: OMAP1: ams-delta: drop GPIO lookup
	  table for serio device") followed by 9 more
[PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
	- already in mainline, commit d65777d1a2cd
[PATCH 4/6] fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
	- resubmitting as [PATCH v2 1/3 v2]
	v2: Remove problematic error code conversion no longer
	    needed if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine")
	    and commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next
[PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
	- resubmitting as [PATCH v2 2/3 v4]
	v2: Fix handling of devm_gpiod_get_optional() return values -
	    thanks to Andy Shevchenko.
	v3: Remove problematic error code conversion no longer needed
	    if used on top of commit d08605a64e67 ("ARM: OMAP1:
	    ams-delta: move late devices back to init_machine") and
	    commit 8853daf3b4ac ("gpiolib: Defer on non-DT
	    find_chip_by_name() failure") already in linux-next - thanks
	    to Boris Brezillon
	v4: fix style issue - thanks to Boris Brezillon
[PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to
	mach-omap1
	- resending as [PATCH v2 3/3]

Dependency on commit 8853daf3b4ac ("gpiolib: Defer on non-DT
find_chip_by_name() failure") is not critical - it is not needed for
clean build or run, it only prevents from potential future changes to
driver initializaton order during device_initcall.

I'm submitting the three patches in series because the last one depends
on the other two.

Thanks,
Janusz
