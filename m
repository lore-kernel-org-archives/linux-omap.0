From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v7 00/11] OMAP-GPMC: generic time calc, prepare for driver
Date: Wed, 19 Sep 2012 18:51:08 +0530
Message-ID: <cover.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37850 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab2ISNVW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 09:21:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This version - v7 as compared to previous version, takes care of
rounding issues due to the usage of nanoseconds in generic timing
routine. All calculations are now in picoseconds. Once all timings
are calculated it is converted to nanoseconds so that calculated
timing values are compatible with existing custom timing routines
(this will help in reverting back to custom routines easily in case
of any issues). And documentation has been added on gpmc timings.
Also redundant rounding of nand timings has been removed as part of
this series.

**********************************************************************
Abstract:

This series provides a generic gpmc timing calculation routine. There
were three peripherals (OneNAND, tusb6010, smc91x) using custom timing
calculations, they are migrated to use the generic timing calculation.

Such a generic routine would help create a driver out of gpmc platform
code, which would be peripheral agnostic and thus lead to DT finally.
Input to generic timing calculation routine would be gpmc peripheral
timings, output - translated timings that gpmc can understand. Later,
to DT'ify, gpmc peripheral timings could be passed through DT. Input
timings that has been used here are selected such that it represents
those that are present in peripheral timing datasheets.

Also this series contains minor cleanups that were low hanging fruits
came across upon implementing generic timing routine. One such is
credited to Jon Hunter, relevant patch is 1/2 of his series
@ http://marc.info/?l=linux-omap&m=134090910321284&w=2

**********************************************************************

Proposed generic routine has been tested on OneNAND (async) on
OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
local patch were used to test). For other cases of custom timing
calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
calculation routine was verified by simulating on OMAP3EVM.

This series is available
        @ git://gitorious.org/x0148406-public/linux-kernel.git gpmc-prep-v7
and is based on
        linux-next (next-20120918)

Regards
Afzal

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

Afzal Mohammed (10):
  ARM: OMAP2+: nand: unify init functions
  ARM: OMAP2+: nand: remove redundant rounding
  ARM: OMAP2+: gpmc: handle additional timings
  ARM: OMAP2+: onenand: refactor for clarity
  ARM: OMAP2+: gpmc: find features by ip rev check
  ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
  ARM: OMAP2+: gpmc: generic timing calculation
  ARM: OMAP2+: onenand: generic timing calculation
  ARM: OMAP2+: smc91x: generic timing calculation
  ARM: OMAP2+: tusb6010: generic timing calculation

Jon Hunter (1):
  ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function

 Documentation/bus-devices/ti-gpmc.txt      |  77 ++++++
 arch/arm/mach-omap2/board-devkit8000.c     |   8 +-
 arch/arm/mach-omap2/board-flash.c          |  45 ++--
 arch/arm/mach-omap2/board-flash.h          |   6 +-
 arch/arm/mach-omap2/board-igep0020.c       |   2 +-
 arch/arm/mach-omap2/board-ldp.c            |   4 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |   8 +-
 arch/arm/mach-omap2/board-omap3evm.c       |   8 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |   8 +-
 arch/arm/mach-omap2/board-overo.c          |   7 +-
 arch/arm/mach-omap2/board-zoom.c           |   5 +-
 arch/arm/mach-omap2/common-board-devices.c |  45 ----
 arch/arm/mach-omap2/common-board-devices.h |   1 -
 arch/arm/mach-omap2/gpmc-nand.c            |  30 +--
 arch/arm/mach-omap2/gpmc-onenand.c         | 334 +++++++++++--------------
 arch/arm/mach-omap2/gpmc-smc91x.c          |  43 ++--
 arch/arm/mach-omap2/gpmc.c                 | 383 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c         | 181 ++++----------
 arch/arm/plat-omap/include/plat/gpmc.h     | 114 +++++++--
 arch/arm/plat-omap/include/plat/onenand.h  |   8 -
 20 files changed, 836 insertions(+), 481 deletions(-)
 create mode 100644 Documentation/bus-devices/ti-gpmc.txt

-- 
1.7.12

