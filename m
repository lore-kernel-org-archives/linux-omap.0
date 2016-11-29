From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/2] dmaengine: core/omap-dma: Support for port window
Date: Tue, 29 Nov 2016 16:23:40 +0200
Message-ID: <20161129142342.30949-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v2:
- the src/dst_port_window_size is in words, not in bytes (comment updated)
- correct the port_window based configuration in the omap-dma driver

Changes since v1:
- Make sure that the one frame covers the port_window (burst = port_window)
- added comment to explain the double indexed setup to cover the port_window
- Simplifications for the code mentioned by Russell and Vinod

Cover letter from v1:

as I'm trying to convert the remaining OMAP driver to use DMAengine instead of
the legacy omap-dma API I have encountered with the
drivers/usb/musb/tusb6010_omap.c driver.

The TUSB6010 is connected via NOR FLASH interface and it's register space is
mapped in the GPMC memory area. In OMAP SoCs we have support for external DMA
request lines and the TUSB6010 is using those as well.

With asynchronous access the DMA needs to read/write within the FIFO 'window' in
incremental address mode to read/write data.
The constant addressing only works in synchronous mode.

Since the DMA is driven by external DMA requests, the asynchronous mode is also
slave DMA operation, but currently the port window can not be 'swiped' as the
DMAengine only supports single register/address on the slave side.

This series will add support in dma_slave_config to specify the port side window
size and the second patch implements the setup needs in omap-dma driver for such
a transfer.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: dma_slave_config: add support for slave port window
  dmaengine: omap-dma: Support for slave devices with data port window

 drivers/dma/omap-dma.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dmaengine.h |  8 ++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.11.0.rc2
