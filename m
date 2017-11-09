From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 5/7] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Thu, 9 Nov 2017 10:15:29 +0100
Message-ID: <20171109091529.x3pqqvbiywj5aulo@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109091155.6a6azfvjarwvlfh2@lenoch>
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
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 / OMAP3
OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only into
OMAP3 specific DMA functions which turned out not to be so OMAP3 specific.
Therefore replace open coded timeout waiting for completion in OMAP3
functions with API call and merge those two implementations.

Note that currently the is no single DMA user, so this change is basically
no-op. Those interested will have to find DMA configuration in the
linux-omap.git history.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v3: new patch

 drivers/mtd/onenand/omap2.c | 165 +++-----------------------------------------
 1 file changed, 10 insertions(+), 155 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 883993bbe40b..5760e40be008 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -289,9 +289,7 @@ static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
-
-static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
+static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 					unsigned char *buffer, int offset,
 					size_t count)
 {
@@ -299,10 +297,9 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
-	unsigned long timeout;
+	unsigned long t;
 	void *buf = (void *)buffer;
 	size_t xtra;
-	volatile unsigned *done;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
@@ -349,15 +346,11 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	reinit_completion(&c->dma_done);
 	omap_start_dma(c->dma_channel);
 
-	timeout = jiffies + msecs_to_jiffies(20);
-	done = &c->dma_done.done;
-	while (time_before(jiffies, timeout))
-		if (*done)
-			break;
+	t = wait_for_completion_io_timeout(&c->dma_done, msecs_to_jiffies(20));
 
 	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
 
-	if (!*done) {
+	if (!t) {
 		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
 		goto out_copy;
 	}
@@ -369,7 +362,7 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	return 0;
 }
 
-static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
+static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 					 const unsigned char *buffer,
 					 int offset, size_t count)
 {
@@ -377,9 +370,8 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
-	unsigned long timeout;
+	unsigned long t;
 	void *buf = (void *)buffer;
-	volatile unsigned *done;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
@@ -420,15 +412,11 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	reinit_completion(&c->dma_done);
 	omap_start_dma(c->dma_channel);
 
-	timeout = jiffies + msecs_to_jiffies(20);
-	done = &c->dma_done.done;
-	while (time_before(jiffies, timeout))
-		if (*done)
-			break;
+	t = wait_for_completion_io_timeout(&c->dma_done, msecs_to_jiffies(20));
 
 	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
 
-	if (!*done) {
+	if (!t) {
 		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
 		goto out_copy;
 	}
@@ -440,134 +428,6 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	return 0;
 }
 
-#else
-
-static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
-					unsigned char *buffer, int offset,
-					size_t count)
-{
-	return -ENOSYS;
-}
-
-static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
-					 const unsigned char *buffer,
-					 int offset, size_t count)
-{
-	return -ENOSYS;
-}
-
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(MULTI_OMAP2)
-
-static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
-					unsigned char *buffer, int offset,
-					size_t count)
-{
-	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
-	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
-
-	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	/* DMA is not used.  Revisit PM requirements before enabling it. */
-	if (1 || (c->dma_channel < 0) ||
-	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
-	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
-		memcpy(buffer, (__force void *)(this->base + bram_offset),
-		       count);
-		return 0;
-	}
-
-	dma_src = c->phys_base + bram_offset;
-	dma_dst = dma_map_single(&c->pdev->dev, buffer, count,
-				 DMA_FROM_DEVICE);
-	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		return -1;
-	}
-
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
-	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
-
-	return 0;
-}
-
-static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
-					 const unsigned char *buffer,
-					 int offset, size_t count)
-{
-	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
-	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
-
-	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	/* DMA is not used.  Revisit PM requirements before enabling it. */
-	if (1 || (c->dma_channel < 0) ||
-	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
-	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
-		memcpy((__force void *)(this->base + bram_offset), buffer,
-		       count);
-		return 0;
-	}
-
-	dma_src = dma_map_single(&c->pdev->dev, (void *) buffer, count,
-				 DMA_TO_DEVICE);
-	dma_dst = c->phys_base + bram_offset;
-	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		return -1;
-	}
-
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
-	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
-
-	return 0;
-}
-
-#else
-
-static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
-					unsigned char *buffer, int offset,
-					size_t count)
-{
-	return -ENOSYS;
-}
-
-static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
-					 const unsigned char *buffer,
-					 int offset, size_t count)
-{
-	return -ENOSYS;
-}
-
-#endif
-
 static struct platform_driver omap2_onenand_driver;
 
 static void omap2_onenand_shutdown(struct platform_device *pdev)
@@ -691,13 +551,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	this = &c->onenand;
 	if (c->dma_channel >= 0) {
 		this->wait = omap2_onenand_wait;
-		if (c->flags & ONENAND_IN_OMAP34XX) {
-			this->read_bufferram = omap3_onenand_read_bufferram;
-			this->write_bufferram = omap3_onenand_write_bufferram;
-		} else {
-			this->read_bufferram = omap2_onenand_read_bufferram;
-			this->write_bufferram = omap2_onenand_write_bufferram;
-		}
+		this->read_bufferram = omap2_onenand_read_bufferram;
+		this->write_bufferram = omap2_onenand_write_bufferram;
 	}
 
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
