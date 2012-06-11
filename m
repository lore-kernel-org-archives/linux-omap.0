From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/9] Adapt GPMC peripherals, platforms to driver
Date: Mon, 11 Jun 2012 20:28:15 +0530
Message-ID: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54644 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab2FKPN5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:13:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

This series provides new interface for GPMC peripherals that use
helper functions for initialization and configures omap3evm &
beagleboard GPMC in Kernel. Existing interface would continue to
serve its purpose as before.

New interface for smsc911x has been provided the runtime timing
calculation capability. This had to be tested on different boards.
omap3evm has been converted to use this new smsc911x runtime
calculation capability, thus is being configured in Kernel.

beagleboard nand has been modified to use new interface in addition to
making use of runtime calculation, and is being configured in Kernel

This series is based on 3.5-rc1, and is dependent on [1,2,3,4] and has
been tested on omap3evm (smsc911x) rev G & C and beagle board(nand)

Also using private patches, nand & onenand was tested on omap3evm,
rev G & C respectively (as support for these were not in mainline)

omap3evm & beagleboard are the two boards that could be tested here.
Within a couple of days, series for converting other boards (but
which can't be tested) would be posted (unless there are strong
objections to the way these patch series are going) along with
updation of feature-removal-schedule.txt regarding deprecation of
GPMC bootloader dependency (feature-removal-schedule.txt patch would
make sense only with the modification of remaining boards to work
gpmc driver)

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69891.html
[4] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69897.html

Afzal Mohammed (9):
  ARM: OMAP2+: gpmc-nand: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-onenand: Adapt to use gpmc driver
  ARM: OMAP2+: flash: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-tusb6010: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-smsc911x: Adapt to use gpmc driver
  ARM: OMAP2+: gpmc-smsc911x: runtime time calculation
  ARM: OMAP2+: board omap3evm: use gpmc driver
  ARM: OMAP2+: board omap3beagle: use gpmc driver

 arch/arm/mach-omap2/board-flash.c               |  126 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-flash.h               |   29 ++++++
 arch/arm/mach-omap2/board-omap3beagle.c         |   16 ++-
 arch/arm/mach-omap2/board-omap3evm.c            |   12 ++-
 arch/arm/mach-omap2/gpmc-nand.c                 |   41 ++++++++
 arch/arm/mach-omap2/gpmc-onenand.c              |  117 ++++++++++++++++++---
 arch/arm/mach-omap2/gpmc-smc91x.c               |   69 +++++++++++--
 arch/arm/mach-omap2/gpmc-smsc911x.c             |  119 +++++++++++++++++++++
 arch/arm/mach-omap2/usb-tusb6010.c              |  113 +++++++++++++++++++-
 arch/arm/plat-omap/include/plat/gpmc-smc91x.h   |   12 ++-
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   25 ++++-
 arch/arm/plat-omap/include/plat/gpmc.h          |    8 ++
 arch/arm/plat-omap/include/plat/nand.h          |    7 ++
 arch/arm/plat-omap/include/plat/onenand.h       |    8 +-
 14 files changed, 662 insertions(+), 40 deletions(-)

-- 
1.7.10.2

