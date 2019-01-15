From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix DMA and FIFO event trigger size
 mismatch
Date: Tue, 15 Jan 2019 10:48:35 -0600
Message-ID: <6a923c36-2b61-9f9c-d965-b99dc6831070@lechnology.com>
References: <20190115065832.23705-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115065832.23705-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 1/15/19 12:58 AM, Vignesh R wrote:
> Commit b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
> broke SPI transfers where bits_per_word != 8. This is because of
> mimsatch between McSPI FIFO level event trigger size (SPI word length) and
> DMA request size(word length * maxburst). This leads to data
> corruption, lockup and errors like:
> 
> 	spi1.0: EOW timed out
> 
> Fix this by setting DMA maxburst size to 1 so that
> McSPI FIFO level event trigger size matches DMA request size.
> 
> Fixes: b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
> Cc: stable@vger.kernel.org
> Reported-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>   drivers/spi/spi-omap2-mcspi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..8be304379628 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>   	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>   	cfg.src_addr_width = width;
>   	cfg.dst_addr_width = width;
> -	cfg.src_maxburst = es;
> -	cfg.dst_maxburst = es;
> +	cfg.src_maxburst = 1;
> +	cfg.dst_maxburst = 1;
>   
>   	rx = xfer->rx_buf;
>   	tx = xfer->tx_buf;
> 

Works for me.
