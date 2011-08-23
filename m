From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH v2 0/2] AM3517: Booting up
Date: Tue, 23 Aug 2011 18:51:04 +0530
Message-ID: <1314105664-17347-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Abhilash K V <abhilash.kv@ti.com>, Sanjeev Premi <premi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch-set gets the kernel booting up on a AM3517 EVM.
The board is able to boot with ramdisk after this,but the MMC and Ethernet
drivers are not up yet. Lots of warnings remain which will be addressed in
subsequent patches.

The patches are tested on master of tmlind/linux-omap-2.6.git.
Kernel version is 3.1.0-rc1 and last commit on top of which these patches
were added is:

	d4f02b12e9cf9b443ee07b97245d8e8515d84029:omap: timer:
	Set dmtimer used as clocksource in autoreload mode

Cc: Sanjeev Premi <premi@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v2: Incorporated Kevin's comments to add SmartReflex as a FEATURE, and use
    omap3_has_sr() to fall out of omap3_twl_init() for AM35x case.

Abhilash K V (1):
  AM35x: Using OMAP3 generic hwmods

Vaibhav Hiremath (1):
  omap_twl: Prevent SR to enable for am3517/am3505 devices

 arch/arm/mach-omap2/board-am3517evm.c        |   11 +++++++++++
 arch/arm/mach-omap2/id.c                     |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c               |    8 ++++++++
 arch/arm/plat-omap/include/plat/cpu.h        |    2 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 7 files changed, 45 insertions(+), 2 deletions(-)
