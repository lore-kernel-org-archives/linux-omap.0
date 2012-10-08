From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
Date: Mon, 8 Oct 2012 11:05:56 +0530
Message-ID: <cover.1349672877.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2JHFgV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 01:36:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Hi,

This version(v2) of gpmc related cleanup for common zImage compared to
initial version, resolves build error upon selecting BCH CONFIG option.
Also a trivial patch on gpmc header removal from nand driver has been
squashed with patch that removes nand driver dependency on gpmc header
file.

This series cleans up omap-gpmc related code so that omap can
be a part of common zImage.

This series moves gpmc.h from plat-omap/include/plat to mach-omap2
so that header file is local.

Patches 1-4 qualifies as -rc material.

Patch 1 is an already posted one, has been pulled into this series.

Patches 5-6 removes necessity of cpu.h from onenand driver based
on Tony's suggestion.

Patches 7 & 8 cleans up the already moved platform data header files
to contain only platform data. Also gpmc-nand information is moved
to nand platform data header.

Patches 9-13 makes nand driver independent of gpmc header file

And the final patch localizes gpmc header.

This has been tested on omap3evm.

This series is available
        @ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-czimage-v2
and is based on
        linux-next (next-20121005)
and is dependent on
	http://marc.info/?l=linux-omap&m=134945131602622&w=2

Regards
Afzal


Afzal Mohammed (14):
  ARM: OMAP2+: gpmc: annotate exit sections properly
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

 arch/arm/mach-omap2/board-2430sdp.c             |   2 +-
 arch/arm/mach-omap2/board-3430sdp.c             |   2 +-
 arch/arm/mach-omap2/board-apollon.c             |   2 +-
 arch/arm/mach-omap2/board-cm-t35.c              |   5 +-
 arch/arm/mach-omap2/board-cm-t3517.c            |   5 +-
 arch/arm/mach-omap2/board-devkit8000.c          |   2 +-
 arch/arm/mach-omap2/board-flash.c               |   7 +-
 arch/arm/mach-omap2/board-flash.h               |   2 +-
 arch/arm/mach-omap2/board-h4.c                  |   2 +-
 arch/arm/mach-omap2/board-igep0020.c            |   3 +-
 arch/arm/mach-omap2/board-ldp.c                 |   2 +-
 arch/arm/mach-omap2/board-n8x0.c                |   1 +
 arch/arm/mach-omap2/board-omap3beagle.c         |   2 +-
 arch/arm/mach-omap2/board-omap3logic.c          |   2 +-
 arch/arm/mach-omap2/board-omap3pandora.c        |   3 +-
 arch/arm/mach-omap2/board-omap3stalker.c        |   2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c      |   2 +-
 arch/arm/mach-omap2/board-overo.c               |   2 +-
 arch/arm/mach-omap2/board-rm680.c               |   3 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c    |   3 +-
 arch/arm/mach-omap2/board-rx51.c                |   2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c     |   2 +-
 arch/arm/mach-omap2/common-board-devices.c      |   1 -
 arch/arm/mach-omap2/gpmc-nand.c                 |  81 +++--
 arch/arm/mach-omap2/gpmc-nand.h                 |  27 ++
 arch/arm/mach-omap2/gpmc-onenand.c              |   9 +-
 arch/arm/mach-omap2/gpmc-onenand.h              |  24 ++
 arch/arm/mach-omap2/gpmc-smc91x.c               |   2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   2 +-
 arch/arm/mach-omap2/gpmc.c                      | 459 ++----------------------
 arch/arm/mach-omap2/gpmc.h                      | 154 ++++++++
 arch/arm/mach-omap2/pm34xx.c                    |   2 +-
 arch/arm/mach-omap2/usb-tusb6010.c              |   2 +-
 arch/arm/plat-omap/include/plat/gpmc.h          | 209 -----------
 drivers/mtd/nand/omap2.c                        | 125 +++++--
 drivers/mtd/onenand/omap2.c                     |   9 +-
 include/linux/platform_data/mtd-nand-omap2.h    |  46 ++-
 include/linux/platform_data/mtd-onenand-omap2.h |  20 +-
 38 files changed, 472 insertions(+), 758 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.h
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 create mode 100644 arch/arm/mach-omap2/gpmc.h
 delete mode 100644 arch/arm/plat-omap/include/plat/gpmc.h

-- 
1.7.12

