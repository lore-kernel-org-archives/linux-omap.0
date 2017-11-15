From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v5 10/16] mtd: onenand: omap2: Convert to use dmaengine for
 memcpy
Date: Wed, 15 Nov 2017 17:33:33 +0100
Message-ID: <20171115163333.n2dlvcqsf6jjkctw@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171115162306.2o2w2yrf7wucroxd@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Do not use the legacy and deprecated omap-dma interface for setting up the
memcpy.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---

Changes in v5: None
Changes in v4:
- new patch

Changes in v3: None
Changes in v2: None

 drivers/mtd/onenand/omap2.c | 80 +++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 36314124488d..c9ff67100ef4 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
@@ -39,8 +40,6 @@
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
-#include <linux/omap-dma.h>
-
 #define DRIVER_NAME "omap2-onenand"
 
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
@@ -55,17 +54,15 @@ struct omap2_onenand {
 	struct onenand_chip onenand;
 	struct completion irq_done;
 	struct completion dma_done;
-	int dma_channel;
+	struct dma_chan *dma_chan;
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
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
@@ -292,23 +289,31 @@ static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
 					     dma_addr_t src, dma_addr_t dst,
 					     size_t count)
 {
-	int data_type = __ffs((src | dst | count));
+	struct dma_async_tx_descriptor *tx;
+	dma_cookie_t cookie;
 
-	if (data_type > OMAP_DMA_DATA_TYPE_S32)
-		data_type = OMAP_DMA_DATA_TYPE_S32;
-
-	omap_set_dma_transfer_params(c->dma_channel, data_type,
-				     count / BIT(data_type), 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dst, 0, 0);
+	tx = dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count, 0);
+	if (!tx) {
+		dev_err(&c->pdev->dev, "Failed to prepare DMA memcpy\n");
+		return -EIO;
+	}
 
 	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
+
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
 	if (!wait_for_completion_io_timeout(&c->dma_done,
 					    msecs_to_jiffies(20))) {
-		omap_stop_dma(c->dma_channel);
+		dmaengine_terminate_sync(c->dma_chan);
 		return -ETIMEDOUT;
 	}
 
@@ -468,8 +473,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	c->flags = pdata->flags;
 	c->gpmc_cs = pdata->cs;
 	c->gpio_irq = pdata->gpio_irq;
-	c->dma_channel = pdata->dma_channel;
-	if (c->dma_channel < 0) {
+	if (pdata->dma_channel < 0) {
 		/* if -1, don't use DMA */
 		c->gpio_irq = 0;
 	}
@@ -521,25 +525,17 @@ static int omap2_onenand_probe(struct platform_device *pdev)
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
@@ -553,7 +549,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	mtd_set_of_node(&c->mtd, pdata->of_node);
 
 	this = &c->onenand;
-	if (c->dma_channel >= 0) {
+	if (c->dma_chan) {
 		this->wait = omap2_onenand_wait;
 		this->read_bufferram = omap2_onenand_read_bufferram;
 		this->write_bufferram = omap2_onenand_write_bufferram;
@@ -573,8 +569,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 err_release_onenand:
 	onenand_release(&c->mtd);
 err_release_dma:
-	if (c->dma_channel != -1)
-		omap_free_dma(c->dma_channel);
+	if (c->dma_chan)
+		dma_release_channel(c->dma_chan);
 	if (c->gpio_irq)
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
@@ -595,8 +591,8 @@ static int omap2_onenand_remove(struct platform_device *pdev)
 	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
 
 	onenand_release(&c->mtd);
-	if (c->dma_channel != -1)
-		omap_free_dma(c->dma_channel);
+	if (c->dma_chan)
+		dma_release_channel(c->dma_chan);
 	omap2_onenand_shutdown(pdev);
 	if (c->gpio_irq) {
 		free_irq(gpio_to_irq(c->gpio_irq), c);
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
