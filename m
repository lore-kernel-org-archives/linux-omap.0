From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod migration
Date: Mon, 10 Sep 2018 00:56:02 +0200
Message-ID: <20180909225605.16463-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


This is a follow up of initial submission of a series consisted of 
6 changes, 3 of which have been already applied or reworkeed.


Janusz Krzysztofik (3):
      video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
      mtd: rawnand: ams-delta: use GPIO lookup table
      ARM: OMAP1: ams-delta: make board header file local to mach-omap1


I'm submitting the three patches in series because the last one depends
on the other two.

Tony, please set up an immutable tag for this series to be used by MTD
as there are more changes on Amstrad Delta NAND driver coming in.

Thanks,
Janusz


Changelog:
v3:
- rebased on top of v4.19-rc1
- added Acked-by: received from Miquel

v2:
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

All dependencies mentioned in v2 changelog are satisfied in v4.19-rc1.


diffstat:
 arch/arm/mach-omap1/ams-delta-fiq-handler.S |    2 
 arch/arm/mach-omap1/ams-delta-fiq.c         |    3 
 arch/arm/mach-omap1/board-ams-delta.c       |    2 
 arch/arm/mach-omap1/board-ams-delta.h       |    2 
 drivers/mtd/nand/raw/ams-delta.c            |  126 ++++++++++++++--------------
 drivers/video/fbdev/omap/lcd_ams_delta.c    |   55 ++++--------
 6 files changed, 93 insertions(+), 97 deletions(-)
