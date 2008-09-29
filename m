From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 0/4] [RFC] omap iommu driver
Date: Mon, 29 Sep 2008 08:27:00 +0300
Message-ID: <1222666024-27137-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38517 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYI2F1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 01:27:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, lethal@linux-sh.org

Hi all,

I am sending these patches at this early stage to get some feedbacks
about the basic idea of this IOMMU implementation.

Some of OMAP series have the peripheral devices with their own Memory
Management Unit(IOMMU), which is composed of its own TLB and optional
H/W pagetable (TWL). These MMUs doesn't depend on MPU(ARM) MMU at all,
but their algorithms are quite similar and they share the same
physical address space. This patch provides with common in-kernel
iommu APIs such OMAP peripheral devices(Camera ISP, IVA1, IVA2, DSP
and the equivalent ones in the latest OMAP successors) to handle
peripheral device IOMMUs in the same manner.

The following patches are composed of the following modules:

  [PATCH 1/4] omap iommu: tlb and pagetable primitives
  [PATCH 2/4] omap iommu: omap2 architecture specific functions
  [PATCH 3/4] omap iommu: sysfs for userland interface
  [PATCH 4/4] omap iommu: simple virtual address space management

"[PATCH 1/4]" has been updated with Russell's comments on:
http://marc.info/?l=linux-omap&m=122087083712670&w=2

Generalizing this omap iommu code independently from each device
drivers, "Camera(ISP)", "TI bridge(IVA/DSP)", "dspgateway(DSP)" and
the future OMAP equivalent device would be more robust and reduce the
maintenance cost since keeping this critical code at one place can
avoid some risks, like wrong MMU settings, which may cause critical
damages on the system.

 arch/arm/include/asm/io.h                |    2 +
 arch/arm/mach-omap2/iommu2.c             |  373 ++++++++++++
 arch/arm/mm/ioremap.c                    |    7 +
 arch/arm/plat-omap/include/mach/iommu.h  |  178 ++++++
 arch/arm/plat-omap/include/mach/iommu2.h |   92 +++
 arch/arm/plat-omap/include/mach/iovmm.h  |   93 +++
 arch/arm/plat-omap/iommu-sysfs.c         |  407 +++++++++++++
 arch/arm/plat-omap/iommu.c               |  805 ++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h           |   69 +++
 arch/arm/plat-omap/iovmm.c               |  910 ++++++++++++++++++++++++++++++
 10 files changed, 2936 insertions(+), 0 deletions(-)

