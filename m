From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH v4 0/3] AM3517: Booting up
Date: Thu, 22 Sep 2011 18:56:30 +0530
Message-ID: <1316697993-696-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, aneesh@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, christian.gmeiner@gmail.com, Abhilash K V <abhilash.kv@ti.com>, Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch-set gets the kernel booting up on a AM3517 EVM.
The board is able to boot with ramdisk after this,but the MMC and Ethernet
drivers are not up yet. Lots of warnings remain which will be addressed in
subsequent patches.

The patches are tested on master of git://github.com/tmlind/linux.git
Kernel version is 3.1.0-rc6 and last commit on top of which these patches
were added is:
	0c2838d00350afc5259730c35bbda81598e8875f: Linux-omap rebuilt: Updated
	to -rc7, merged in dmtimer

Cc: Sanjeev Premi <premi@ti.com>
---
Changes in v4:
 -Rebased and tested against the latest 3.1.0-rc6.
 -Added a patch [3/3] to check for missing PMIC info in vp init.

Changes in v3:
 Presence of SR feature is now used to decide if TWL4030 initialisation is to
 be done or not.

Changes in v2: Incorporated Kevin's comments to add SmartReflex as a FEATURE,
  and use omap3_has_sr() to fall out of omap3_twl_init() for AM35x case.
	

Abhilash K V (3):
  AM35x: Using OMAP3 generic hwmods
  omap_twl: Prevent SR to enable for am3517/am3505 devices
  OMAP2+: voltage: add check for missing PMIC info in vp init

 arch/arm/mach-omap2/id.c                     |    2 +-
 arch/arm/mach-omap2/io.c                     |   11 +++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |    2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pm.c                     |    3 ++-
 arch/arm/mach-omap2/vp.c                     |    7 +++++++
 arch/arm/plat-omap/include/plat/cpu.h        |    2 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 8 files changed, 46 insertions(+), 2 deletions(-)
