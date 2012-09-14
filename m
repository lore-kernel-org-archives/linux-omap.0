From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V6 2/2] dmaengine: add helper function to request a slave DMA
 channel
Date: Fri, 14 Sep 2012 17:41:57 -0500
Message-ID: <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1347662517-4210-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently slave DMA channels are requested by calling dma_request_channel()
and requires DMA clients to pass various filter parameters to obtain the
appropriate channel.

With device-tree being used by architectures such as arm and the addition of
device-tree helper functions to extract the relevant DMA client information
from device-tree, add a new function to request a slave DMA channel using
device-tree. This function is currently a simple wrapper that calls the
device-tree of_dma_request_slave_channel() function.

Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/dmaengine.c   |   16 ++++++++++++++++
 include/linux/dmaengine.h |    6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3491654..9b466da 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -62,6 +62,7 @@
 #include <linux/rculist.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/of_dma.h>
 
 static DEFINE_MUTEX(dma_list_mutex);
 static DEFINE_IDR(dma_idr);
@@ -546,6 +547,21 @@ struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask, dma_filter_fn fn, v
 }
 EXPORT_SYMBOL_GPL(__dma_request_channel);
 
+/**
+ * dma_request_slave_channel - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ */
+struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
+{
+	/* If device-tree is present get slave info from here */
+	if (dev->of_node)
+		return of_dma_request_slave_channel(dev->of_node, name);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(dma_request_slave_channel);
+
 void dma_release_channel(struct dma_chan *chan)
 {
 	mutex_lock(&dma_list_mutex);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9c02a45..9500aa5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -973,6 +973,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
 enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
 void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask, dma_filter_fn fn, void *fn_param);
+struct dma_chan *dma_request_slave_channel(struct device *dev, char *name);
 void dma_release_channel(struct dma_chan *chan);
 #else
 static inline enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
@@ -987,6 +988,11 @@ static inline struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask,
 {
 	return NULL;
 }
+static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
+							 char *name)
+{
+	return NULL
+}
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
1.7.9.5
