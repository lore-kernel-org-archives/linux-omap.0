From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
Date: Mon, 15 Oct 2018 13:53:10 +0530
Message-ID: <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015063829.26978-4-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 15 October 2018 12:08 PM, Vignesh R wrote:
> Add support to use McSPI controller as SPI slave. In slave mode, DMA TX
> completion does not mean entire data has been shifted out as data might
> still be stuck in FIFO waiting for master to clock the bus. Therefore,
> add an IRQ handler for slave mode to know when entire data in FIFO has
> been shifted out.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 138 ++++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 88469bb22235..f024c3fc3679 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -127,6 +127,7 @@ struct omap2_mcspi_regs {
>  };
>  
>  struct omap2_mcspi {
> +	struct completion	txdone;
>  	struct spi_master	*master;
>  	/* Virtual base address of the controller */
>  	void __iomem		*base;
> @@ -136,6 +137,7 @@ struct omap2_mcspi {
>  	struct device		*dev;
>  	struct omap2_mcspi_regs ctx;
>  	int			fifo_depth;
> +	bool			slave_aborted;
>  	unsigned int		pin_dir:1;
>  };
>  
> @@ -275,19 +277,23 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>  	}
>  }
>  
> -static void omap2_mcspi_set_master_mode(struct spi_master *master)
> +static void omap2_mcspi_set_mode(struct spi_master *master)
>  {
>  	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
>  	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>  	u32 l;
>  
>  	/*
> -	 * Setup when switching from (reset default) slave mode
> -	 * to single-channel master mode
> +	 * Choose master or slave mode
>  	 */
>  	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> -	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST | OMAP2_MCSPI_MODULCTRL_MS);
> -	l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
> +	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST);
> +	if (spi_controller_is_slave(master)) {
> +		l |= (OMAP2_MCSPI_MODULCTRL_MS);
> +	} else {
> +		l &= ~(OMAP2_MCSPI_MODULCTRL_MS);
> +		l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
> +	}
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  
>  	ctx->modulctrl = l;
> @@ -356,6 +362,20 @@ static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
>  	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
>  }
>  
> +static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,
> +				     struct completion *x)
> +{
> +	if (spi_controller_is_slave(mcspi->master)) {
> +		if (wait_for_completion_interruptible(x) ||
> +		    mcspi->slave_aborted)
> +			return -EINTR;
> +	} else {
> +		wait_for_completion(x);
> +	}
> +
> +	return 0;
> +}
> +
>  static void omap2_mcspi_rx_callback(void *data)
>  {
>  	struct spi_device *spi = data;
> @@ -505,7 +525,12 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
>  	dma_async_issue_pending(mcspi_dma->dma_rx);
>  	omap2_mcspi_set_dma_req(spi, 1, 1);
>  
> -	wait_for_completion(&mcspi_dma->dma_rx_completion);
> +	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
> +	if (ret || mcspi->slave_aborted) {
> +		dmaengine_terminate_sync(mcspi_dma->dma_rx);
> +		omap2_mcspi_set_dma_req(spi, 1, 0);
> +		return 0;
> +	}
>  
>  	for (x = 0; x < nb_sizes; x++)
>  		kfree(sg_out[x]);
> @@ -604,14 +629,37 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  	rx = xfer->rx_buf;
>  	tx = xfer->tx_buf;
>  
> -	if (tx != NULL)
> +	mcspi->slave_aborted = false;
> +	reinit_completion(&mcspi_dma->dma_tx_completion);
> +	reinit_completion(&mcspi_dma->dma_rx_completion);
> +	reinit_completion(&mcspi->txdone);
> +	if (tx) {
> +		/* Enable EOW IRQ to know end of tx in slave mode */
> +		if (spi_controller_is_slave(spi->master))
> +			mcspi_write_reg(spi->master,
> +					OMAP2_MCSPI_IRQENABLE,
> +					OMAP2_MCSPI_IRQSTATUS_EOW);
>  		omap2_mcspi_tx_dma(spi, xfer, cfg);
> +	}
>  
>  	if (rx != NULL)
>  		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
>  
>  	if (tx != NULL) {
> -		wait_for_completion(&mcspi_dma->dma_tx_completion);
> +		int ret;
> +
> +		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
> +		if (ret || mcspi->slave_aborted) {
> +			dmaengine_terminate_sync(mcspi_dma->dma_tx);
> +			omap2_mcspi_set_dma_req(spi, 0, 0);
> +			return 0;
> +		}
> +
> +		if (spi_controller_is_slave(mcspi->master)) {
> +			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
> +			if (ret || mcspi->slave_aborted)
> +				return 0;
> +		}
>  
>  		if (mcspi->fifo_depth > 0) {
>  			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
> @@ -1068,6 +1116,36 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
>  		gpio_free(spi->cs_gpio);
>  }
>  
> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
> +{
> +	struct omap2_mcspi *mcspi = data;
> +	u32 irqstat;
> +
> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
> +	if (!irqstat)
> +		return IRQ_NONE;
> +
> +	/* Disable IRQ and wakeup slave xfer task */
> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
> +		complete(&mcspi->txdone);
> +
> +	return IRQ_HANDLED;

You need to have the:

pm_runtime_get_sync();

/* access registers */

pm_runtime_mark_last_busy();
pm_runtime_put_autosuspend();

sequence here. I think thats also missing from the dma callbacks.
Probably working by chance today.

Thanks,
Sekhar
