From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/14] dmaengine: edma: Do not allocate memory for
 edma_rsv_info in case of DT boot
Date: Fri, 16 Oct 2015 10:18:06 +0300
Message-ID: <1444979892-31626-9-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The channel/slot reservation is not supported when booted with DT so there
is not need to allocate memory.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index e1b0e6864f27..c1b8bb09c221 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1926,12 +1926,6 @@ static int edma_of_parse_dt(struct device *dev, struct edma_soc_info *pdata)
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
