From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/8] dmaengine/dra7x: DMA router (crossbar support)
Date: Wed, 8 Apr 2015 16:14:44 +0300
Message-ID: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Hi,

Vinod: is it OK if I send the Documnetation/dmanegine/ update a bit later when
we agree on what form it should be?

Changes since v3:
- Comments from Russell:
 - Warnings removed in case of non DT boot when taking the DMA request number
 - Reduced the number of channels presented to DMAengine
 - removed the dma_sig parameter from omap_dma_chan_init()
- Comments from Arnd:
 - dma-device property renamed to dma-masters
 - Allow list of phandes in dma-masters

Changes since v2:
- not using regmap for the TI crossbar driver.

Changes since v1:
- Comments from Russell King and  Paul Bolle addressed:
 - Use the added defined in the omap-dma changes
 - MODULE_* removed from the ti-dma-crossbar driver.
- DMA router documentation: do not limit the #dma-cells to be the same as the
  dma controller's #dma-cells. It might be possible to have a router which needs
  more information than the DMA controller (direct request pairing for example)
- Use defines in the ti-dma-crossbar driver
- Binding document for the ti-dma-crossbar driver

Intro mail from v1:

The series adds support for DMA router type of devices. They are used in SoCs
which has more peripherals with DMA request lines than the DMA controller can
handle.
The router itself is not part of the DMA controller and it's operation should be
transparent (as it is in the HW) for the SW stack.

This series takes into accound the comments Sricharan received for his version
of the crossbar driver:
https://lkml.org/lkml/2014/3/7/199

This implementation is not tied to any DMA driver so it is possible to use the
framework by other vendors, also ACPI version of binding can be easy enough to
be added.

Regards,
Peter
---
Peter Ujfalusi (8):
  dmaengine: of_dma: Support for DMA routers
  Documentation: devicetree: dma: Binding documentation for TI DMA
    crossbar
  dmaengine: Add driver for TI DMA crossbar on DRA7x
  dmaengine: omap-dma: Use defines for dma channels and request count
  dmaengine: omap-dma: Take DMA request number from DT if it is
    available
  dmaengine: omap-dma: Remove mapping between virtual channels and
    requests
  dmaengine: omap-dma: Reduce the number of virtual channels
  ARM: DTS: dra7x: Integrate sDMA crossbar

 Documentation/devicetree/bindings/dma/dma.txt      |  28 ++++
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  52 ++++++
 arch/arm/boot/dts/dra7.dtsi                        |  57 ++++---
 drivers/dma/Kconfig                                |   4 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/dmaengine.c                            |   7 +
 drivers/dma/of-dma.c                               |  86 ++++++++++
 drivers/dma/omap-dma.c                             |  29 +++-
 drivers/dma/ti-dma-crossbar.c                      | 185 +++++++++++++++++++++
 include/linux/dmaengine.h                          |  17 ++
 include/linux/of_dma.h                             |  21 +++
 11 files changed, 457 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
 create mode 100644 drivers/dma/ti-dma-crossbar.c

-- 
2.3.5
