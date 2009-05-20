From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Wed, 20 May 2009 12:48:14 +0300 (EEST)
Message-ID: <20090520.124814.124079256.Hiroshi.DOYU@nokia.com>
References: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36700 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZETJsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 05:48:36 -0400
In-Reply-To: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Hi,

If there's no problem with those patches, please pull them from the following.

The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
  Linus Torvalds (1):
        Linux 2.6.30-rc4

are available in the git repository at:

  http://git.gitorious.org/lk/mainline.git iommu

Hiroshi DOYU (7):
      omap iommu: tlb and pagetable primitives
      omap iommu: omap2 architecture specific functions
      omap iommu: omap3 iommu device registration
      omap iommu: simple virtual address space management
      omap iommu: entries for Kconfig and Makefile
      omap2 iommu: entries for Kconfig and Makefile
      omap iommu: add MPU_BRIDGE_IOMMU for tidspbridge migration

 arch/arm/include/asm/mach/map.h          |    8 +
 arch/arm/mach-omap2/Makefile             |    5 +
 arch/arm/mach-omap2/iommu2.c             |  323 ++++++++++
 arch/arm/mach-omap2/omap3-iommu.c        |  105 ++++
 arch/arm/mm/ioremap.c                    |    6 +
 arch/arm/mm/mmu.c                        |    1 +
 arch/arm/plat-omap/Kconfig               |    6 +
 arch/arm/plat-omap/Makefile              |    1 +
 arch/arm/plat-omap/include/mach/iommu.h  |  168 +++++
 arch/arm/plat-omap/include/mach/iommu2.h |   96 +++
 arch/arm/plat-omap/include/mach/iovmm.h  |   94 +++
 arch/arm/plat-omap/iommu.c               |  996 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h           |   72 +++
 arch/arm/plat-omap/iovmm.c               |  896 +++++++++++++++++++++++++++
 14 files changed, 2777 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu2.c
 create mode 100644 arch/arm/mach-omap2/omap3-iommu.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iopgtable.h
 create mode 100644 arch/arm/plat-omap/iovmm.c
