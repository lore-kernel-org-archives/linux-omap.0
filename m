From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mtd: onenand: omap2: Convert to use dmaengine for memcpy
Date: Tue, 15 Dec 2015 09:37:38 +0200
Message-ID: <1450165058-2977-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kyungmin.park@samsung.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Do not use the legacy and deprecated omap-dma interface for setting up the
memcpy.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

this patch depends on the dma setup simplification patch:
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122375.html

We could try to enable the DMA memcpy without condition I believe, but I have
decided to not do it since the code had comments regarding to PM (?) when using
DMA.

Regards,
Peter


 drivers/mtd/onenand/omap2.c | 84 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 58576c9babb0..b747217d5e73 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
@@ -40,8 +41,6 @@
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
 
-#include <linux/omap-dma.h>
-
 #define DRIVER_NAME "omap2-onenand"
 
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
@@ -56,18 +55,16 @@ struct omap2_onenand {
 	struct onenand_chip onenand;
 	struct completion irq_done;
 	struct completion dma_done;
-	int dma_channel;
+	struct dma_chan *dma_chan;
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
 	struct regulator *regulator;
 	u8 flags;
 };
 
-static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
+static void omap2_onenand_dma_complete_func(void *completion)
 {
-	struct omap2_onenand *c = data;
-
-	complete(&c->dma_done);
+	complete(completion);
 }
 
 static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
@@ -295,23 +292,33 @@ static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
 					     dma_addr_t src, dma_addr_t dst,
 					     size_t count)
 {
-	int data_type = __ffs((src | dst | count));
+	struct dma_device *dma_dev = c->dma_chan->device;
+	struct dma_async_tx_descriptor *tx = NULL;
+	dma_cookie_t cookie;
 
-	if (data_type > OMAP_DMA_DATA_TYPE_S32)
-		data_type = OMAP_DMA_DATA_TYPE_S32;
-
-	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
-				     count / BIT(data_type), 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dst, 0, 0);
+	tx = dma_dev->device_prep_dma_memcpy(c->dma_chan, dst, src, count, 0);
+	if (!tx) {
+		dev_err(&c->pdev->dev, "Failed to prepare DMA memcpy\n");
+		return -EIO;
+	}
 
 	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
+	tx->callback = omap2_onenand_dma_complete_func;
+	tx->callback_param = &c->dma_done;
+
+	cookie = tx->tx_submit(tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(&c->pdev->dev, "Failed to do DMA tx_submit\n");
+		return -EIO;
+	}
+
+	dma_async_issue_pending(c->dma_chan);
+
 	if (wait_for_completion_timeout(&c->dma_done, msecs_to_jiffies(20)))
 		return -ETIMEDOUT;
 
+	dmaengine_terminate_all(c->dma_chan);
+
 	return 0;
 }
 
@@ -465,7 +472,7 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	/* DMA is not used.  Revisit PM requirements before enabling it. */
-	if (1 || (c->dma_channel < 0) ||
+	if (1 || !c->dma_chan ||
 	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
 	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
 		memcpy(buffer, (__force void *)(this->base + bram_offset),
@@ -503,7 +510,7 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	/* DMA is not used.  Revisit PM requirements before enabling it. */
-	if (1 || (c->dma_channel < 0) ||
+	if (1 || !c->dma_chan ||
 	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
 	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
 		memcpy((__force void *)(this->base + bram_offset), buffer,
@@ -608,8 +615,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	c->flags = pdata->flags;
 	c->gpmc_cs = pdata->cs;
 	c->gpio_irq = pdata->gpio_irq;
-	c->dma_channel = pdata->dma_channel;
-	if (c->dma_channel < 0) {
+	if (pdata->dma_channel < 0) {
 		/* if -1, don't use DMA */
 		c->gpio_irq = 0;
 	}
@@ -661,25 +667,17 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 		goto err_release_gpio;
 	}
 
-	if (c->dma_channel >= 0) {
-		r = omap_request_dma(0, pdev->dev.driver->name,
-				     omap2_onenand_dma_cb, (void *) c,
-				     &c->dma_channel);
-		if (r == 0) {
-			omap_set_dma_write_mode(c->dma_channel,
-						OMAP_DMA_WRITE_NON_POSTED);
-			omap_set_dma_src_data_pack(c->dma_channel, 1);
-			omap_set_dma_src_burst_mode(c->dma_channel,
-						    OMAP_DMA_DATA_BURST_8);
-			omap_set_dma_dest_data_pack(c->dma_channel, 1);
-			omap_set_dma_dest_burst_mode(c->dma_channel,
-						     OMAP_DMA_DATA_BURST_8);
-		} else {
+	if (pdata->dma_channel >= 0) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_MEMCPY, mask);
+
+		c->dma_chan = dma_request_channel(mask, NULL, NULL);
+		if (!c->dma_chan)
 			dev_info(&pdev->dev,
 				 "failed to allocate DMA for OneNAND, "
 				 "using PIO instead\n");
-			c->dma_channel = -1;
-		}
 	}
 
 	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
@@ -693,7 +691,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	mtd_set_of_node(&c->mtd, pdata->of_node);
 
 	this = &c->onenand;
-	if (c->dma_channel >= 0) {
+	if (c->dma_chan) {
 		this->wait = omap2_onenand_wait;
 		if (c->flags & ONENAND_IN_OMAP34XX) {
 			this->read_bufferram = omap3_onenand_read_bufferram;
@@ -735,8 +733,8 @@ err_release_onenand:
 err_release_regulator:
 	regulator_put(c->regulator);
 err_release_dma:
-	if (c->dma_channel != -1)
-		omap_free_dma(c->dma_channel);
+	if (c->dma_chan)
+		dma_release_channel(c->dma_chan);
 	if (c->gpio_irq)
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
@@ -758,8 +756,8 @@ static int omap2_onenand_remove(struct platform_device *pdev)
 
 	onenand_release(&c->mtd);
 	regulator_put(c->regulator);
-	if (c->dma_channel != -1)
-		omap_free_dma(c->dma_channel);
+	if (c->dma_chan)
+		dma_release_channel(c->dma_chan);
 	omap2_onenand_shutdown(pdev);
 	if (c->gpio_irq) {
 		free_irq(gpio_to_irq(c->gpio_irq), c);
-- 
2.6.4
