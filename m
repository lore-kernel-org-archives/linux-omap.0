From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic with
 OneNAND on OMAP3 (DM3730) device GTA04A5
Date: Wed, 11 Apr 2018 08:26:07 +0200
Message-ID: <20180411062607.GA9179@lenoch>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <20180411065836.7e1bfc3f@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990427AbeDKG0Igs2QH (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 1 other); Wed, 11 Apr 2018 08:26:08 +0200
Content-Disposition: inline
In-Reply-To: <20180411065836.7e1bfc3f@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Andreas,

On Wed, Apr 11, 2018 at 06:59:03AM +0200, Andreas Kemnade wrote:
> Hi Ladis,
> 
> On Tue, 10 Apr 2018 22:56:43 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > Hi Nikolaus,
> > 
> > On Tue, Apr 10, 2018 at 06:25:17PM +0200, H. Nikolaus Schaller wrote:
> > > Hi,
> > > we just started testing the v4.16 kernel and found the
> > > device no longer bootable (works with v4.15). It turned
> > > out that there was a harmful modification somewhere between
> > > v4.15.0 and v4.16-rc1.
> > > 
> > > A git bisect points to this patch:  
> > 
> > Well, that's a shame... However, this code is in production for several
> > months now, so could you, please put 'goto out_copy' if 'buf >= high_memory'
> > condition is met, ie:
> > --- a/drivers/mtd/nand/onenand/omap2.c
> > +++ b/drivers/mtd/nand/onenand/omap2.c
> > @@ -392,6 +392,7 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> >  	if (buf >= high_memory) {
> >  		struct page *p1;
> >  
> > +		goto out_copy;
> >  		if (((size_t)buf & PAGE_MASK) !=
> >  		    ((size_t)(buf + count - 1) & PAGE_MASK))
> >  			goto out_copy;
> 
> I had the same problem here, and that snippet  helps here. ubiattach
> -p /dev/mtdX does not cause kernel oopses here anymore

It seems reviving old code always comes at a price :-) Could you try
following patch, so far compile tested only?
(we'll need to do the same for omap2_onenand_write_bufferram, but
it sould be enough for testing purposes now)

diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
index 9c159f0dd9a6..04cefd7a6487 100644
--- a/drivers/mtd/nand/onenand/omap2.c
+++ b/drivers/mtd/nand/onenand/omap2.c
@@ -375,11 +375,12 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 {
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
+	struct device *dev = &c->pdev->dev;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
 	void *buf = (void *)buffer;
 	size_t xtra;
-	int ret;
+	int ret, page_dma = 0;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
 	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
@@ -389,38 +390,43 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	if (in_interrupt() || oops_in_progress)
 		goto out_copy;
 
+	xtra = count & 3;
+	if (xtra) {
+		count -= xtra;
+		memcpy(buf + count, this->base + bram_offset + count, xtra);
+	}
+
+	/* Handle vmalloc address */
 	if (buf >= high_memory) {
-		struct page *p1;
+		struct page *page;
 
 		if (((size_t)buf & PAGE_MASK) !=
 		    ((size_t)(buf + count - 1) & PAGE_MASK))
 			goto out_copy;
-		p1 = vmalloc_to_page(buf);
-		if (!p1)
+		page = vmalloc_to_page(buf);
+		if (!page)
 			goto out_copy;
-		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
-	}
-
-	xtra = count & 3;
-	if (xtra) {
-		count -= xtra;
-		memcpy(buf + count, this->base + bram_offset + count, xtra);
+		page_dma = 1;
+		dma_dst = dma_map_page(dev, page, (size_t) buf & ~PAGE_MASK,
+				       count, DMA_FROM_DEVICE);
+	} else {
+		dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
 	}
-
 	dma_src = c->phys_base + bram_offset;
-	dma_dst = dma_map_single(&c->pdev->dev, buf, count, DMA_FROM_DEVICE);
-	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
+
+	if (dma_mapping_error(dev, dma_dst)) {
+		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
 		goto out_copy;
 	}
 
 	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
-	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+	if (page_dma)
+		dma_unmap_page(dev, dma_dst, count, DMA_FROM_DEVICE);
+	else
+		dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
 
 	if (ret) {
-		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+		dev_err(dev, "timeout waiting for DMA\n");
 		goto out_copy;
 	}
 
