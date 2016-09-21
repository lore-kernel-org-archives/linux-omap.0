From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/9] dmaengine: ti drivers: enable COMPILE_TESTing
Date: Wed, 21 Sep 2016 15:41:26 +0300
Message-ID: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v2:
- Instead of converting to use enum for the of_device_id data parameter the two
  patch for edma and ti-dma-crossbar is using pointers to u32 variables to make
  sure that the code compile (and in theory work) on all architectures.
- fixed issue in the ti-dma-crossbar driver I have made with the enum change to
  not handle the DMA offset parameters correctly.

Changes since v1:
- added the compiler warning message to ti-dma-crossbar enum type patch
- moved the Kconfig patches at the end of the seris

The following series will enable unconditional COMPILE_TEST coverage for the
following drivers: omap-dma, edma and ti-dma-crossbar

The series includes fixes noticed when compiling the drivers for x86_64 and
aarch64.

Replaces the patch Vinod sent to enable partial compile testing for omap-dma:
http://www.spinics.net/lists/dmaengine/msg11025.html

Regards,
Peter
---
Peter Ujfalusi (9):
  dmaengine: edma: Add missing MODULE_DEVICE_TABLE() for of_device_id
    structs
  dmaengine: edma: Fix of_device_id data parameter usage (legacy vs
    TPCC)
  dmaengine: edma: Use correct type for of_find_property() third
    parameter
  dmaengine/ARM: omap-dma: Fix the DMAengine compile test on non OMAP
    configs
  dmaengine: ti-dma-crossbar: Correct type for of_find_property() third
    parameter
  dmaengine: ti-dma-crossbar: Fix of_device_id data parameter usage
  dmaengine: edma: enable COMPILE_TEST
  dmaengine: omap-dma: enable COMPILE_TEST
  dmaengine: ti-dma-crossbar: enable COMPILE_TEST

 drivers/dma/Kconfig           |  8 ++++----
 drivers/dma/edma.c            | 16 +++++++++++-----
 drivers/dma/ti-dma-crossbar.c | 30 +++++++++++++++++++-----------
 include/linux/omap-dma.h      | 19 +++++++++++++++++++
 4 files changed, 53 insertions(+), 20 deletions(-)

--
2.10.0
