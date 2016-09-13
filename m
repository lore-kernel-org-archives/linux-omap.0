From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Correct type2 descriptor's member types
Date: Tue, 13 Sep 2016 10:58:43 +0300
Message-ID: <20160913075843.26691-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, linux@armlinux.org.uk
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The type of CDEI, CSEI, CDFI and CSFI is signed.
This did not caused issue so far as we only use unsigned values.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index aef52011d7c0..1b7f5f32bf74 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -71,10 +71,10 @@ struct omap_type2_desc {
 	uint32_t addr; /* src or dst */
 	uint16_t fn;
 	uint16_t cicr;
-	uint16_t cdei;
-	uint16_t csei;
-	uint32_t cdfi;
-	uint32_t csfi;
+	int16_t cdei;
+	int16_t csei;
+	int32_t cdfi;
+	int32_t csfi;
 } __packed;
 
 struct omap_sg {
-- 
2.10.0
