From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] dmaengine: ti: edma: Multicore usage related fixes
Date: Fri, 23 Aug 2019 15:56:13 +0300
Message-ID: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, robh+dt@kernel.org
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

When other cores want to use EDMA for their use cases Linux was not playing
nicely.
By design EDMA is supporting shared use with shadow regions. Linux is using
region0, others can be used by other cores.

In order to not break multicore shared usage of EDMA:
- do not reset paRAM slots which is not allocated for Linux (reserved paRAM
  slots)
- Only reset region0 access registers, do not touch other regions
- Add option for reserved channels which should not be used by Linux in a similar
  fashion as we already have for reserved paRAM slots.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: ti: edma: Do not reset reserved paRAM slots
  dmaengine: ti: edma: Only reset region0 access registers
  dmaengine: ti: edma: Use bitmap_set() instead of open coded
    edma_set_bits()
  dt-bindings: dma: ti-edma: Add option for reserved channel ranges
  dmaengine: ti: edma: Add support for handling reserved channels

 .../devicetree/bindings/dma/ti-edma.txt       |   5 +
 drivers/dma/ti/edma.c                         | 190 +++++++++++-------
 2 files changed, 123 insertions(+), 72 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
