From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/9] dmaengine: ti drivers: enable COMPILE_TESTing
Date: Fri, 16 Sep 2016 11:33:15 +0300
Message-ID: <20160916083324.29133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, tony@atomide.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

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
  dmaengine: edma: enable COMPILE_TEST
  dmaengine/ARM: omap-dma: Fix the DMAengine compile test on non OMAP
    configs
  dmaengine: omap-dma: enable COMPILE_TEST
  dmaengine: ti-dma-crossbar: Correct type for of_find_property() third
    parameter
  dmaengine: ti-dma-crossbar: Use enum for crossbar type
  dmaengine: ti-dma-crossbar: enable COMPILE_TEST

 drivers/dma/Kconfig           |  8 ++++----
 drivers/dma/edma.c            | 15 ++++++++++-----
 drivers/dma/ti-dma-crossbar.c | 12 +++++++-----
 include/linux/omap-dma.h      | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+), 14 deletions(-)

--
2.10.0
