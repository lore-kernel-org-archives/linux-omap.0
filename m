From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: OneNAND for OMAP3
Date: Fri, 1 Aug 2008 10:45:58 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808011030270.19571@utopia.booyaka.com>
References: <4892C533.50904@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYHAQp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 12:45:59 -0400
In-Reply-To: <4892C533.50904@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Adrian,

On Fri, 1 Aug 2008, Adrian Hunter wrote:

> Update OneNAND support for OMAP3.

a few quick comments.

> +		reg =
> omap2_onenand_readw(onenand_base+ONENAND_REG_VERSION_ID);

Just a minor nit - please use spaces around binary & ternary operators per 
CodingStyle.

> +			  (sync_write?GPMC_CONFIG1_WRITEMULTIPLE_SUPP:0) |
> +			  (sync_write?GPMC_CONFIG1_WRITETYPE_SYNC:0) |

as above.

> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index ba83900..378ee17 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -223,6 +227,155 @@ static inline int omap2_onenand_bufferram_offset(struct
> mtd_info *mtd, int area)
> 	return 0;
> }
> 
> +#if defined(CONFIG_ARCH_OMAP3)
> +
> +static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> +					unsigned char *buffer, int offset,
> +					size_t count)
> +{
> +	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand,
> mtd);
> +	struct onenand_chip *this = mtd->priv;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset;
> +	unsigned long timeout;
> +	void *buf = (void *)buffer;
> +	size_t xtra;
> +	volatile unsigned *done;

The way this volatile is used doesn't look right...

> +	INIT_COMPLETION(info->dma_done);
> +	omap_start_dma(info->dma_channel);
> +
> +	timeout = jiffies + msecs_to_jiffies(20);
> +	done = &info->dma_done.done;

So the volatile here appears to apply to the address of 'done', but this 
address does not change, correct?  Only the value of 'done' itself 
changes.

> +	while (time_before(jiffies, timeout))
> +		if (*done)
> +			break;

Can this be replaced with wait_for_completion_timeout() or something 
similar?

> +	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> +
> +	if (!*done) {
> +		dev_err(&info->pdev->dev, "timeout waiting for DMA\n");
> +		goto out_copy;
> +	}

...

> +static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> +					 const unsigned char *buffer, int
> offset,
> +					 size_t count)
> +{
> +	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand,
> mtd);
> +	struct onenand_chip *this = mtd->priv;
> +	dma_addr_t dma_src, dma_dst;
> +	int bram_offset;
> +	unsigned long timeout;
> +	void *buf = (void *)buffer;
> +	volatile unsigned *done;

Same comments in this function per volatile.


- Paul
