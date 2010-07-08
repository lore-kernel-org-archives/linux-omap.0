From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 00/10] OMAP: DMA: HWMOD and convert into platform driver
Date: Fri,  9 Jul 2010 04:21:12 +0530
Message-ID: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39641 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758698Ab0GHWyF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 18:54:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch series is to convert existing OMAP DMA library into platform driver
for all the OMAP1 and OMAP2 plus processors as per alignment with
Benoit, Paul and Kevin.

The platform device model for OMAP2 plus will makes use of hwmod data base 
and it is based on the reference branch:

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: pm-wip/hwmods-omap4
commit f1c79ab452ed9cf7b5ff6488335c1ddf15d5c92a
Author: Benoit Cousson <b-cousson@ti.com>
    OMAP4: hwmod: Enable omap_hwmod build for OMAP4

The proposal is to:
1. Convert DMA library into platform driver in hwmod way
2. Clean up API's to remove cpu_is_xxxx checks.
3. Make use of DMA engine(See Documentation/crypto/async-tx-api.txt)

This series is going to cover 1 & 2 and 3 will be taken up once these changes
becomes stable and thoroughly tested on all omap boards.

The API's are cleaned up to remove cpu_is_xxxx checks and code is moved 
to corresponding respective mach-omap folders.

Basic tests are performed with this patch series on OMAP3630(Zoom3) board.
All other major defconfigs are build tested. OMAP4 boot seems to be broken
on above branch for both MMC and ethernet. 

List of TODO's:
1. To perform more tests on OMAP4 once the branch is bootable.
2. OMAP2 boot and basic dma tests

It will be helpful is some one tests and provides feedback on OMAP1 and OMAP2
boards since I don't have OMAP1 board.

Manjunatha GK (10):
  OMAP2420: DMA: HWMOD: Add hwmod data structures
  OMAP2430: DMA: HWMOD: Add hwmod data structures
  OMAP3: DMA: HWMOD: Add hwmod data structures
  OMAP4: DMA: HWMOD: update OMAP4 data base
  OMAP1: DMA: Introduce DMA driver as platform driver
  OMAP2/3/4: DMA: HWMOD: Device registration
  OMAP2/3/4: DMA: Move chain API's to mach-omap2
  OMAP: DMA: Move IRQ handlers to mach-omap
  OMAP: DMA: API's Clean up
  OMAP: DMA: Cleanup DMA library and enable DMA platform driver

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dma.c                  |  595 +++++++++
 arch/arm/mach-omap1/include/mach/dma.h     |   80 ++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dma.c                  | 1268 ++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h     |  103 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   95 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   93 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   90 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 +-
 arch/arm/plat-omap/dma.c                   | 1968 ++++++----------------------
 arch/arm/plat-omap/include/plat/dma.h      |  438 +++----
 12 files changed, 2920 insertions(+), 1835 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>


