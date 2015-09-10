From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/21] dmaengine/ARM: Merge the edma drivers into one
Date: Thu, 10 Sep 2015 11:37:29 +0300
Message-ID: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

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
Peter Ujfalusi (21):
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
  ARM: davinci: Add set dma_mask to eDMA devices
  ARM/dmaengine: edma: Merge the two drivers under drivers/dmaengine
  dmaengine: edma: Allocate memory dynamically for bitmaps and
    structures
  dmaengine: edma: Parameter alignment and long line fixes
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

 arch/arm/Kconfig                      |    1 -
 arch/arm/common/Kconfig               |    3 -
 arch/arm/common/Makefile              |    1 -
 arch/arm/common/edma.c                | 1876 ---------------------------------
 arch/arm/mach-davinci/devices-da8xx.c |  118 +--
 arch/arm/mach-davinci/dm355.c         |   27 +-
 arch/arm/mach-davinci/dm365.c         |   25 +-
 arch/arm/mach-davinci/dm644x.c        |   27 +-
 arch/arm/mach-davinci/dm646x.c        |   33 +-
 arch/arm/mach-omap2/Kconfig           |    1 -
 drivers/dma/Kconfig                   |    1 -
 drivers/dma/edma.c                    | 1518 +++++++++++++++++++++++---
 include/linux/platform_data/edma.h    |  101 --
 13 files changed, 1455 insertions(+), 2277 deletions(-)
 delete mode 100644 arch/arm/common/edma.c

-- 
2.5.1
