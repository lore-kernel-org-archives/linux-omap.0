From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
Date: Mon, 14 Jan 2019 18:00:06 +0530
Message-ID: <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
References: <20190113204905.29795-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190113204905.29795-1-david@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 14/01/19 2:19 AM, David Lechner wrote:
> This reverts commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab.
> 
> That commit breaks displays using tinydrm drivers, such as ili9225.
> 
> It causes corruption in the image that is displayed (it looks like only
> 1/2 of the framebuffer data is sent, the other half of the display
> remains blank.)
> 
> The following error appears multiple times:
> 
>     ili9225 spi1.0: EOW timed out
> 
> Eventually, the system locks up without any additional errors.
> 

Oops, that's unfortunate. I see ili9225 is using bits_per_word = 16.
I believe commit b682cffa3ac6d9d broke spi_transfers where 
bits_per_word anything other than 8 bits.
I don't have ili9225 HW but was able emulate this condition using a SPI 
flash as slave on AM335x and successfully reproduced the issue. Could 
you test if this diff[1] helps in fixing the regression without needing
to revert commit b682cffa3ac6d9d?

If below diff does not help, then could you post logs of types of 
spi_transfers being queued by ili9225 driver? I guess you can dump them 
by enabling DEBUG option in tinydrm-helpers.c.
Also which TI SoC are you using?

Sorry for the trouble!

[1]:

Adjust maxburst size of DMA xfer according to the DMA trigger level and word length
instead of just word length


diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2fd8881fcd65..6b7edcff0e6b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
        cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
        cfg.src_addr_width = width;
        cfg.dst_addr_width = width;
-       cfg.src_maxburst = es;
-       cfg.dst_maxburst = es;
+       cfg.src_maxburst = width / es;
+       cfg.dst_maxburst = width / es;
 
        rx = xfer->rx_buf;
        tx = xfer->tx_buf;

--
Regards
Vignesh



> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..5a3854ff2e08 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -306,7 +306,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>  	struct omap2_mcspi_cs *cs = spi->controller_state;
>  	struct omap2_mcspi *mcspi;
>  	unsigned int wcnt;
> -	int max_fifo_depth, bytes_per_word;
> +	int max_fifo_depth, fifo_depth, bytes_per_word;
>  	u32 chconf, xferlevel;
>  
>  	mcspi = spi_master_get_devdata(master);
> @@ -322,6 +322,10 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>  		else
>  			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
>  
> +		fifo_depth = gcd(t->len, max_fifo_depth);
> +		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
> +			goto disable_fifo;
> +
>  		wcnt = t->len / bytes_per_word;
>  		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
>  			goto disable_fifo;
> @@ -329,17 +333,16 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>  		xferlevel = wcnt << 16;
>  		if (t->rx_buf != NULL) {
>  			chconf |= OMAP2_MCSPI_CHCONF_FFER;
> -			xferlevel |= (bytes_per_word - 1) << 8;
> +			xferlevel |= (fifo_depth - 1) << 8;
>  		}
> -
>  		if (t->tx_buf != NULL) {
>  			chconf |= OMAP2_MCSPI_CHCONF_FFET;
> -			xferlevel |= bytes_per_word - 1;
> +			xferlevel |= fifo_depth - 1;
>  		}
>  
>  		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
>  		mcspi_write_chconf0(spi, chconf);
> -		mcspi->fifo_depth = max_fifo_depth;
> +		mcspi->fifo_depth = fifo_depth;
>  
>  		return;
>  	}
> @@ -598,6 +601,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  	struct dma_slave_config	cfg;
>  	enum dma_slave_buswidth width;
>  	unsigned es;
> +	u32			burst;
>  	void __iomem		*chstat_reg;
>  	void __iomem            *irqstat_reg;
>  	int			wait_res;
> @@ -617,14 +621,22 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  	}
>  
>  	count = xfer->len;
> +	burst = 1;
> +
> +	if (mcspi->fifo_depth > 0) {
> +		if (count > mcspi->fifo_depth)
> +			burst = mcspi->fifo_depth / es;
> +		else
> +			burst = count / es;
> +	}
>  
>  	memset(&cfg, 0, sizeof(cfg));
>  	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
>  	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>  	cfg.src_addr_width = width;
>  	cfg.dst_addr_width = width;
> -	cfg.src_maxburst = es;
> -	cfg.dst_maxburst = es;
> +	cfg.src_maxburst = burst;
> +	cfg.dst_maxburst = burst;
>  
>  	rx = xfer->rx_buf;
>  	tx = xfer->tx_buf;
> 
