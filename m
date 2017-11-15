From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 09/16] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Wed, 15 Nov 2017 10:38:51 +0200
Message-ID: <ba0efa6f-aad0-ca65-9e59-dbded12c71d1@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212244.orvurxipakkywzde@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212244.orvurxipakkywzde@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:22, Ladislav Michl wrote:
> Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 / OMAP3
> OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only into
> OMAP3 specific DMA functions which turned out not to be so OMAP3 specific,
> so merge those two implementations.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  Changes:
>  -v3: new patch
>  -v4: rebase on top of Peter's patch
> 
>  drivers/mtd/onenand/omap2.c | 129 ++------------------------------------------
>  1 file changed, 4 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index d22163271dc9..36314124488d 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -315,9 +315,7 @@ static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
>  	return 0;
>  }
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
> -
> -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> +static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  					unsigned char *buffer, int offset,
>  					size_t count)
>  {
> @@ -379,7 +377,7 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  	return 0;
>  }
>  
> -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> +static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  					 const unsigned char *buffer,
>  					 int offset, size_t count)
>  {
> @@ -434,120 +432,6 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  	return 0;
>  }
>  
> -#else
> -
> -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP2) || defined(MULTI_OMAP2)
> -
> -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
> -	struct onenand_chip *this = mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset, ret;
> -
> -	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
> -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> -	if (1 || (c->dma_channel < 0) ||
> -	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
> -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> -		memcpy(buffer, (__force void *)(this->base + bram_offset),
> -		       count);
> -		return 0;
> -	}
> -
> -	dma_src = c->phys_base + bram_offset;
> -	dma_dst = dma_map_single(&c->pdev->dev, buffer, count,
> -				 DMA_FROM_DEVICE);
> -	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> -
> -	if (ret)
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> -
> -	return ret;
> -}
> -
> -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
> -	struct onenand_chip *this = mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset, ret;
> -
> -	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
> -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> -	if (1 || (c->dma_channel < 0) ||
> -	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
> -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> -		memcpy((__force void *)(this->base + bram_offset), buffer,
> -		       count);
> -		return 0;
> -	}
> -
> -	dma_src = dma_map_single(&c->pdev->dev, (void *) buffer, count,
> -				 DMA_TO_DEVICE);
> -	dma_dst = c->phys_base + bram_offset;
> -	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> -
> -	if (ret)
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> -
> -	return ret;
> -}
> -
> -#else
> -
> -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -#endif
> -
>  static struct platform_driver omap2_onenand_driver;
>  
>  static void omap2_onenand_shutdown(struct platform_device *pdev)
> @@ -671,13 +555,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>  	this = &c->onenand;
>  	if (c->dma_channel >= 0) {
>  		this->wait = omap2_onenand_wait;
> -		if (c->flags & ONENAND_IN_OMAP34XX) {
> -			this->read_bufferram = omap3_onenand_read_bufferram;
> -			this->write_bufferram = omap3_onenand_write_bufferram;
> -		} else {
> -			this->read_bufferram = omap2_onenand_read_bufferram;
> -			this->write_bufferram = omap2_onenand_write_bufferram;
> -		}
> +		this->read_bufferram = omap2_onenand_read_bufferram;
> +		this->write_bufferram = omap2_onenand_write_bufferram;
>  	}
>  
>  	if ((r = onenand_scan(&c->mtd, 1)) < 0)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
