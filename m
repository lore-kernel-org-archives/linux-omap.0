From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v2 1/5] spi/omap: Remove bus_num usage for instance index
Date: Wed, 29 Feb 2012 18:05:57 +0530
Message-ID: <4F4E1BAD.9030807@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com> <1330467550-20474-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:52588 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757314Ab2B2MgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 07:36:07 -0500
Received: by mail-gx0-f169.google.com with SMTP id f1so3574466ggn.0
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 04:36:03 -0800 (PST)
In-Reply-To: <1330467550-20474-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 29 February 2012 03:49 AM, Benoit Cousson wrote:
> bus_num was used to reference the mcspi controller instance in a fixed array.
> Remove this array and store this information directly inside drvdata structure.
>
Good change thanks.
If you want add my Reviewed-by
> bus_num is now just set if the pdev->id is present or with -1 for dynamic
> allocation by SPI core, but the driver does not access it anymore.
>
> Clean some bad comments format, and remove un-needed space.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c |   72 +++++++++++++++++++---------------------
>  1 files changed, 34 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 0b0dfb7..e034164 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -109,6 +109,16 @@ struct omap2_mcspi_dma {
>  #define DMA_MIN_BYTES			160
>  
>  
> +/*
> + * Used for context save and restore, structure members to be updated whenever
> + * corresponding registers are modified.
> + */
> +struct omap2_mcspi_regs {
> +	u32 modulctrl;
> +	u32 wakeupenable;
> +	struct list_head cs;
> +};
> +
>  struct omap2_mcspi {
>  	struct work_struct	work;
>  	/* lock protects queue and registers */
> @@ -120,8 +130,9 @@ struct omap2_mcspi {
>  	unsigned long		phys;
>  	/* SPI1 has 4 channels, while SPI2 has 2 */
>  	struct omap2_mcspi_dma	*dma_channels;
> -	struct  device		*dev;
> +	struct device		*dev;
>  	struct workqueue_struct *wq;
> +	struct omap2_mcspi_regs ctx;
>  };
>  
>  struct omap2_mcspi_cs {
> @@ -133,17 +144,6 @@ struct omap2_mcspi_cs {
>  	u32			chconf0;
>  };
>  
> -/* used for context save and restore, structure members to be updated whenever
> - * corresponding registers are modified.
> - */
> -struct omap2_mcspi_regs {
> -	u32 modulctrl;
> -	u32 wakeupenable;
> -	struct list_head cs;
> -};
> -
> -static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
> -
>  #define MOD_REG_BIT(val, mask, set) do { \
>  	if (set) \
>  		val |= mask; \
> @@ -234,9 +234,12 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
>  
>  static void omap2_mcspi_set_master_mode(struct spi_master *master)
>  {
> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>  	u32 l;
>  
> -	/* setup when switching from (reset default) slave mode
> +	/*
> +	 * Setup when switching from (reset default) slave mode
>  	 * to single-channel master mode
>  	 */
>  	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> @@ -245,24 +248,20 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
>  	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  
> -	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
> +	ctx->modulctrl = l;
>  }
>  
>  static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>  {
> -	struct spi_master *spi_cntrl;
> -	struct omap2_mcspi_cs *cs;
> -	spi_cntrl = mcspi->master;
> +	struct spi_master	*spi_cntrl = mcspi->master;
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
> +	struct omap2_mcspi_cs	*cs;
>  
>  	/* McSPI: context restore */
> -	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> -			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
> -
> -	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> -			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL, ctx->modulctrl);
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE, ctx->wakeupenable);
>  
> -	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
> -			node)
> +	list_for_each_entry(cs, &ctx->cs, node)
>  		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
>  }
>  static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> @@ -775,7 +774,8 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
>  static int omap2_mcspi_setup(struct spi_device *spi)
>  {
>  	int			ret;
> -	struct omap2_mcspi	*mcspi;
> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(spi->master);
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>  	struct omap2_mcspi_dma	*mcspi_dma;
>  	struct omap2_mcspi_cs	*cs = spi->controller_state;
>  
> @@ -785,7 +785,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	mcspi = spi_master_get_devdata(spi->master);
>  	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
>  
>  	if (!cs) {
> @@ -797,8 +796,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  		cs->chconf0 = 0;
>  		spi->controller_state = cs;
>  		/* Link this to context save list */
> -		list_add_tail(&cs->node,
> -			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
> +		list_add_tail(&cs->node, &ctx->cs);
>  	}
>  
>  	if (mcspi_dma->dma_rx_channel == -1
> @@ -1051,8 +1049,9 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
>  static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
>  {
>  	struct spi_master	*master = mcspi->master;
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>  	u32			tmp;
> -	int ret = 0;
> +	int			ret = 0;
>  
>  	ret = omap2_mcspi_enable_clocks(mcspi);
>  	if (ret < 0)
> @@ -1060,7 +1059,7 @@ static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
>  
>  	tmp = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
>  	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp);
> -	omap2_mcspi_ctx[master->bus_num - 1].wakeupenable = tmp;
> +	ctx->wakeupenable = tmp;
>  
>  	omap2_mcspi_set_master_mode(master);
>  	omap2_mcspi_disable_clocks(mcspi);
> @@ -1087,7 +1086,6 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  	struct omap2_mcspi	*mcspi;
>  	struct resource		*r;
>  	int			status = 0, i;
> -	char			wq_name[20];
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
>  	if (master == NULL) {
> @@ -1111,8 +1109,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  	mcspi = spi_master_get_devdata(master);
>  	mcspi->master = master;
>  
> -	sprintf(wq_name, "omap2_mcspi/%d", master->bus_num);
> -	mcspi->wq = alloc_workqueue(wq_name, WQ_MEM_RECLAIM, 1);
> +	mcspi->wq = alloc_workqueue(dev_name(&pdev->dev), WQ_MEM_RECLAIM, 1);
>  	if (mcspi->wq == NULL) {
>  		status = -ENOMEM;
>  		goto free_master;
> @@ -1145,7 +1142,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&mcspi->lock);
>  	INIT_LIST_HEAD(&mcspi->msg_queue);
> -	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
> +	INIT_LIST_HEAD(&mcspi->ctx.cs);
>  
>  	mcspi->dma_channels = kcalloc(master->num_chipselect,
>  			sizeof(struct omap2_mcspi_dma),
> @@ -1252,13 +1249,12 @@ static int omap2_mcspi_resume(struct device *dev)
>  {
>  	struct spi_master	*master = dev_get_drvdata(dev);
>  	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
> -	struct omap2_mcspi_cs *cs;
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
> +	struct omap2_mcspi_cs	*cs;
>  
>  	omap2_mcspi_enable_clocks(mcspi);
> -	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
> -			    node) {
> +	list_for_each_entry(cs, &ctx->cs, node) {
>  		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
> -
>  			/*
>  			 * We need to toggle CS state for OMAP take this
>  			 * change in account.

