From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC] ARM: OMAP: peripheral device common IOMMU driver
Date: Mon,  8 Sep 2008 08:56:29 +0300
Message-ID: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33403 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYIHF5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 01:57:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, r-woodruff2@ti.com

Hi all,

I am sending these patchs at this early stage to get some feedbacks
just for the basic idea of this IOMMU. This is under development and I
haven't even tried this with a real device, sorry for too unmaturity,
but may be enough for the above purpose.

Some of OMAP series have the peripheral devices with their own Memory
Management Unit(IOMMU), which is composed of  TLB and/or H/W
pagetable(TWL). These MMUs doesn't depend on MPU(ARM) MMU at all but
their algorithms are quite similar and they share the same physical
address space. This patch provides such OMAP peripheral
devices(Camera, IVA1, IVA2, DSP and the later equivalent ones) with
the common in-kernel APIs to handle peripheral device IOMMUs in the
same manner. The following patches are composed of the following
parts:

(1) device TLB operation
(2) device H/W pagetable(TWL) operation
(3) device Virtual address space management 	(*partialy implemented)
(4) Consistency between MPU MMU	and device IOMMUs (*not implemented yet)
(5) User application interface(sysfs)		(*partialy implemented)

Since all of peripheral device IOMMUs use the same algorithm as ARM
MMU does, this patch tries to apply linux in-kernel generic memory
management APIs to its MMU algorithm. "pgd_*()", "pmd_*()" and
"pte_*()" family are used for (1) and (2). "struct
vm_area_struct(VMA)" is used for (3). "struct mm_struct" is used to
keep (2) and (3) together. There are lots of possibily left that
"mm_struct" can be used more tightly with VMA operations, though.

Major APIs are sorted out like:

  iotlb_*(), ioset_pte_ext():	device TLB operations
  iotwl_*():			device TWL operations
  io<vma api>():		device VMA management(ex: ioget_unmapped_area())
  iommu_*():			the other operations for device IOMMU
  arch_iommu->*():     		absorb diffrence between omap1 and omap2

This patch has not included (4) yet. Since MPU MMU and device IOMMU
shares the same physical memory, this consistency has to be taken care
of if device IOMMU uses some of them. For example, reserving physical
memory for ARM not to access wrongly during device IOMMU
operation. These code is supposed to be implemented in client
driver/application side in the separate patches to afford these
differences easier. OMAP1 support is missing, too, for now.

"mmu-class" provides (5) to present some generic MMU information and
to control them too, like setting a TLB entry and a pagetable entry, from
userland through sysfs files. Since this is a normal MMU(TLB +
Pagetable + VMA) class, this can handle any MMU as well. This
"mmu-class" enables to implement an userland MMU manager for devices
later. This sysfs entires are just examples. "mmu-class" can be
considered as the entry point for any MMU to register itself to any
upper layter interface modules. "dspfs" registration also can be done
here.

Generalizing this code independently from each device "Camera(ISP)",
"TI bridge(IVA/DSP)", "dspgateway(DSP)" and the future OMAP equivalent
device would be more robust and reduce the maintenance cost because
keeping this critical code at one place can avoid wrong MMU settings
which may kill the system.

This is almost rewritten version of "plat-omap/mmu.c" and intends to
replace it and "dspgateway" has to be updated to use this interfaces
later in the end.

Hiroshi DOYU (4):
      ARM: OMAP: IOMMU driver: Core part
      ARM: OMAP: IOMMU driver: VMA management
      ARM: OMAP: IOMMU driver: OMAP2 specific
      ARM: OMAP: Introduce MMU class

 arch/arm/mach-omap2/iommu_arch.c            |  331 +++++++++++++++++
 arch/arm/plat-omap/include/mach/iommu.h     |  118 ++++++
 arch/arm/plat-omap/include/mach/iommu2.h    |  102 ++++++
 arch/arm/plat-omap/include/mach/mmu-class.h |   32 ++
 arch/arm/plat-omap/iommu.c                  |  510 +++++++++++++++++++++++++++
 arch/arm/plat-omap/iommu_mmap.c             |  127 +++++++
 arch/arm/plat-omap/mmu-class.c              |  213 +++++++++++
 arch/arm/plat-omap/proc-iommu.S             |   33 ++
 8 files changed, 1466 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/iommu_arch.c
 create mode 100644 arch/arm/plat-omap/include/mach/iommu.h
 create mode 100644 arch/arm/plat-omap/include/mach/iommu2.h
 create mode 100644 arch/arm/plat-omap/include/mach/mmu-class.h
 create mode 100644 arch/arm/plat-omap/iommu.c
 create mode 100644 arch/arm/plat-omap/iommu_mmap.c
 create mode 100644 arch/arm/plat-omap/mmu-class.c
 create mode 100644 arch/arm/plat-omap/proc-iommu.S

