From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Tue, 27 Jan 2009 23:31:39 +0200 (EET)
Message-ID: <20090127.233139.58420377.Hiroshi.DOYU@nokia.com>
References: <20090116083709.18344.74524.stgit@oreo.research.nokia.com>
	<20090117160608.GA12341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38972 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbZA0Vci (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 16:32:38 -0500
In-Reply-To: <20090117160608.GA12341@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi Russell, Thank you for your reivew.

Just for your convenience, the updated patchset is available as below.

The following changes since commit 1de9e8e70f5acc441550ca75433563d91b269bbe:
  Linus Torvalds (1):
        Linux 2.6.29-rc2

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
 arch/arm/mach-omap2/iommu2.c             |  326 ++++++++++
 arch/arm/mach-omap2/omap3-iommu.c        |  103 ++++
 arch/arm/mm/ioremap.c                    |   11 +
 arch/arm/plat-omap/Kconfig               |    8 +
 arch/arm/plat-omap/Makefile              |    1 +
 arch/arm/plat-omap/include/mach/iommu.h  |  157 +++++
 arch/arm/plat-omap/include/mach/iommu2.h |   94 +++
 arch/arm/plat-omap/include/mach/iovmm.h  |   94 +++
 arch/arm/plat-omap/iommu.c               |  953 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/iopgtable.h           |   72 +++
 arch/arm/plat-omap/iovmm.c               |  891 ++++++++++++++++++++++++++++
 13 files changed, 2721 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu2.c
 create mode 100644 arch/arm/mach-omap2/omap3-iommu.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/mach/iovmm.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iopgtable.h
 create mode 100644 arch/arm/plat-omap/iovmm.c
