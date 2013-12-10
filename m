From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCHv2 03/10] spi/qspi: Add support to switc to memory mapped operation.
Date: Tue, 10 Dec 2013 13:54:43 +0100
Message-ID: <201312101354.43674.marex@denx.de>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <1386339891-32717-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386339891-32717-4-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday, December 06, 2013 at 03:24:44 PM, Sourav Poddar wrote:
> These add apis that can be used to switch to memory mapped operatons
> by configuring control module and qspi registers.
> It also add "master->mmap" property to show that qspi
> supports memory mapped operation.

Please fix the 'switc' in the subject, should be 'switch' :)

> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
> v1->v2:
>  Squash a patch to add mater->mmap here itself.
>  drivers/spi/spi-ti-qspi.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index a0cee08..48294d1 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -113,6 +113,10 @@ struct ti_qspi {
>  #define QSPI_CSPOL(n)			(1 << (1 + n * 8))
>  #define QSPI_CKPOL(n)			(1 << (n * 8))
> 
> +#define MM_SWITCH	(1 << 0)
> +#define MEM_CS		(1 << 8)
> +#define MEM_CS_DIS	(0 << 8)

You might want to be consistent here, I'd use MEM_CS_EN and MEM_CS_DIS. But 
please see below first as MEM_CS_DIS won't be needed, so MEM_CS can be preserved 
as is and MEM_CS_DIS removed altogether.

> +
>  #define	QSPI_FRAME			4096
> 
>  #define QSPI_AUTOSUSPEND_TIMEOUT         2000
> @@ -129,6 +133,30 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
>  	writel(val, qspi->base + reg);
>  }
> 
> +static void enable_qspi_memory_mapped(struct ti_qspi *qspi)
> +{
> +	u32 val;
> +
> +	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
> +	if (qspi->ctrl_mod) {
> +		val = readl(qspi->ctrl_base);
> +		val |= MEM_CS;
> +		writel(val, qspi->ctrl_base);
> +	}
> +}
> +
> +static void disable_qspi_memory_mapped(struct ti_qspi *qspi)
> +{
> +	u32 val;
> +
> +	ti_qspi_write(qspi, ~MM_SWITCH, QSPI_SPI_SWITCH_REG);
> +	if (qspi->ctrl_mod) {
> +		val = readl(qspi->ctrl_base);
> +		val &= MEM_CS_DIS;

This will likely break once SWITCH_REG contains more than one bit, you can fix 
this by using "val &= ~MEM_CS;" instead, which will also get rid of the 
MEM_CS_DIS bit.

> +		writel(val, qspi->ctrl_base);
> +	}
> +}
> +
>  static int ti_qspi_setup(struct spi_device *spi)
>  {
>  	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
> @@ -459,6 +487,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  	master->transfer_one_message = ti_qspi_start_transfer_one;
>  	master->dev.of_node = pdev->dev.of_node;
>  	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
> +	master->mmap = true;
> 
>  	if (!of_property_read_u32(np, "num-cs", &num_cs))
>  		master->num_chipselect = num_cs;

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
