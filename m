From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/9] dmaengine: ti drivers: enable COMPILE_TESTing
Date: Wed, 21 Sep 2016 13:26:28 +0300
Message-ID: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi,

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
  dmaengine: edma: Use enum for eDMA binding type (legacy vs TPCC)
  dmaengine: edma: Use correct type for of_find_property() third
    parameter
  dmaengine/ARM: omap-dma: Fix the DMAengine compile test on non OMAP
    configs
  dmaengine: ti-dma-crossbar: Correct type for of_find_property() third
    parameter
  dmaengine: ti-dma-crossbar: Use enum for crossbar type
  dmaengine: edma: enable COMPILE_TEST
  dmaengine: omap-dma: enable COMPILE_TEST
  dmaengine: ti-dma-crossbar: enable COMPILE_TEST

 drivers/dma/Kconfig           |  8 ++++----
 drivers/dma/edma.c            | 15 ++++++++++-----
 drivers/dma/ti-dma-crossbar.c | 12 +++++++-----
 include/linux/omap-dma.h      | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+), 14 deletions(-)

--
2.10.0
