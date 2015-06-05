From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Fri, 5 Jun 2015 18:34:31 +0300
Message-ID: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

The ti-dma-crossbar driver in it's current form can work when it is used with
sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA available.
The DT bindings for sDMA has been done in a way that DMA users need to specify
the required DMA request number + 1 when they request for channel and the driver
stack has been written in this way also for sDMA.
Since right now we do not have the crossbar enabled we can still change the
compatible string to reflect the crossbar use. The TRM also refers the crossbars
in this way.

Regards,
Peter
---
Misael Lopez Cruz (2):
  dmaengine: ti-dma-crossbar: Make idr xbar instance-specific
  dmaengine: ti-dma-crossbar: Add support for eDMA xbar

Peter Ujfalusi (1):
  dmaengine: ti-dma-crossbar: Change the compatible string to
    ti,dra7-sdma-crossbar

 Documentation/devicetree/bindings/dma/dma.txt      |  2 +-
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  5 +--
 drivers/dma/ti-dma-crossbar.c                      | 37 ++++++++++++++++------
 3 files changed, 31 insertions(+), 13 deletions(-)

-- 
2.4.2
