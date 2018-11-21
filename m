From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API for data I/O
Date: Wed, 21 Nov 2018 12:08:02 +0100
Message-ID: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org


Finalize implementation of the idea suggested by Artem Bityutskiy and
Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure"). Use pure GPIO consumer API, as reqested
by Boris Brezillon.

Janusz Krzysztofik (4):
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: Request data port GPIO resource
      mtd: rawnand: ams-delta: Use GPIO API for data I/O
      ARM: OMAP1: ams-delta: Drop obsolete NAND resources

 arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
 drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
 2 files changed, 80 insertions(+), 62 deletions(-)

Performance on Amstrad Delta is now acceptable after recent extensions
to GPIO API and rawnanad enhancements.

Series intented to be merged via mtd tree, should not conflict with
other OMAP1 patches submitted for 4.21.

Changelog:
v4:   
- drop patches 1/7, 2/7, 5/7 6/7 - changes already merged,
- reintroduce postponed PATCH v2 06/12 as 4/4,
- rebase on nand-next for 4.21.

v3:
[PATCH v3 1/7] mtd: rawnand: ams-delta: show parent device in sysfs
- renamed and an explanation added based on other similar patches on
 Marek Vasut request, thanks.
[PATCH v3 2/7] mtd: rawnand: ams-delta: Use private structure
- no changes.
[PATCH v3 3/7] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND
 data port
- no changes.
[PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO resource
- no changes.
[PATCH v3 5/7] mtd: rawnand: ams-delta: Set port direction when needed
- modified to set port direction only when needed instead of on each
 transfer as suggested by Boris, thanks, though I kept separate 
 *_next_byte() functions to maximize performance as much as possible,
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data
 I/O" with a comment added referring to the planned switch to GPIO API.
[PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data 
 I/O" on Boris request, thanks.
[RFC PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data I/O
- rebased back on top of the two mentioned above,
- not intended to apply it yet due to performance issues on Amstrad Delta.
Removed from the series:
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
 mapping
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- intended to be still iterated in a follow up series until performance
 issues are resolved.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- postponed until acceptable performance on Amstrad Delta is achieved.

v2:
[RFC PATCH v2 00/12] mtd: rawnand: ams-delta: Use GPIO API for data I/O
- renamed from former [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use
  gpio-omap accessors for data I/O
[RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent,
                        not mtd->owner
- split out from former [RFC PATCH 1/8] on Boris request, thanks.
[RFC PATCH v2 02/12] mtd: rawnand: ams-delta: Use private structure
- remaining part of the former [RFC PATCH 1/8].
[RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table
                        for NAND data port
- split out from former [RFC PATCH 5/8] on Boris requesst, thanks,
[RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port GPIO resource
- remaining part of the former [RFC PATCH 5/8],
[RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
- reworked from former [RFC PATCH 8/8] on Boris requesst to use pure
  GPIO API, thanks,
- moved up in front of former [RFC PATCH 3/8] on Boris request, thanks.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- split out from former [RFC PATCH 8/8].
[RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per
                        transfer
- reworked from former [RFC PATCH 3/8] on top of [RFC PATCH v2 05/12].
[RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution
                        on read/write
- reworked from former [RFC PATCH 4/8] on top of [RFC PATCH v2 08/12],
- renamed from 'Optimize' to 'Simplify' on Boris request, thanks.
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
                        mapping
- new patch.
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
- new patch.
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
- new patch.
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- new patch.
Removed from the series:
[RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
- postponed on Boris request, thanks.
[RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
- already applied by Linux in linux-gpio tree, thanks.
[RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
- most controversial one, no longer needed after switching to GPIO API.

Thanks,
Janusz
