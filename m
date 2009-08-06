From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/6] Add support for OMAP35x processors
Date: Thu,  6 Aug 2009 16:05:39 +0530
Message-ID: <1249554939-19199-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36678 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbZHFKfr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:35:47 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AZf41008501
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:35:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This series adds supports for the OMAP35x processors.
Until recently, OMAP35x processors were considered same
as OMAP34x. New processors in the OMAP35x series -
OMAP3505 and OMAP3517 are quite different from the
current lot.

The patches have largely been discussed earlier but
few issues were still open. These issues were related
to similarities between 34x and 35x devices.

 [1] http://marc.info/?l=linux-omap&m=123301852702797&w=2
 [2] http://marc.info/?l=linux-omap&m=123334055822212&w=2

The patch set was generated against:
7c5cb78 : Merge current mainline tree into linux-omap tree

Sanjeev Premi (6):
  OMAP3: Add OMAP35x processors - OMAP3503/15/25/30
  OMAP3: Add OMAP35x processors - OMAP3505/17
  OMAP3: Add runtime check for OMAP35x
  OMAP3: Show coprocessor details during boot
  OMAP3: OMAP35x: Board specific updates
  OMAP3: Add board specific file for OMAP3517EVM

 arch/arm/configs/omap3_beagle_defconfig   |    1 +
 arch/arm/configs/omap3_evm_defconfig      |    1 +
 arch/arm/configs/omap3_pandora_defconfig  |    1 +
 arch/arm/configs/overo_defconfig          |    1 +
 arch/arm/mach-omap2/Kconfig               |   36 +++++-
 arch/arm/mach-omap2/Makefile              |    1 +
 arch/arm/mach-omap2/board-omap3517evm.c   |  127 ++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c   |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c      |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c  |    2 +-
 arch/arm/mach-omap2/board-overo.c         |    2 +-
 arch/arm/mach-omap2/id.c                  |  207 +++++++++++++++++++++++++----
 arch/arm/plat-omap/common.c               |   18 +++-
 arch/arm/plat-omap/include/mach/common.h  |    1 +
 arch/arm/plat-omap/include/mach/control.h |   24 ++++
 arch/arm/plat-omap/include/mach/cpu.h     |   64 +++++++++-
 16 files changed, 455 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3517evm.c

