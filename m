From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 0/5] add omap iommu driver support
Date: Tue, 25 Nov 2008 17:37:33 +0200
Message-ID: <1227627458-24412-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33812 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYKYPiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 10:38:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi,

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

The following changes since commit 3b7de4be879f1f4f55ae59882a5cbd80f6dcf0f0:
  Paul Walmsley (1):
        OMAP3 clock: disable DPLL autoidle while waiting for DPLL to lock

are available in the git repository at:

  http://git.gitorious.org/lk/mainline.git iommu

Hiroshi DOYU (5):
      omap iommu: tlb and pagetable primitives
      omap iommu: omap2 architecture specific functions
      omap iommu: simple virtual address space management
      omap iommu: sysfs for userland interface
      omap iommu: entries for Kconfig and Makefile

 arch/arm/include/asm/io.h                |    2 +
 arch/arm/include/asm/scatterlist.h       |    2 +
 arch/arm/mach-omap2/Makefile             |    5 +
 arch/arm/mach-omap2/iommu2.c             |  402 ++++++++++++++
 arch/arm/mm/ioremap.c                    |    7 +
 arch/arm/plat-omap/Kconfig               |    8 +
 arch/arm/plat-omap/Makefile              |    1 +
 arch/arm/plat-omap/include/mach/iommu.h  |  185 +++++++
 arch/arm/plat-omap/include/mach/iommu2.h |   94 ++++
 arch/arm/plat-omap/include/mach/iovmm.h  |   93 ++++
 arch/arm/plat-omap/iommu-sysfs.c         |  393 ++++++++++++++
 arch/arm/plat-omap/iommu.c               |  831 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h           |   70 +++
 arch/arm/plat-omap/iovmm.c               |  869 ++++++++++++++++++++++++++++++
 14 files changed, 2962 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu2.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 create mode 100644 arch/arm/plat-omap/iommu-sysfs.c
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iopgtable.h
 create mode 100644 arch/arm/plat-omap/iovmm.c

