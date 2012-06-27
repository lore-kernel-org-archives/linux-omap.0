From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 0/3] Prepare for GPMC driver conversion
Date: Wed, 27 Jun 2012 12:03:07 +0530
Message-ID: <cover.1340778002.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2F0Gs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 02:48:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>


Hi,

Objective of this series is to make things easy for GPMC driver
conversion series by separating out more things from driver
conversion series.

This series,
1. Unifies NAND platform initialization functions
2. Prepares OneNAND platform code for gpmc driver migration
3. Handles additional timings in Kernel

This series is based on 3.5-rc1 & made on top of
[PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
{http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70096.html}

These changes has been tested with omap3evm & beagle board. Relevant
GPMC peripherals that got tested by this were NAND (beagle) and
OneNAND (using local patches for omap3evm)

Regards
Afzal

v5:
1. Use flags for sync_read/write, hv, vhf
v4:
1. Reorganize OneNAND set_sync/async functions in a better way
v3:
1. Refactor OneNAND set_sync/async functions to separate out timing
 and configurations
2. Handle bool type timings too
3. Swap patches 2 & 3 due to dependency of OneNAND change on  newly
 added bool type timings
v2:
1. Make use of timing api for setting clock activation time, and
 remove direct writing to register for clock activation. Peripherals
 making use of it were tusb6010 & onenand
2. Move ensuring that async mode in OneNAND has been setup from
 set_sync to setup function, improve commit message


Afzal Mohammed (3):
  ARM: OMAP2+: nand: unify init functions
  ARM: OMAP2+: gpmc: handle additional timings
  ARM: OMAP2+: onenand: prepare for gpmc driver migration

 arch/arm/mach-omap2/board-devkit8000.c     |    8 +-
 arch/arm/mach-omap2/board-flash.c          |   45 ++++---
 arch/arm/mach-omap2/board-flash.h          |    6 +-
 arch/arm/mach-omap2/board-igep0020.c       |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    8 +-
 arch/arm/mach-omap2/board-overo.c          |    7 +-
 arch/arm/mach-omap2/board-zoom.c           |    5 +-
 arch/arm/mach-omap2/common-board-devices.c |   46 -------
 arch/arm/mach-omap2/common-board-devices.h |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c         |  200 ++++++++++++++++------------
 arch/arm/mach-omap2/gpmc.c                 |   45 +++++++
 arch/arm/mach-omap2/usb-tusb6010.c         |    3 +-
 arch/arm/plat-omap/include/plat/gpmc.h     |   19 +++
 15 files changed, 235 insertions(+), 172 deletions(-)

-- 
1.7.10.2

