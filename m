From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 00/15] tidspbridge driver MMU-related cleanups
Date: Wed, 19 Sep 2012 14:06:48 +0200
Message-ID: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35800 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2ISMGa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Hello,

Here's the second version of my tidspbridge MMU-related cleanup patches. The
first version has been sent privately only, don't try to search the mailing
list archive for it :-)

Replacing hw/hw_mmu.c and part of core/tiomap3430.c with generic IOMMU calls
should be less difficult now. Anyone would like to give it a try?

Laurent Pinchart (14):
  tidspbridge: hw_mmu: Reorder functions to avoid forward declarations
  tidspbridge: hw_mmu: Removed unused functions
  tidspbridge: tiomap3430: Reorder functions to avoid forward
    declarations
  tidspbridge: tiomap3430: Remove unneeded dev_context local variables
  tidspbridge: tiomap3430: Factor out common page release code
  tidspbridge: tiomap3430: Remove ul_ prefix
  tidspbridge: tiomap3430: Remove unneeded local variables
  tidspbridge: Fix VM_PFNMAP mapping
  tidspbridge: Remove unused hw_mmu_map_attrs_t::donotlockmpupage field
  arm: omap: iommu: Include required headers in iommu.h and iopgtable.h
  tidspbridge: Use constants defined in IOMMU platform headers
  tidspbridge: Simplify pte_update and mem_map_vmalloc functions
  tidspbridge: Use correct types to describe physical, MPU, DSP
    addresses
  tidspbridge: Replace hw_mmu_map_attrs_t structure with a prot
    bitfield

Omar Ramirez Luna (1):
  ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected

 arch/arm/plat-omap/include/plat/iommu.h            |    6 +
 arch/arm/plat-omap/include/plat/iopgtable.h        |    2 +
 drivers/staging/tidspbridge/core/io_sm.c           |    7 +-
 drivers/staging/tidspbridge/core/tiomap3430.c      | 1484 +++++++++-----------
 drivers/staging/tidspbridge/core/tiomap_io.c       |    2 +-
 drivers/staging/tidspbridge/core/ue_deh.c          |   21 +-
 drivers/staging/tidspbridge/hw/hw_defs.h           |   22 -
 drivers/staging/tidspbridge/hw/hw_mmu.c            |  332 ++----
 drivers/staging/tidspbridge/hw/hw_mmu.h            |   67 +-
 .../staging/tidspbridge/include/dspbridge/drv.h    |    1 +
 .../tidspbridge/include/dspbridge/dspdefs.h        |   27 +-
 .../tidspbridge/include/dspbridge/dspioctl.h       |   25 +
 drivers/staging/tidspbridge/rmgr/proc.c            |  119 +-
 13 files changed, 899 insertions(+), 1216 deletions(-)

-- 
Regards,

Laurent Pinchart

