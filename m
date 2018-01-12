From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 08/14] mtd: onenand: omap2: Simplify the DMA setup for
 various paths
Date: Fri, 12 Jan 2018 14:15:25 +0100
Message-ID: <20180112131525.GI13810@lenoch>
References: <20180112131105.GA13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180112131105.GA13810@lenoch>
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

We have 4 functions containing almost identical DMA setup code. Create one
function which can set up the DMA for both read and write and use this in
place for the setup code in the driver.
The new function will use wait_for_completion_io_timeout() and it will
figure out the best data_type to be used for the transfer instead of
hardwiring 32 or 16 bit data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

Changes in v6: None
Changes in v5: None
Changes in v4:
- new patch

Changes in v3: None
Changes in v2: None

 drivers/mtd/onenand/omap2.c | 109 ++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 64 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 0e7772e16d75..d22163271dc9 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -288,6 +288,33 @@ static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
 	return 0;
 }
 
+static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
+					     dma_addr_t src, dma_addr_t dst,
+					     size_t count)
+{
+	int data_type = __ffs((src | dst | count));
+
+	if (data_type > OMAP_DMA_DATA_TYPE_S32)
+		data_type = OMAP_DMA_DATA_TYPE_S32;
+
+	omap_set_dma_transfer_params(c->dma_channel, data_type,
+				     count / BIT(data_type), 1, 0, 0, 0);
+	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				src, 0, 0);
+	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dst, 0, 0);
+
+	reinit_completion(&c->dma_done);
+	omap_start_dma(c->dma_channel);
+	if (!wait_for_completion_io_timeout(&c->dma_done,
+					    msecs_to_jiffies(20))) {
+		omap_stop_dma(c->dma_channel);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
 
 static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
@@ -298,10 +325,9 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
-	unsigned long timeout;
 	void *buf = (void *)buffer;
 	size_t xtra;
-	volatile unsigned *done;
+	int ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
@@ -338,25 +364,10 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
 		goto out_copy;
 	}
 
-	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
-				     count >> 2, 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				dma_src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dma_dst, 0, 0);
-
-	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
-
-	timeout = jiffies + msecs_to_jiffies(20);
-	done = &c->dma_done.done;
-	while (time_before(jiffies, timeout))
-		if (*done)
-			break;
-
+	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
 	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
 
-	if (!*done) {
+	if (ret) {
 		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
 		goto out_copy;
 	}
@@ -376,9 +387,8 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
-	unsigned long timeout;
 	void *buf = (void *)buffer;
-	volatile unsigned *done;
+	int ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
@@ -409,25 +419,10 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
 		return -1;
 	}
 
-	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
-				     count >> 2, 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				dma_src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dma_dst, 0, 0);
-
-	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
-
-	timeout = jiffies + msecs_to_jiffies(20);
-	done = &c->dma_done.done;
-	while (time_before(jiffies, timeout))
-		if (*done)
-			break;
-
+	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
 	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
 
-	if (!*done) {
+	if (ret) {
 		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
 		goto out_copy;
 	}
@@ -466,7 +461,7 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	int bram_offset, ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	/* DMA is not used.  Revisit PM requirements before enabling it. */
@@ -488,20 +483,13 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 		return -1;
 	}
 
-	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
-				     count / 4, 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				dma_src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dma_dst, 0, 0);
-
-	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
-	wait_for_completion(&c->dma_done);
-
+	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
 	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
 
-	return 0;
+	if (ret)
+		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+
+	return ret;
 }
 
 static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
@@ -511,7 +499,7 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	int bram_offset, ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	/* DMA is not used.  Revisit PM requirements before enabling it. */
@@ -533,20 +521,13 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 		return -1;
 	}
 
-	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S16,
-				     count / 2, 1, 0, 0, 0);
-	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				dma_src, 0, 0);
-	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
-				 dma_dst, 0, 0);
-
-	reinit_completion(&c->dma_done);
-	omap_start_dma(c->dma_channel);
-	wait_for_completion(&c->dma_done);
-
+	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
 	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
 
-	return 0;
+	if (ret)
+		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+
+	return ret;
 }
 
 #else
-- 
2.15.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
