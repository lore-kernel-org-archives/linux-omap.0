From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Simplify the DMA setup for various
 paths
Date: Fri, 18 Dec 2015 10:11:11 -0800
Message-ID: <20151218181111.GK10460@google.com>
References: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kyungmin.park@samsung.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 14, 2015 at 11:49:32AM +0200, Peter Ujfalusi wrote:
> We have 4 functions containing almost identical DMA setup code. Create one
> function which can set up the DMA for both read and write and use this in
> place for the setup code in the driver.
> The new function will use wait_for_completion_timeout() and it will figure
> out the best data_type to be used for the transfer instead of hardwiring
> 32 or 16 bit data.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Does anyone use this driver? I've seen practically zero activity on the
entire OneNAND codebase in the last few years, and I presumed it was
essentially dead.

If it's not dead, I'd like to know some contingency of people who are
willing to actually maintain (or at least review) this stuff.

Kyungmin, are you still out there? Or Tony, do you know of any users for
this?

Peter, are you actually using this, or are you just refactoring for the
fun of it?

Brian

> ---
>  drivers/mtd/onenand/omap2.c | 106 ++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 0aacf125938b..58576c9babb0 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -291,6 +291,30 @@ static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
>  	return 0;
>  }
>  
> +static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
> +					     dma_addr_t src, dma_addr_t dst,
> +					     size_t count)
> +{
> +	int data_type = __ffs((src | dst | count));
> +
> +	if (data_type > OMAP_DMA_DATA_TYPE_S32)
> +		data_type = OMAP_DMA_DATA_TYPE_S32;
> +
> +	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> +				     count / BIT(data_type), 1, 0, 0, 0);
> +	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> +				src, 0, 0);
> +	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> +				 dst, 0, 0);
> +
> +	reinit_completion(&c->dma_done);
> +	omap_start_dma(c->dma_channel);
> +	if (wait_for_completion_timeout(&c->dma_done, msecs_to_jiffies(20)))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
>  #if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
>  
>  static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> @@ -301,10 +325,9 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  	struct onenand_chip *this = mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
>  	int bram_offset;
> -	unsigned long timeout;
>  	void *buf = (void *)buffer;
>  	size_t xtra;
> -	volatile unsigned *done;
> +	int ret;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
>  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> @@ -341,25 +364,10 @@ static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  		goto out_copy;
>  	}
>  
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count >> 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -
> -	timeout = jiffies + msecs_to_jiffies(20);
> -	done = &c->dma_done.done;
> -	while (time_before(jiffies, timeout))
> -		if (*done)
> -			break;
> -
> +	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
>  
> -	if (!*done) {
> +	if (ret) {
>  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
>  		goto out_copy;
>  	}
> @@ -379,9 +387,8 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  	struct onenand_chip *this = mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
>  	int bram_offset;
> -	unsigned long timeout;
>  	void *buf = (void *)buffer;
> -	volatile unsigned *done;
> +	int ret;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
>  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> @@ -412,25 +419,10 @@ static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  		return -1;
>  	}
>  
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count >> 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -
> -	timeout = jiffies + msecs_to_jiffies(20);
> -	done = &c->dma_done.done;
> -	while (time_before(jiffies, timeout))
> -		if (*done)
> -			break;
> -
> +	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
>  
> -	if (!*done) {
> +	if (ret) {
>  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
>  		goto out_copy;
>  	}
> @@ -469,7 +461,7 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
>  	struct onenand_chip *this = mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	int bram_offset, ret;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
>  	/* DMA is not used.  Revisit PM requirements before enabling it. */
> @@ -491,20 +483,13 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  		return -1;
>  	}
>  
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count / 4, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -	wait_for_completion(&c->dma_done);
> -
> +	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
>  
> -	return 0;
> +	if (ret)
> +		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +
> +	return ret;
>  }
>  
>  static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> @@ -514,7 +499,7 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
>  	struct onenand_chip *this = mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	int bram_offset, ret;
>  
>  	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
>  	/* DMA is not used.  Revisit PM requirements before enabling it. */
> @@ -536,20 +521,13 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  		return -1;
>  	}
>  
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S16,
> -				     count / 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -	wait_for_completion(&c->dma_done);
> -
> +	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
>  
> -	return 0;
> +	if (ret)
> +		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +
> +	return ret;
>  }
>  
>  #else
> -- 
> 2.6.4
> 
