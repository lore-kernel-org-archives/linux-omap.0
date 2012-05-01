From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 00/39] OMAP GPMC driver conversion
Date: Tue, 1 May 2012 17:35:09 +0530
Message-ID: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37158 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2EAMW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 08:22:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

GPMC driver conversion patch series. Some peripherals has GPMC helper
functions, these has been modified to cater to the needs of GPMC
driver. All the boards using GPMC has been adapted to use the new
GPMC driver.

GPMC HWMOD entry for OMAP2/3 has been added. On OMAP3, kernel does
spit "omap_hwmod: gpmc: cannot be enabled for reset (3)", but
peripherals connected via GPMC are working. Really shaky about OMAP2
GPMC HWMOD entry. Would be helpful if someone can help me in resolving
warning on OMAP3 & verify whether OMAP2 entry is proper. The series
adapts to HWMOD.

Drivers, NAND & OneNAND of OMAP has been modified to make use of GPMC
changes & cleaned up the now unnecessary exported symbol usages.

This series has been made on top of,
5e136da Linux-omap rebuilt: Updated to -rc5,
A patch by Javier Martinez Canillas <javier@dowhile0.org>,
OMAP3: igep0020: Add support for Micron NAND Flash storage memory,
has also been incorporated into the series as this was necessary for
igep0020 board.

This has been tested on omap3 evm (SMSC911x) & beagle board (NAND)

I would need help to get these changes tested on other boards using
GPMC. Expected problematic boards are those having OMAP2xxx SoCs,
apollon board. In the case of apollon, in addition to it being
OMAP2xxx, it was modified to use gpmc_smc91x_init instead of directly
writing to configuration registers.

Additional features that currently boards in mainline does not make
use of like, waitpin interrupt handling, changes to leverage revision
6 IP differences has not been incorporated.

GPMC driver now provides NAND driver with GPMC-NAND registers so that
OMAP NAND driver can handle those by itself instead of using exported
symbols.

Acquiring CS for NAND has also been incorporated, it has been made as
a separate patch as it is felt that this should probably go away,
explained in the relevant patch.

GPMC (General Purpose Memory Controller) in brief:
GPMC is an unified memory controller dedicated to interfacing external
memory devices like
 Asynchronous SRAM like memories and application specific integrated circuit devices.
 Asynchronous, synchronous, and page mode burst NOR flash devices NAND flash
 Pseudo-SRAM devices

GPMC details can be referred in AM335X Technical Reference Manual
@ http://www.ti.com/lit/pdf/spruh73

v4: Handle wait pin (except for interrupts), enhance configuration
    & timing interface of GPMC to take care of all boards. Dynamic
    allocation of interrupt instead of static. Convert remaining
    peripherals to work with GPMC driver. Handle acquiring NAND CS#,
    adapt to HWMOD, update HWMOD OMAP2/3 entries, other minor
    commenst on v3.
v3: Single device structure passed from platform for peripherals using
    multiple CS instead of using multiple device structure having a few
    redundant data, handle interrupts, GPMC NAND handling by GPMC NAND
    driver instead of GPMC driver
v2: Avoid code movement that kept similar code together (for easy review)

TODO: Cleanup

Regards
Afzal

