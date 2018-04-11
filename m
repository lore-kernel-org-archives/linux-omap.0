From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic with
 OneNAND on OMAP3 (DM3730) device GTA04A5
Date: Wed, 11 Apr 2018 11:12:24 +0200
Message-ID: <20180411091224.GA24153@lenoch>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <20180411065836.7e1bfc3f@aktux>
 <20180411062607.GA9179@lenoch>
 <20180411091528.4e954c32@bbrezillon>
 <20180411073655.GA18273@lenoch>
 <20180411100806.3c09bafc@bbrezillon>
 <20180411082746.GA20164@lenoch>
 <20180411105201.5f126e94@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990474AbeDKJM0W4TeO (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 1 other); Wed, 11 Apr 2018 11:12:26 +0200
Content-Disposition: inline
In-Reply-To: <20180411105201.5f126e94@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2018 at 10:52:01AM +0200, Boris Brezillon wrote:
> On Wed, 11 Apr 2018 10:27:46 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > On Wed, Apr 11, 2018 at 10:08:06AM +0200, Boris Brezillon wrote:
> > > On Wed, 11 Apr 2018 09:36:56 +0200
> > > Ladislav Michl <ladis@linux-mips.org> wrote:
> > >   
> > > > Hi Boris,
> > > > 
> > > > On Wed, Apr 11, 2018 at 09:15:28AM +0200, Boris Brezillon wrote:  
> > [...]
> > > > > Not sure this approach is safe on all archs: if the cache is VIVT or
> > > > > VIPT, you may have several entries pointing to the same phys page, and
> > > > > then, when dma_map_page() does its cache maintenance operations, it's
> > > > > only taking one of these entries into account.    
> > > > 
> > > > Hmm, I used the same approach Samsung OneNAND driver does since commit
> > > > dcf08227e964a53a2cb39130b74842c7dcb6adde.
> > > > Both TI OMAP3630 and Samsung S5PC110 are using Cortex-A8 which
> > > > is VIPT. In that case samsung's driver code has the same problem.
> > > >   
> > > > > In other parts of the MTD subsystem, we tend to not do DMA on buffers
> > > > > that have been vmalloc-ed.
> > > > > 
> > > > > You can do something like
> > > > > 
> > > > > 		if (virt_addr_valid(buf))
> > > > > 			/* Use DMA */
> > > > > 		else
> > > > > 			/*
> > > > > 			 * Do not use DMA, or use a bounce buffer
> > > > > 			 * allocated with kmalloc
> > > > > 			 */    
> > > > 
> > > > Okay, I'll use this approach then, but first I'd like to be sure above is
> > > > correct. Anyone?  
> > > 
> > > See this discussion [1]. The problem came up a few times already, so
> > > might find other threads describing why it's not safe.
> > > 
> > > [1]https://lists.linuxfoundation.org/pipermail/iommu/2016-March/016240.html  
> > 
> > Question was more likely whenever there might exist more that one mapping
> > of the same page.
> 
> I'm clearly not an expert, so I might be wrong, but I think a physical
> page can be both in the identity mapping and mapped in the vmalloc
> space. Now, is there a real risk that both ends are accessed in
> parallel thus making different cache entries pointing to the same phys
> page dirty, I'm not sure. Or maybe there are other corner case, but
> you'll have to ask Russell (or any other ARM expert) to get a clearer
> answer.

Thank you anyway. As DMA was disabled completely for all DT enabled boards
until 4.16 let's play safe and disable it for HIGHMEM case as you suggested.
Later, we might eventually use the same {read,write}_bufferram for both
OMAP and S5PC110.

> > But okay, I'll disable DMA for highmem. Patch will follow.
> > 
> > 	ladis

Andreas, Nikolaus, could you please test patch bellow? It is against
linux.git and should apply also against 4.16 once you modify path.

Thank you,
	ladis

--- >8 ---

From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers

dma_map_single doesn't get the proper DMA address for vmalloced area,
so disable DMA in this case.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
---
 drivers/mtd/nand/onenand/omap2.c | 105 +++++++++++--------------------
 1 file changed, 38 insertions(+), 67 deletions(-)

diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
index 9c159f0dd9a6..321137158ff3 100644
--- a/drivers/mtd/nand/onenand/omap2.c
+++ b/drivers/mtd/nand/onenand/omap2.c
@@ -375,56 +375,42 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 {
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	struct device *dev = &c->pdev->dev;
 	void *buf = (void *)buffer;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset, err;
 	size_t xtra;
-	int ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
-		goto out_copy;
-
-	/* panic_write() may be in an interrupt context */
-	if (in_interrupt() || oops_in_progress)
+	/*
+	 * If the buffer address is not DMA-able, len is not long enough to make
+	 * DMA transfers profitable or panic_write() may be in an interrupt
+	 * context fallback to PIO mode.
+	 */
+	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
+	    count < 384 || in_interrupt() || oops_in_progress )
 		goto out_copy;
 
-	if (buf >= high_memory) {
-		struct page *p1;
-
-		if (((size_t)buf & PAGE_MASK) !=
-		    ((size_t)(buf + count - 1) & PAGE_MASK))
-			goto out_copy;
-		p1 = vmalloc_to_page(buf);
-		if (!p1)
-			goto out_copy;
-		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
-	}
-
 	xtra = count & 3;
 	if (xtra) {
 		count -= xtra;
 		memcpy(buf + count, this->base + bram_offset + count, xtra);
 	}
 
+	dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
 	dma_src = c->phys_base + bram_offset;
-	dma_dst = dma_map_single(&c->pdev->dev, buf, count, DMA_FROM_DEVICE);
-	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		goto out_copy;
-	}
 
-	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
-	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
-
-	if (ret) {
-		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+	if (dma_mapping_error(dev, dma_dst)) {
+		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
 		goto out_copy;
 	}
 
-	return 0;
+	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
+	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
+	if (!err)
+		return 0;
+
+	dev_err(dev, "timeout waiting for DMA\n");
 
 out_copy:
 	memcpy(buf, this->base + bram_offset, count);
@@ -437,49 +423,34 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 {
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	struct device *dev = &c->pdev->dev;
 	void *buf = (void *)buffer;
-	int ret;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset, err;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
-		goto out_copy;
-
-	/* panic_write() may be in an interrupt context */
-	if (in_interrupt() || oops_in_progress)
+	/*
+	 * If the buffer address is not DMA-able, len is not long enough to make
+	 * DMA transfers profitable or panic_write() may be in an interrupt
+	 * context fallback to PIO mode.
+	 */
+	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
+	    count < 384 || in_interrupt() || oops_in_progress )
 		goto out_copy;
 
-	if (buf >= high_memory) {
-		struct page *p1;
-
-		if (((size_t)buf & PAGE_MASK) !=
-		    ((size_t)(buf + count - 1) & PAGE_MASK))
-			goto out_copy;
-		p1 = vmalloc_to_page(buf);
-		if (!p1)
-			goto out_copy;
-		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
-	}
-
-	dma_src = dma_map_single(&c->pdev->dev, buf, count, DMA_TO_DEVICE);
+	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
 	dma_dst = c->phys_base + bram_offset;
-	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		return -1;
-	}
-
-	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
-	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
-
-	if (ret) {
-		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+	if (dma_mapping_error(dev, dma_src)) {
+		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
 		goto out_copy;
 	}
 
-	return 0;
+	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
+	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
+	if (!err)
+		return 0;
+
+	dev_err(dev, "timeout waiting for DMA\n");
 
 out_copy:
 	memcpy(this->base + bram_offset, buf, count);
-- 
2.17.0
