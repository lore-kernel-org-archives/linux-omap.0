From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v2.6.37-rc5
Date: Mon, 13 Dec 2010 11:32:05 -0800
Message-ID: <20101213193204.GY3054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull what should be the last set of omap specific fixes
for this -rc cycle:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

The main fixes are to make PM code to compile without CONFIG_DEBUG_FS,
and a fix for the console for suspend.

The first patch just moves some code around. The second patch adds
checks for suspend to the recent fix 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6
(OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled).
Again, this will eventually be handled by runtime PM but that's not
suitable for the -rc series.

The rest are trivial fixes for for some board specific issues, and
to handle clk_get values with IS_ERR.

Regards,

Tony


The following changes since commit cf7d7e5a1980d1116ee152d25dac382b112b9c17:

  Linux 2.6.37-rc5 (2010-12-06 20:09:04 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (1):
      arm: omap2: io: fix clk_get() error check

Kevin Hilman (3):
      omap: PM debug: fix wake-on-timer debugfs dependency
      OMAP1: SRAM: fix size for OMAP1611 SoCs
      OMAP2+: PM/serial: fix console semaphore acquire during suspend

Ohad Ben-Cohen (1):
      omap: zoom: wl1271 slot is MMC_CAP_POWER_OFF_CARD

Paul Walmsley (1):
      OMAP2: PRCM: fix some SHIFT macros that were actually bitmasks

Sukumar Ghorai (1):
      omap: nand: remove hardware ECC as default

Vasiliy Kulikov (1):
      arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check

 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/io.c                     |    2 +-
 arch/arm/mach-omap2/pm-debug.c               |   34 +++++++++++++-------------
 arch/arm/mach-omap2/pm24xx.c                 |   34 +++++++++++++++++++++++--
 arch/arm/mach-omap2/pm34xx.c                 |   27 +++++++++++++++-----
 arch/arm/mach-omap2/prcm-common.h            |   11 ++++----
 arch/arm/plat-omap/counter_32k.c             |    3 +-
 arch/arm/plat-omap/sram.c                    |    2 +-
 drivers/mtd/nand/omap2.c                     |    1 -
 9 files changed, 79 insertions(+), 37 deletions(-)
