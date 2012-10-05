From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 0/6] OMAP-GPMC cleanup for generic timing
Date: Fri, 5 Oct 2012 21:04:57 +0530
Message-ID: <cover.1349444935.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48225 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758Ab2JEPfO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:35:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Hi,

This series prepares gpmc for generic timing. v7 of this series was
named "OMAP-GPMC: generic time calc, prepare for driver". generic
timing routine has been removed from this series. generic timing
will be posted as a new separate series shortly.

This rearrangement has been done so that generic timing series will
happen on top of another cleanup series required for common arm zImage.
Both will follow shortly. Intention is to make easy path for common
arm zImage cleanup.

This series contains minor cleanups that were low hanging fruits
came across upon implementing generic timing routine.

This series is same as v7, except that last 4 patches in v7 has been
removed from this series (those 4 patches were for generic timing)

This series is available
        @ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-prep-v8
and is based on
        linux-next (next-20121005)

Regards
Afzal

v8:
	Remove generic timing conversion patches

v7:
        1. Use picoseconds throughout generic timing routine to prevent
         rounding error.
	2. Documentation on gpmc timings
        3. Remove redundant rounding of nand timings (a new patch)

v6:
        1. Generic timing calculation, move existing users of custom
         calculation to use the new generic one
        2. Set OneNAND part to async mode before gpmc configuration
        3. Move extra delay time user handling to proper patch
         (3/10 -> 2/10)
        4. Modify nand init for OMAP3EVM too as support got added
v5:
        Use flags for sync_read/write, hv, vhf
v4:
        Reorganize OneNAND set_sync/async functions in a better way
v3:
        1. Refactor OneNAND set_sync/async functions to separate out
         timing and configurations
        2. Handle bool type timings too
        3. Swap patches 2 & 3 due to dependency of OneNAND change on
         newly added bool type timings
v2:
        1. Make use of timing api for setting clock activation time,
         and remove direct writing to register for clock activation.
        2. Move ensuring that async mode in OneNAND has been setup from
         set_sync to setup function, improve commit message


Afzal Mohammed (5):
  ARM: OMAP2+: nand: unify init functions
  ARM: OMAP2+: nand: remove redundant rounding
  ARM: OMAP2+: gpmc: handle additional timings
  ARM: OMAP2+: onenand: refactor for clarity
  ARM: OMAP2+: gpmc: remove cs# in sync clk div calc

Jon Hunter (1):
  ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function

 arch/arm/mach-omap2/board-devkit8000.c          |   8 +-
 arch/arm/mach-omap2/board-flash.c               |  45 ++---
 arch/arm/mach-omap2/board-flash.h               |   6 +-
 arch/arm/mach-omap2/board-igep0020.c            |   2 +-
 arch/arm/mach-omap2/board-ldp.c                 |   4 +-
 arch/arm/mach-omap2/board-omap3beagle.c         |   8 +-
 arch/arm/mach-omap2/board-omap3evm.c            |   8 +-
 arch/arm/mach-omap2/board-omap3touchbook.c      |   8 +-
 arch/arm/mach-omap2/board-overo.c               |   7 +-
 arch/arm/mach-omap2/board-zoom.c                |   5 +-
 arch/arm/mach-omap2/common-board-devices.c      |  45 -----
 arch/arm/mach-omap2/common-board-devices.h      |   1 -
 arch/arm/mach-omap2/gpmc-nand.c                 |  30 ++-
 arch/arm/mach-omap2/gpmc-onenand.c              | 232 ++++++++++++------------
 arch/arm/mach-omap2/gpmc.c                      |  52 +++++-
 arch/arm/mach-omap2/usb-tusb6010.c              |   3 +-
 arch/arm/plat-omap/include/plat/gpmc.h          |  21 ++-
 include/linux/platform_data/mtd-onenand-omap2.h |   8 -
 18 files changed, 262 insertions(+), 231 deletions(-)

-- 
1.7.12

