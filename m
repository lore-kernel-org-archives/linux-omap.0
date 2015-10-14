From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 00/24] dmaengine/ARM: Merge the edma drivers into one
Date: Wed, 14 Oct 2015 14:42:42 +0300
Message-ID: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v4:
- checkpatch errors/warnings/checks has been fixed in spot and not in a followup
  patch.
- Sekhar's Acked-by added to patches touching arch/arm/mach-davinci/
- Other comments for v4 has been addressed

Changes since v3:
- Separated the two (patch 10/11 in v2 patch 10 in v3) patch which got squashed
  by accident for v3
- Added Tony's Acked-by to patch 11 (for mach-oamp2 part)

Changes since v2:
- devm_kasprintf format string fixed
- Additional patch to enable dynamic paRAM slot usage when the channel mapping
  is supported by the eDMA module.
  On am335x we have 256 paRAM slots and 64 DMA channels, this means that we had
  64 slots 'locked away' all the time. The dynamic paRAM slot logic will allow
  us to use all 256 slots freely for any purpose.

Changes since v1:
- Convert edma platform device registration to use platform_device_register_full
- Moved the PM callback also to the dmaengine driver - missed in v1
- Commit message added to:
  ARM/dmaengine: edma: Remove limitation on the number of eDMA controllers
- New patch which reads the flag for the channel mapping support in one place

Cover letter:

with this series the edma two driver setup will be changed to have only one
driver to support eDMA3. The legacy edma interface will be removed and eDMA can
only be used via dmaengine API from this point on.
In order to do the merge the following improvements has been done:
- One driver instance per eDMA:
 - Any number of eDMA instances are supported (both legacy and DT boot)
- Not relying on global variables, arrays, etc
- Code simplification and optimizations in several places

This change will also help us to do bigger changes in the eDMA driver since,
since now we have only one driver to work with.

The series has been tested on:
da850-evm (OMAP-L138)
- with legacy and DT boot (both eDMA0 and eDMA1 is enabled)
- In code swapping the eDMA instances in legacy mode to make sure the second
  instance is handled correctly.

am335x-evmsk
- DT boot

I think this series could go via the dmaengine tree. Changes are trivial under
arch/arm/

Regards,
Peter
---
Peter Ujfalusi (24):
  ARM: common: edma: Fix channel parameter for irq callbacks
  ARM: common: edma: Remove unused functions
  dmaengine: edma: Simplify and optimize the edma_execute path
  ARM: davinci/common: Convert edma driver to handle one eDMA instance
    per driver
  ARM/dmaengine: edma: Move of_dma_controller_register to the dmaengine
    driver
  ARM: common: edma: Internal API to use pointer to 'struct edma'
  ARM/dmaengine: edma: Public API to use private struct pointer
  ARM/dmaengine: edma: Remove limitation on the number of eDMA
    controllers
  ARM: davinci: Use platform_device_register_full() to create pdev for
    eDMA
  ARM: davinci: Add dma_mask to eDMA devices
  ARM/dmaengine: edma: Merge the two drivers under drivers/dma/
  dmaengine: edma: Allocate memory dynamically for bitmaps and
    structures
  dmaengine: edma: Use devm_kcalloc when possible
  dmaengine: edma: Cleanup regarding the use of dev around the code
  dmaengine: edma: Use dev_dbg instead pr_debug
  dmaengine: edma: Use the edma_write_slot instead open coded
    memcpy_toio
  dmaengine: edma: Print warning when linking slots from different eDMA
  dmaengine: edma: Consolidate the comments for functions
  dmaengine: edma: Simplify the interrupt handling
  dmaengine: edma: Move the pending error check into helper function
  dmaengine: edma: Simplify and optimize ccerr interrupt handler
  dmaengine: edma: Read channel mapping support only once from HW
  dmaengine: edma: Rename bitfields for slot and channel usage tracking
  dmaengine: edma: Dynamic paRAM slot handling if HW supports it

 arch/arm/Kconfig                      |    1 -
 arch/arm/common/Kconfig               |    3 -
 arch/arm/common/Makefile              |    1 -
 arch/arm/common/edma.c                | 1876 ---------------------------------
 arch/arm/mach-davinci/devices-da8xx.c |  122 +--
 arch/arm/mach-davinci/dm355.c         |   40 +-
 arch/arm/mach-davinci/dm365.c         |   25 +-
 arch/arm/mach-davinci/dm644x.c        |   40 +-
 arch/arm/mach-davinci/dm646x.c        |   44 +-
 arch/arm/mach-omap2/Kconfig           |    1 -
 drivers/dma/Kconfig                   |    1 -
 drivers/dma/edma.c                    | 1631 ++++++++++++++++++++++++----
 include/linux/platform_data/edma.h    |  101 --
 13 files changed, 1566 insertions(+), 2320 deletions(-)
 delete mode 100644 arch/arm/common/edma.c

-- 
2.6.1
