From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/13] dmaengine: edma: Merge the of parsing functions
Date: Wed, 14 Oct 2015 16:12:20 +0300
Message-ID: <1444828344-21378-10-git-send-email-peter.ujfalusi@ti.com>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Instead of nesting functions just merge them since the resulting function
is still small and readable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index f511684f83a2..421c4fd67235 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1915,31 +1915,23 @@ static int edma_xbar_event_map(struct device *dev, struct edma_soc_info *pdata,
 	return 0;
 }
 
-static int edma_of_parse_dt(struct device *dev, struct edma_soc_info *pdata)
-{
-	int ret = 0;
-	struct property *prop;
-	size_t sz;
-
-	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
-	if (prop)
-		ret = edma_xbar_event_map(dev, pdata, sz);
-
-	return ret;
-}
-
 static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev)
 {
 	struct edma_soc_info *info;
+	struct property *prop;
+	size_t sz;
 	int ret;
 
 	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	ret = edma_of_parse_dt(dev, info);
-	if (ret)
-		return ERR_PTR(ret);
+	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
+	if (prop) {
+		ret = edma_xbar_event_map(dev, info, sz);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return info;
 }
-- 
2.6.1
