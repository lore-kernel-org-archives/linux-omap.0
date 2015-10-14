From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/13] dmaengine: edma: Do not allocate memory for edma_rsv_info in case of DT boot
Date: Wed, 14 Oct 2015 16:12:19 +0300
Message-ID: <1444828344-21378-9-git-send-email-peter.ujfalusi@ti.com>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

The channel/slot reservation is not supported when booted with DT so there
is not need to allocate memory.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 53188b9383a6..f511684f83a2 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1920,12 +1920,6 @@ static int edma_of_parse_dt(struct device *dev, struct edma_soc_info *pdata)
 	int ret = 0;
 	struct property *prop;
 	size_t sz;
-	struct edma_rsv_info *rsv_info;
-
-	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
-	if (!rsv_info)
-		return -ENOMEM;
-	pdata->rsv = rsv_info;
 
 	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
 	if (prop)
-- 
2.6.1