Afzal Mohammed (38):
  ARM: OMAP2+: gpmc: driver conversion
  ARM: OMAP2+: gpmc: Adapt to HWMOD
  ARM: OMAP2+: gpmc: register details for nand driver
  ARM: OMAP2+: gpmc: Acquire NAND CS value
  ARM: OMAP2+: nand: create platform data structure
  ARM: OMAP2+: onenand: return value in init function
  ARM: OMAP2+: gpmc-nand: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-onenand: Adapt to use gpmc driver
  ARM: OMAP2+: flash: Adapt to gpmc driver
  ARM: OMAP2+: gpmc-smsc911x: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-tusb6010: Adapt to gpmc driver
  ARM: OMAP3: hwmod data: add gpmc
  ARM: OMAP2xxx: hwmod data: add gpmc
  mtd: nand: omap2: obtain memory from resource
  mtd: nand: omap2: use gpmc provided irqs
  mtd: nand: omap2: handle nand on gpmc
  mtd: onenand: omap: obtain memory from resource
  ARM: OMAP2+: board omap3evm: gpmc driver adaptation
  ARM: OMAP2+: board omap3beagle: gpmc driver adaptation
  ARM: OMAP2+: board apollon: gpmc driver adaptation
  ARM: OMAP2+: board h4: gpmc driver adaptation
  ARM: OMAP2+: board 3630sdp: gpmc driver adaptation
  ARM: OMAP2+: board 3430sdp: gpmc driver adaptation
  ARM: OMAP2+: board 2430sdp: gpmc driver adaptation
  ARM: OMAP2+: board cm-t3517: gpmc driver adaptation
  ARM: OMAP2+: board cm-t35: gpmc driver adaptation
  ARM: OMAP2+: board ldp: gpmc driver adaptation
  ARM: OMAP2+: board n8x0: gpmc driver adaptation
  ARM: OMAP2+: board omap3logic: gpmc driver adaptation
  ARM: OMAP2+: board omap3pandora: gpmc driver adaptation
  ARM: OMAP2+: board omap3stalker: gpmc driver adaptation
  ARM: OMAP2+: board omap4pcm049: gpmc driver adaptation
  ARM: OMAP2+: board overo: gpmc driver adaptation
  ARM: OMAP2+: board rm680: gpmc driver adaptation
  ARM: OMAP2+: board rx51: gpmc driver adaptation
  ARM: OMAP2+: board zoom-debugboard: gpmc driver adaptation
  ARM: OMAP2+: board igep0020: gpmc driver adaptation

Javier Martinez Canillas (1):
  OMAP3: igep0020: Add support for Micron NAND Flash storage memory

 arch/arm/mach-omap2/board-2430sdp.c                |   44 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   18 +-
 arch/arm/mach-omap2/board-3630sdp.c                |   23 +-
 arch/arm/mach-omap2/board-apollon.c                |  152 +--
 arch/arm/mach-omap2/board-cm-t35.c                 |   21 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |   10 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    6 +-
 arch/arm/mach-omap2/board-flash.c                  |  160 ++--
 arch/arm/mach-omap2/board-flash.h                  |   36 +-
 arch/arm/mach-omap2/board-h4.c                     |  130 +--
 arch/arm/mach-omap2/board-igep0020.c               |   99 +-
 arch/arm/mach-omap2/board-ldp.c                    |   26 +-
 arch/arm/mach-omap2/board-n8x0.c                   |   18 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   22 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   14 +-
 arch/arm/mach-omap2/board-omap3logic.c             |   13 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |   11 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   13 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |    6 +-
 arch/arm/mach-omap2/board-omap4pcm049.c            |   13 +-
 arch/arm/mach-omap2/board-overo.c                  |   32 +-
 arch/arm/mach-omap2/board-rm680.c                  |   10 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   17 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c        |   47 +-
 arch/arm/mach-omap2/board-zoom.c                   |    5 +-
 arch/arm/mach-omap2/common-board-devices.c         |   46 -
 arch/arm/mach-omap2/common-board-devices.h         |    1 -
 arch/arm/mach-omap2/gpmc-nand.c                    |   84 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  111 +--
 arch/arm/mach-omap2/gpmc-smc91x.c                  |   87 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c                |   59 +-
 arch/arm/mach-omap2/gpmc.c                         |  980 +++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 +
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   41 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   52 ++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 arch/arm/mach-omap2/usb-tusb6010.c                 |  177 ++--
 arch/arm/plat-omap/include/plat/gpmc-smc91x.h      |   10 +-
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h    |    9 +-
 arch/arm/plat-omap/include/plat/gpmc.h             |  110 ++-
 arch/arm/plat-omap/include/plat/nand.h             |   10 +-
 arch/arm/plat-omap/include/plat/onenand.h          |    7 +-
 drivers/mtd/nand/omap2.c                           |  296 ++++--
 drivers/mtd/onenand/omap2.c                        |   29 +-
 include/linux/usb/musb.h                           |    4 +-
 47 files changed, 2110 insertions(+), 988 deletions(-)

-- 
1.7.10

