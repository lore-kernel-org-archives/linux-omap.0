From: Vignesh R <vigneshr@ti.com>
Subject: Re: Applied "spi: Add DMA support for spi_flash_read()" to the spi
 tree
Date: Wed, 8 Jun 2016 14:57:57 +0530
Message-ID: <5757E51D.8050004@ti.com>
References: <E1bAZk4-00074D-C8@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1bAZk4-00074D-C8@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 June 2016 02:55 PM, Mark Brown wrote:
> The patch
> 
>    spi: Add DMA support for spi_flash_read()
> 
> has been applied to the spi tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

Could you please drop this and pick v4 instead? There were some build
errors reported by kbuild test bot for this version? Or you want me to
sent incremental patch?


> 
> From 12107f2fcc1dd832ebe0b8a61da2145eaea8730d Mon Sep 17 00:00:00 2001
> From: Vignesh R <vigneshr@ti.com>
> Date: Tue, 7 Jun 2016 13:48:09 +0530
> Subject: [PATCH] spi: Add DMA support for spi_flash_read()
> 
> Few SPI devices provide accelerated read interfaces to read from
> SPI-NOR flash devices. These hardwares also support DMA to transfer data
> from flash to memory either via mem-to-mem DMA or dedicated slave DMA
> channels. Hence, add support for DMA in order to improve throughput and
> reduce CPU load.
> Use spi_map_buf() to get sg table for the buffer and pass it to SPI
> driver.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi.c       | 14 ++++++++++++++
>  include/linux/spi/spi.h |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 77e6e45951f4..da2cbe205654 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2725,6 +2725,7 @@ int spi_flash_read(struct spi_device *spi,
>  
>  {
>  	struct spi_master *master = spi->master;
> +	struct device *rx_dev = NULL;
>  	int ret;
>  
>  	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
> @@ -2750,9 +2751,22 @@ int spi_flash_read(struct spi_device *spi,
>  			return ret;
>  		}
>  	}
> +
>  	mutex_lock(&master->bus_lock_mutex);
> +	if (master->dma_rx) {
> +		rx_dev = master->dma_rx->device->dev;
> +		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
> +				  msg->buf, msg->len,
> +				  DMA_FROM_DEVICE);
> +		if (!ret)
> +			msg->cur_msg_mapped = true;
> +	}
>  	ret = master->spi_flash_read(spi, msg);
> +	if (msg->cur_msg_mapped)
> +		spi_unmap_buf(master, rx_dev, &msg->rx_sg,
> +			      DMA_FROM_DEVICE);
>  	mutex_unlock(&master->bus_lock_mutex);
> +
>  	if (master->auto_runtime_pm)
>  		pm_runtime_put(master->dev.parent);
>  
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 1f03483f61e5..7b53af4ba5f8 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1143,6 +1143,8 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
>   * @opcode_nbits: number of lines to send opcode
>   * @addr_nbits: number of lines to send address
>   * @data_nbits: number of lines for data
> + * @rx_sg: Scatterlist for receive data read from flash
> + * @cur_msg_mapped: message has been mapped for DMA
>   */
>  struct spi_flash_read_message {
>  	void *buf;
> @@ -1155,6 +1157,8 @@ struct spi_flash_read_message {
>  	u8 opcode_nbits;
>  	u8 addr_nbits;
>  	u8 data_nbits;
> +	struct sg_table rx_sg;
> +	bool cur_msg_mapped;
>  };
>  
>  /* SPI core interface for flash read support */
> 

-- 
Regards
Vignesh
