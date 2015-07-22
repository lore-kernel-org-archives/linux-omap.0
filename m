From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/2] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Wed, 22 Jul 2015 11:48:08 +0300
Message-ID: <1437554890-2088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Vinod,

Strange, for me the v2 series applied cleanly on top of rc1, but to be safe I
have generated this series on top of 4.2-rc3

Changes since v02:
- generated on top of 4.2-rc3

Changes since v01:
- Drop change in compatible for the crossbar driver and do the configuration
  based on the DT structure.

The ti-dma-crossbar driver in it's current form can work when it is used with
sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA available.
The sDMA driver expects to get the DMA request line with offset 1. The eDMA
stack does not need the offset.
The crosbbar itself is identical for sDMA and eDMA.
At probe time the driver will do a match to figure out which dma engine it is
connected to and based on that information it will configure the offset needed
by the DMA driver.

Regards,
Peter
---
Misael Lopez Cruz (1):
  dmaengine: ti-dma-crossbar: Make idr xbar instance-specific

Peter Ujfalusi (1):
  dmaengine: ti-dma-crossbar: Add support for eDMA

 drivers/dma/ti-dma-crossbar.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

-- 
2.4.5
