From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 0/6] Initial support for omap iommu driver
Date: Tue, 05 May 2009 15:46:45 +0300
Message-ID: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37890 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbZEEMrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 08:47:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Some of TI OMAP series have the peripheral devices with their own
Memory Management Unit(IOMMU), which is composed of its own TLB and
optional H/W pagetable (TWL). These MMUs doesn't depend on MPU(ARM)
MMU at all, but their algorithms are quite similar and they share the
same physical address space. This patch provides with common in-kernel
iommu APIs such OMAP peripheral devices(Camera ISP, IVA1, IVA2, DSP
and the equivalent ones in the latest OMAP successors) to handle
peripheral device IOMMUs in the same manner.

"tlb and pagetable primitives" has been updated with Russell's
comments on:

      http://marc.info/?l=linux-omap&m=122087083712670&w=2

Generalizing this omap iommu code independently from each device
drivers, "Camera(ISP)", "TI bridge(IVA/DSP)", "dspgateway(DSP)" and
the future OMAP equivalent device would be more robust and reduce the
maintenance cost since keeping this critical code at one place can
avoid some risks, like wrong MMU settings, which may cause critical
damages on the system.

---
The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
  Linus Torvalds (1):
        Linux 2.6.30-rc4

are available in the git repository at:

  http://git.gitorious.org/lk/mainline.git iommu

Hiroshi DOYU (6):
      omap iommu: tlb and pagetable primitives
      omap iommu: omap2 architecture specific functions
      omap iommu: omap3 iommu device registration
      omap iommu: simple virtual address space management
      omap iommu: entries for Kconfig and Makefile
      omap2 iommu: entries for Kconfig and Makefile

 arch/arm/include/asm/io.h                |    6 +
 arch/arm/mach-omap2/Makefile             |    5 +
 arch/arm/mach-omap2/iommu2.c             |  323 ++++++++++
 arch/arm/mach-omap2/omap3-iommu.c        |  105 ++++
 arch/arm/mm/ioremap.c                    |   11 +
 arch/arm/plat-omap/Kconfig               |    8 +
 arch/arm/plat-omap/Makefile              |    1 +
 arch/arm/plat-omap/include/mach/iommu.h  |  168 +++++
 arch/arm/plat-omap/include/mach/iommu2.h |   96 +++
 arch/arm/plat-omap/include/mach/iovmm.h  |   94 +++
 arch/arm/plat-omap/iommu.c               |  996 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h           |   72 +++
 arch/arm/plat-omap/iovmm.c               |  890 ++++++++++++++++++++++++++
 13 files changed, 2775 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu2.c
 create mode 100644 arch/arm/mach-omap2/omap3-iommu.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iopgtable.h
 create mode 100644 arch/arm/plat-omap/iovmm.c
