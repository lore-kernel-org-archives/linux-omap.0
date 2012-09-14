From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V5 2/2] dmaengine: add helper function to request a slave DMA channel
Date: Fri, 14 Sep 2012 10:18:43 -0500
Message-ID: <1347635923-30166-3-git-send-email-jon-hunter@ti.com>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50342 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab2INPTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 11:19:15 -0400
In-Reply-To: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

Currently slave DMA channels are requested by calling dma_request_channel()
and requires DMA clients to pass various filter parameters to obtain the
appropriate channel.

With device-tree being used by architectures such as arm and the addition of
device-tree helper functions to extract the relevant DMA client information
from device-tree, add a new function to request a slave DMA channel using
device-tree. This function is currently a simple wrapper that calls the
device-tree of_dma_request_slave_channel() function.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
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

