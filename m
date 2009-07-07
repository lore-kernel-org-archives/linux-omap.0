From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: SPI: Restore also CHxCONF register when restoring context
Date: Tue, 07 Jul 2009 14:59:44 -0700
Message-ID: <874otocfxr.fsf@deeprootsystems.com>
References: <1246447750-12197-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:61597 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZGGV7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 17:59:48 -0400
Received: by pzk31 with SMTP id 31so3232940pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 14:59:47 -0700 (PDT)
In-Reply-To: <1246447750-12197-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\,  1 Jul 2009 14\:29\:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Previous restore was lazy and only restored CHxCONF when it was needed by a
> specific chip select. This could cause occasional errors on an SPI bus where
> multiple chip selects are in use.
>
> Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, pulling into PM branch.

Kevin

> ---
>  drivers/spi/omap2_mcspi.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index a75c546..7853fb7 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -134,6 +134,7 @@ struct omap2_mcspi_cs {
>  	void __iomem		*base;
>  	unsigned long		phys;
>  	int			word_len;
> +	struct list_head	node;
>  	/* Context save and restore shadow register */
>  	u32			chconf0;
>  };
> @@ -145,6 +146,7 @@ struct omap2_mcspi_regs {
>  	u32 sysconfig;
>  	u32 modulctrl;
>  	u32 wakeupenable;
> +	struct list_head cs;
>  };
>  
>  static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
> @@ -255,6 +257,7 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
>  static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>  {
>  	struct spi_master *spi_cntrl;
> +	struct omap2_mcspi_cs *cs;
>  	spi_cntrl = mcspi->master;
>  
>  	/* McSPI: context restore */
> @@ -266,6 +269,10 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>  
>  	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>  			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
> +
> +	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
> +			node)
> +		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
>  }
>  static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
>  {
> @@ -706,6 +713,9 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  		cs->phys = mcspi->phys + spi->chip_select * 0x14;
>  		cs->chconf0 = 0;
>  		spi->controller_state = cs;
> +		/* Link this to context save list */
> +		list_add_tail(&cs->node,
> +			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
>  	}
>  
>  	if (mcspi_dma->dma_rx_channel == -1
> @@ -728,10 +738,15 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
>  {
>  	struct omap2_mcspi	*mcspi;
>  	struct omap2_mcspi_dma	*mcspi_dma;
> +	struct omap2_mcspi_cs	*cs;
>  
>  	mcspi = spi_master_get_devdata(spi->master);
>  	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
>  
> +	/* Unlink controller state from context save list */
> +	cs = spi->controller_state;
> +	list_del(&cs->node);
> +
>  	kfree(spi->controller_state);
>  
>  	if (mcspi_dma->dma_rx_channel != -1) {
> @@ -1093,6 +1108,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&mcspi->lock);
>  	INIT_LIST_HEAD(&mcspi->msg_queue);
> +	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
>  
>  	mcspi->ick = clk_get(&pdev->dev, "ick");
>  	if (IS_ERR(mcspi->ick)) {
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
