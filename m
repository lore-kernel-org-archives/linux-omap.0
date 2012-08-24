From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/10] mtd: nand: omap2: use gpmc provided irqs
Date: Fri, 24 Aug 2012 12:29:47 -0700
Message-ID: <20120824192947.GT11011@atomide.com>
References: <cover.1344609341.git.afzal@ti.com>
 <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40978 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370Ab2HXT3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 15:29:53 -0400
Content-Disposition: inline
In-Reply-To: <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com

Artem,

* Afzal Mohammed <afzal@ti.com> [120821 02:44]:
> GPMC platform initialization provides it's clients
> with interrupts that can be used through struct
> resource. Make use of it for irq mode functionality.
> 
> Also now write protect disable is done by GPMC,
> hence remove it.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v3: Handle error path properly

Care to (re)ack this one as the error path handling changed?

Regards,

Tony
 
>  drivers/mtd/nand/omap2.c |   76 +++++++++++++++++++++++++++++-----------------
>  1 files changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index f65f7f8..0e9d7b3 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -137,7 +137,8 @@ struct omap_nand_info {
>  	unsigned long			mem_size;
>  	struct completion		comp;
>  	struct dma_chan			*dma;
> -	int				gpmc_irq;
> +	int				gpmc_irq_fifo;
> +	int				gpmc_irq_count;
>  	enum {
>  		OMAP_NAND_IO_READ = 0,	/* read */
>  		OMAP_NAND_IO_WRITE,	/* write */
> @@ -553,14 +554,12 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
>  {
>  	struct omap_nand_info *info = (struct omap_nand_info *) dev;
>  	u32 bytes;
> -	u32 irq_stat;
>  
> -	irq_stat = gpmc_read_status(GPMC_GET_IRQ_STATUS);
>  	bytes = readl(info->reg.gpmc_prefetch_status);
>  	bytes = GPMC_PREFETCH_STATUS_FIFO_CNT(bytes);
>  	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
>  	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
> -		if (irq_stat & 0x2)
> +		if (this_irq == info->gpmc_irq_count)
>  			goto done;
>  
>  		if (info->buf_len && (info->buf_len < bytes))
> @@ -577,20 +576,17 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
>  						(u32 *)info->buf, bytes >> 2);
>  		info->buf = info->buf + bytes;
>  
> -		if (irq_stat & 0x2)
> +		if (this_irq == info->gpmc_irq_count)
>  			goto done;
>  	}
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
>  
>  	return IRQ_HANDLED;
>  
>  done:
>  	complete(&info->comp);
> -	/* disable irq */
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ, 0);
>  
> -	/* clear status */
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_SET_IRQ_STATUS, irq_stat);
> +	disable_irq_nosync(info->gpmc_irq_fifo);
> +	disable_irq_nosync(info->gpmc_irq_count);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -624,9 +620,9 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
>  		goto out_copy;
>  
>  	info->buf_len = len;
> -	/* enable irq */
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
> -		(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
> +
> +	enable_irq(info->gpmc_irq_count);
> +	enable_irq(info->gpmc_irq_fifo);
>  
>  	/* waiting for read to complete */
>  	wait_for_completion(&info->comp);
> @@ -674,12 +670,13 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
>  		goto out_copy;
>  
>  	info->buf_len = len;
> -	/* enable irq */
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_ENABLE_IRQ,
> -			(GPMC_IRQ_FIFOEVENTENABLE | GPMC_IRQ_COUNT_EVENT));
> +
> +	enable_irq(info->gpmc_irq_count);
> +	enable_irq(info->gpmc_irq_fifo);
>  
>  	/* waiting for write to complete */
>  	wait_for_completion(&info->comp);
> +
>  	/* wait for data to flushed-out before reset the prefetch */
>  	tim = 0;
>  	limit = (loops_per_jiffy *  msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
> @@ -1300,9 +1297,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  	info->nand.options	= pdata->devsize;
>  	info->nand.options	|= NAND_SKIP_BBTSCAN;
>  
> -	/* NAND write protect off */
> -	gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_WP, 0);
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res == NULL) {
>  		err = -EINVAL;
> @@ -1393,17 +1387,37 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  		break;
>  
>  	case NAND_OMAP_PREFETCH_IRQ:
> -		err = request_irq(pdata->gpmc_irq,
> -				omap_nand_irq, IRQF_SHARED, "gpmc-nand", info);
> +		info->gpmc_irq_fifo = platform_get_irq(pdev, 0);
> +		if (info->gpmc_irq_fifo <= 0) {
> +			dev_err(&pdev->dev, "error getting fifo irq\n");
> +			goto out_release_mem_region;
> +		}
> +		err = request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
> +					IRQF_SHARED, "gpmc-nand-fifo", info);
>  		if (err) {
>  			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
> -							pdata->gpmc_irq, err);
> +						info->gpmc_irq_fifo, err);
> +			info->gpmc_irq_fifo = 0;
> +			goto out_release_mem_region;
> +		}
> +
> +		info->gpmc_irq_count = platform_get_irq(pdev, 1);
> +		if (info->gpmc_irq_count <= 0) {
> +			dev_err(&pdev->dev, "error getting count irq\n");
> +			goto out_release_mem_region;
> +		}
> +		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
> +					IRQF_SHARED, "gpmc-nand-count", info);
> +		if (err) {
> +			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
> +						info->gpmc_irq_count, err);
> +			info->gpmc_irq_count = 0;
>  			goto out_release_mem_region;
> -		} else {
> -			info->gpmc_irq	     = pdata->gpmc_irq;
> -			info->nand.read_buf  = omap_read_buf_irq_pref;
> -			info->nand.write_buf = omap_write_buf_irq_pref;
>  		}
> +
> +		info->nand.read_buf  = omap_read_buf_irq_pref;
> +		info->nand.write_buf = omap_write_buf_irq_pref;
> +
>  		break;
>  
>  	default:
> @@ -1491,6 +1505,10 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  out_release_mem_region:
>  	if (info->dma)
>  		dma_release_channel(info->dma);
> +	if (info->gpmc_irq_count > 0)
> +		free_irq(info->gpmc_irq_count, info);
> +	if (info->gpmc_irq_fifo > 0)
> +		free_irq(info->gpmc_irq_fifo, info);
>  	release_mem_region(info->phys_base, info->mem_size);
>  out_free_info:
>  	kfree(info);
> @@ -1509,8 +1527,10 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	if (info->dma)
>  		dma_release_channel(info->dma);
>  
> -	if (info->gpmc_irq)
> -		free_irq(info->gpmc_irq, info);
> +	if (info->gpmc_irq_count > 0)
> +		free_irq(info->gpmc_irq_count, info);
> +	if (info->gpmc_irq_fifo > 0)
> +		free_irq(info->gpmc_irq_fifo, info);
>  
>  	/* Release NAND device, its internal structures and partitions */
>  	nand_release(&info->mtd);
> -- 
> 1.7.1
> 
