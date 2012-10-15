From: Afzal Mohammed <afzal@ti.com>
Subject: [GIT PULL] OMAP-GPMC cleanup for common zImage
Date: Mon, 15 Oct 2012 17:44:07 +0530
Message-ID: <1350303247-13495-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab2JOMOY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 08:14:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, David Woodhouse <David.Woodhouse@intel.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git@gitorious.org:x0148406-public/linux-kernel.git tags/gpmc-czimage

for you to fetch changes up to 3ef5d0071cf6c8b9a00b559232bb700ad59999d7:

  ARM: OMAP2+: gpmc: localize gpmc header (2012-10-15 14:42:15 +0530)

----------------------------------------------------------------
gpmc cleanup for common ARM zImage

----------------------------------------------------------------
Afzal Mohammed (16):
      ARM: OMAP2+: nand: unify init functions
      ARM: OMAP2+: onenand: refactor for clarity
      ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
      mtd: onenand: omap: cleanup gpmc dependency
      mtd: nand: omap: free region as per resource size
      mtd: nand: omap: read nand using register address
      ARM: OMAP2+: onenand: connected soc info in pdata
      mtd: onenand: omap: use pdata info instead of cpu_is
      ARM: OMAP2+: onenand: header cleanup
      ARM: OMAP2+: nand: header cleanup
      mtd: nand: omap: bring in gpmc nand macros
      ARM: OMAP2+: nand: bch capability check
      ARM: OMAP2+: gpmc: nand register helper bch update
      mtd: nand: omap: handle gpmc bch[48]
      ARM: OMAP2+: gpmc: remove exported nand functions
      ARM: OMAP2+: gpmc: localize gpmc header

Jon Hunter (1):
      ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function

 arch/arm/mach-omap2/board-2430sdp.c                |   2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   2 +-
 arch/arm/mach-omap2/board-apollon.c                |   2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   5 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |   5 +-
 arch/arm/mach-omap2/board-devkit8000.c             |  10 +-
 arch/arm/mach-omap2/board-flash.c                  |  50 +--
 arch/arm/mach-omap2/board-flash.h                  |   8 +-
 arch/arm/mach-omap2/board-h4.c                     |   2 +-
 arch/arm/mach-omap2/board-igep0020.c               |   5 +-
 arch/arm/mach-omap2/board-ldp.c                    |   6 +-
 arch/arm/mach-omap2/board-n8x0.c                   |   1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |  10 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   8 +-
 arch/arm/mach-omap2/board-omap3logic.c             |   2 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |   3 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |  10 +-
 arch/arm/mach-omap2/board-overo.c                  |   9 +-
 arch/arm/mach-omap2/board-rm680.c                  |   3 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   3 +-
 arch/arm/mach-omap2/board-rx51.c                   |   2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c        |   2 +-
 arch/arm/mach-omap2/board-zoom.c                   |   5 +-
 arch/arm/mach-omap2/common-board-devices.c         |  46 ---
 arch/arm/mach-omap2/common-board-devices.h         |   1 -
 arch/arm/mach-omap2/gpmc-nand.c                    |  85 ++--
 arch/arm/mach-omap2/gpmc-nand.h                    |  27 ++
 arch/arm/mach-omap2/gpmc-onenand.c                 | 214 +++++-----
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 ++
 arch/arm/mach-omap2/gpmc-smc91x.c                  |   2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c                |   2 +-
 arch/arm/mach-omap2/gpmc.c                         | 459 +--------------------
 .../{plat-omap/include/plat => mach-omap2}/gpmc.h  |  61 +--
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |   2 +-
 drivers/mtd/nand/omap2.c                           | 125 +++++-
 drivers/mtd/onenand/omap2.c                        |   9 +-
 include/linux/platform_data/mtd-nand-omap2.h       |  46 ++-
 include/linux/platform_data/mtd-onenand-omap2.h    |  28 +-
 40 files changed, 493 insertions(+), 797 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.h
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc.h (67%)
