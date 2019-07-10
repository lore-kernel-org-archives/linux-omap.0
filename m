From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [net-next] davinci_cpdma: don't cast dma_addr_t to pointer
Date: Wed, 10 Jul 2019 10:00:33 +0200
Message-ID: <20190710080106.24237-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dma_addr_t may be 64-bit wide on 32-bit architectures, so it is not
valid to cast between it and a pointer:

drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_si':
drivers/net/ethernet/ti/davinci_cpdma.c:1047:12: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_idle_submit_mapped':
drivers/net/ethernet/ti/davinci_cpdma.c:1114:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_chan_submit_mapped':
drivers/net/ethernet/ti/davinci_cpdma.c:1164:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

Solve this by using two separate members in 'struct submit_info'.
Since this avoids the use of the 'flag' member, the structure does
not even grow in typical configurations.

Fixes: 6670acacd59e ("net: ethernet: ti: davinci_cpdma: add dma mapped submit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 0ca2a1a254de..a65edd2770e6 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -138,8 +138,8 @@ struct submit_info {
 	struct cpdma_chan *chan;
 	int directed;
 	void *token;
-	void *data;
-	int flags;
+	void *data_virt;
+	dma_addr_t data_dma;
 	int len;
 };
 
@@ -1043,12 +1043,12 @@ static int cpdma_chan_submit_si(struct submit_info *si)
 	mode = CPDMA_DESC_OWNER | CPDMA_DESC_SOP | CPDMA_DESC_EOP;
 	cpdma_desc_to_port(chan, mode, si->directed);
 
-	if (si->flags & CPDMA_DMA_EXT_MAP) {
-		buffer = (dma_addr_t)si->data;
+	if (si->data_dma) {
+		buffer = si->data_dma;
 		dma_sync_single_for_device(ctlr->dev, buffer, len, chan->dir);
 		swlen |= CPDMA_DMA_EXT_MAP;
 	} else {
-		buffer = dma_map_single(ctlr->dev, si->data, len, chan->dir);
+		buffer = dma_map_single(ctlr->dev, si->data_virt, len, chan->dir);
 		ret = dma_mapping_error(ctlr->dev, buffer);
 		if (ret) {
 			cpdma_desc_free(ctlr->pool, desc, 1);
@@ -1086,10 +1086,10 @@ int cpdma_chan_idle_submit(struct cpdma_chan *chan, void *token, void *data,
 
 	si.chan = chan;
 	si.token = token;
-	si.data = data;
+	si.data_virt = data;
+	si.data_dma = 0;
 	si.len = len;
 	si.directed = directed;
-	si.flags = 0;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	if (chan->state == CPDMA_STATE_TEARDOWN) {
@@ -1111,10 +1111,10 @@ int cpdma_chan_idle_submit_mapped(struct cpdma_chan *chan, void *token,
 
 	si.chan = chan;
 	si.token = token;
-	si.data = (void *)data;
+	si.data_virt = NULL;
+	si.data_dma = data;
 	si.len = len;
 	si.directed = directed;
-	si.flags = CPDMA_DMA_EXT_MAP;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	if (chan->state == CPDMA_STATE_TEARDOWN) {
@@ -1136,10 +1136,10 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 
 	si.chan = chan;
 	si.token = token;
-	si.data = data;
+	si.data_virt = data;
+	si.data_dma = 0;
 	si.len = len;
 	si.directed = directed;
-	si.flags = 0;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	if (chan->state != CPDMA_STATE_ACTIVE) {
@@ -1161,10 +1161,10 @@ int cpdma_chan_submit_mapped(struct cpdma_chan *chan, void *token,
 
 	si.chan = chan;
 	si.token = token;
-	si.data = (void *)data;
+	si.data_virt = NULL;
+	si.data_dma = data;
 	si.len = len;
 	si.directed = directed;
-	si.flags = CPDMA_DMA_EXT_MAP;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	if (chan->state != CPDMA_STATE_ACTIVE) {
-- 
2.20.0
