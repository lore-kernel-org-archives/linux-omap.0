From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/7] dmaengine/dra7x: DMA router (crossbar support)
Date: Wed, 11 Mar 2015 15:23:23 +0200
Message-ID: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41137 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbbCKNYO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 09:24:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

Hi,

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
Peter Ujfalusi (7):
  dmaengine: of_dma: Support for DMA routers
  Documentation: devicetree: dma: Binding documentation for TI DMA
    crossbar
  dmaengine: Add driver for TI DMA crossbar on DRA7x
  dmaengine: omap-dma: Use defines for dma channels and request count
  dmaengine: omap-dma: Take DMA request number from DT if it is
    available
  dmaengine: omap-dma: Remove mapping between virtual channels and
    requests
  ARM: DTS: dra7x: Integrate sDMA crossbar

 Documentation/devicetree/bindings/dma/dma.txt      |  28 +++
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  52 ++++++
 arch/arm/boot/dts/dra7.dtsi                        |  57 ++++---
 drivers/dma/Kconfig                                |   4 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/dmaengine.c                            |   7 +
 drivers/dma/of-dma.c                               |  92 ++++++++++
 drivers/dma/omap-dma.c                             |  25 ++-
 drivers/dma/ti-dma-crossbar.c                      | 190 +++++++++++++++++++++
 include/linux/dmaengine.h                          |  17 ++
 include/linux/of_dma.h                             |  21 +++
 11 files changed, 466 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
 create mode 100644 drivers/dma/ti-dma-crossbar.c

-- 
2.3.0

