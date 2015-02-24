From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/6] dmaengine: omap-dma: Remove mapping between virtual channels and requests
Date: Tue, 24 Feb 2015 16:21:22 +0200
Message-ID: <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

Do not direct map the virtual channels to sDMA request number. When the
sDMA is behind of a crossbar this direct mapping can cause situations when
certain channel can not be requested since the crossbar request number
will no longer match with the sDMA request line.
The direct mapping for virtual channels with HW request lines will make it
harder to implement MEM_TO_MEM mode for the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 7def31c919f4..1d759b81e1be 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -593,6 +593,7 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	omap_free_dma(c->dma_ch);
 
 	dev_dbg(od->ddev.dev, "freeing channel for %u\n", c->dma_sig);
+	c->dma_sig = 0;
 }
 
 static size_t omap_dma_sg_size(struct omap_sg *sg)
@@ -1049,7 +1050,6 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
 		return -ENOMEM;
 
 	c->reg_map = od->reg_map;
-	c->dma_sig = dma_sig;
 	c->vc.desc_free = omap_dma_desc_free;
 	vchan_init(&c->vc, &od->ddev);
 	INIT_LIST_HEAD(&c->node);
@@ -1219,10 +1219,14 @@ static struct platform_driver omap_dma_driver = {
 bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	if (chan->device->dev->driver == &omap_dma_driver.driver) {
+		struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 		struct omap_chan *c = to_omap_dma_chan(chan);
 		unsigned req = *(unsigned *)param;
 
-		return req == c->dma_sig;
+		if (req <= od->dma_requests) {
+			c->dma_sig = req;
+			return true;
+		}
 	}
 	return false;
 }
-- 
2.3.0
