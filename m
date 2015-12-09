From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 4.4 0/2] DT/dmaengine: edma: Convert 16bit arrays to 32bit
Date: Wed, 9 Dec 2015 10:18:09 +0200
Message-ID: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

Based on the discussion regarding to (convert am33xx to use the new eDMA
bindings):
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122117.html

This two patch will convert the new eDMA binding to not use 16bit arrays for
memcpy channel selection and for marking slots reserved.
The '/bits/ 16' seams to be causing confusion so it is probably better to just
use standard type for the arrays.

The new bindings for the eDMA is introduced for 4.4 and we do not have users of
it, which means that we can still change it w/o the risk of breaking anything
and we do not need to maintain the compatibility with 16bit arrays.

The changes in the eDMA driver is local to the DT parsing and should not
conflict with other changes (like the filter function mapping support). Hrm,
there might be trivial conflict in the include/linux/platform_data/edma.h with
the "dmaengine 'universal' API".

Tony, Arnd, Vinod: Can you agree on the practicalities on how these patches are
going to be handled? I would like to send the updated am33xx/am437x conversion
for 4.5 based on these changes.

Thanks and regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: edma: DT: Change memcpy channel array from 16bit to 32bit
    type
  dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit
    type

 Documentation/devicetree/bindings/dma/ti-edma.txt | 10 ++---
 drivers/dma/edma.c                                | 53 +++++++++++++++--------
 include/linux/platform_data/edma.h                |  2 +-
 3 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.6.3
