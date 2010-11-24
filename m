From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5 00/14] OMAP: DMA: hwmod and DMA as platform device
Date: Wed, 24 Nov 2010 18:21:36 +0530
Message-ID: <1290603110-14119-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab0KXMv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:51:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Patch series to convert DMA library into platform driver using platform
device model and adapting hwmod for omap2+.
	
The initial patches in the patch series(first 6 patches) prepares 
existing DMA library for getting converted into platform driver.

steps used:
1. The low level read/write macros are converted into static inline functions
so that, these functions can be moved to respective mach-omap driver
files later.
(Thanks to Tony and Kevin for their suggestions on handling all omap register
offset without adding extra enums)
2. Implements generic errata handling for all OMAP DMA errata.
3. DMA hwmod data is updated for respective hwmod db files.
4. The DMA library is split into two layers.
   a. The generic code is retained in plat-omap/dma.c
   b. The machine specific code and API's are moved to
      respective mach-omap dma files.
5. All cpu_*is_* checks are replaced with device attributes and cpu_*is_*
are used only in mach-omap init functions.
6. Desriptor autoloading feature is added and followed by applicable erratum 
for the same.
7. The sysconfig register access for errata handling is replaced with API's
Note: This feature has dependency on the patch:
https://patchwork.kernel.org/patch/352481/
8. PM runtime API's are used.

Patch series applies on top of latest linux omap master branch:
*************************************************************************
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: master
commit 25f7615faa843731af4eda7d05077f1c5132e1a9
Merge: 784bee8 8973a21
Author: Tony Lindgren <tony@atomide.com>

    Linux-omap rebuilt: Updated to -rc3
*************************************************************************

Test Report:
************
Build:
omap2plus_defconfig    : Success
omap_h2_1610_defconfig : Success

Boot:
OMAP2430SDP            : Success
OMAP3630Zoom3          : Success
OMAP4430Blaze(ES2.1)   : Success          
OMAP1                  : Not tested

Unit tests:
Test results are same as v4 test results which can be acccessed at:
OMAP4BLAZE   : http://pastebin.com/HVnim30G
OMAP3630ZOOM3: http://pastebin.com/JJwrtP4F
OMAP243SDP   : http://pastebin.com/mz7cVQL3

Test cases executed:
1. All applicable TI DMA tests which are located at:
http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree;f=dma/test_code;h=0d00de3c0fe6933b405c62da63f694883f3e4b8f;hb=2c50a5a58dea0ffc2d31b827935aeef9b9d11253

2. Use case tests :  TI MMC tests are executed with different types of
file systems such as DOS, ext2, ext3 etc on omap4 blaze and omap3630 zoom3. 
More information can be found at:
http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=tree;f=mmc/test_code;h=d0bc1984eef46ac45719efb02b5c1f4193422a1b;hb=2c50a5a58dea0ffc2d31b827935aeef9b9d11253

Dependencies:
************
This patch series has dependency on omap_device patch:
https://patchwork.kernel.org/patch/352481/

Changelist summary:
v4: Review comments fixed:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37879.html 
https://patchwork.kernel.org/patch/308362/
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38268.html

v3:
Review comments fixed:
http://www.listware.net/201008/linux-omap/89002-patch-v2-0011-omap-dma-hwmod-and-dma-as-platform-driver.html
 - created and tested on latest linux-omap master branch(2.6.36 kernel)

v2:
The review comments which are fixed can be found at:
http://www.spinics.net/lists/linux-omap/msg34291.html
http://www.spinics.net/lists/linux-omap/msg34292.html
http://www.spinics.net/lists/linux-omap/msg34078.html
http://www.spinics.net/lists/linux-omap/msg34083.html

v1:
These changes are based on comments received during internal discussions which has changes(compared to previous version) such as:
 - Code optimization
 - Patches are rearranged in more meaningful way so that git bisect works at any
   intermediate patch in the series.
 - Build tested for all omap's(OMAP1 and OMAP2PLUS)
 - Boot tested for OMAP3 and OMAP4(appreciate if some one tests on OMAP1/2)
 - Applicalbe tests are executed on OMAP3 and OMAP4 boards
 - Rebased and added descriptor autoloading feature(only for omap3630 and omap4)

Patch Summary:
**************

Benoit Cousson (1):
  OMAP4: hwmod data: add system DMA

G, Manjunath Kondaiah (12):
  OMAP: DMA: Replace read/write macros with functions
  OMAP: DMA: Introduce errata handling feature
  OMAP2420: hwmod data: add system DMA
  OMAP2430: hwmod data: add system DMA
  OMAP3: hwmod data: add system DMA
  OMAP1: DMA: Implement in platform device model
  OMAP2+: DMA: hwmod: Device registration
  OMAP: DMA: Convert DMA library into platform driver
  OMAP: DMA: Use DMA device attributes
  OMAP3630: DMA: Add work around for erratum i557
  OMAP2+: DMA: Replace sysconfig register access with API's
  OMAP: PM: DMA: Enable runtime pm

Venkatraman S (1):
  OMAP2+: DMA: descriptor autoloading feature

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  691 +++++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  | 1608 ++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h     |  143 +++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   87 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   87 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   96 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  100 ++
 arch/arm/plat-omap/dma.c                   | 1822 +++-------------------------
 arch/arm/plat-omap/include/plat/dma.h      |  420 ++++---
 11 files changed, 3250 insertions(+), 1808 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

Cc: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>

