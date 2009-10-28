From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Wed, 28 Oct 2009 11:08:30 -0500
Message-ID: <000001ca57e8$e4108ec0$544ff780@am.dhcp.ti.com>
References: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55228 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772AbZJ1QI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 12:08:28 -0400
In-Reply-To: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Phaneendra Kumar Alapati' <phani@embwise.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Phaneendra Kumar Alapati
> Sent: Wednesday, October 28, 2009 8:19 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] OMAP35xx: Added SDIO IRQ support
> 
> This patch adds SDIO IRQ support for omap hsmmc driver.
> 
> Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    62 ++--
>  1 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1cf9cfb..a540626 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -92,6 +92,10 @@
>  #define DUAL_VOLT_OCR_BIT	7
>  #define SRC			(1 << 25)
>  #define SRD			(1 << 26)
> +#define OMAP_HSMMC_CARD_INT	BIT(8)
> +#define SDIO_INT_EN		BIT(8)
Why multiple defines of the same? One of them should be enough.

> +#define CTPL			BIT(11)
> +#define CLKEXTFREE		BIT(16)
Can we define them in the same way as other defines to maintain uniformity?

> 
>  /*
>   * FIXME: Most likely all the data using these _DEVID defines should come
> @@ -149,6 +153,7 @@ struct mmc_omap_host {
>  	int			slot_id;
>  	int			dbclk_enabled;
>  	int			response_busy;
> +	int			sdio_int;

What purpose does this serve? IMHO, this is not needed.

>  	struct	omap_mmc_platform_data	*pdata;
>  };
> 
> @@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host
> *host, struct mmc_command *cmd,
>  	 * Clear status bits and enable interrupts
>  	 */
>  	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> +	if (host->sdio_int) {
> +		OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MASK |
> SDIO_INT_EN));
> +		OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MASK |
SDIO_INT_EN));
Why? It is being taken care in "enable_sdio_irq".

> +	} else {
> +		OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> +	}
> 
>  	host->response_busy = 0;
>  	if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -430,17 +440,27 @@ static irqreturn_t mmc_omap_irq(int irq, void
> *dev_id)
>  	struct mmc_data *data;
>  	int end_cmd = 0, end_trans = 0, status;
> 
> +	data = host->data;
> +	status = OMAP_HSMMC_READ(host->base, STAT);
> +	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
Why are these moved up?

> +
> +	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +		if (status & OMAP_HSMMC_CARD_INT) {
> +			dev_dbg(mmc_dev(host->mmc),
> +					" SDIO CARD interrupt status %x\n",
> +					status);
> +			mmc_signal_sdio_irq(host->mmc);
> +		}
> +	}
> +
>  	if (host->mrq == NULL) {
>  		OMAP_HSMMC_WRITE(host->base, STAT,
> -			OMAP_HSMMC_READ(host->base, STAT));
> +				OMAP_HSMMC_READ(host->base, STAT));
This just adds a tab space. Not needed.


>  		/* Flush posted write */
>  		OMAP_HSMMC_READ(host->base, STAT);
>  		return IRQ_HANDLED;
>  	}
> 
> -	data = host->data;
> -	status = OMAP_HSMMC_READ(host->base, STAT);
> -	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
Check my comment above.

> 
>  	if (status & ERR) {
>  #ifdef CONFIG_MMC_DEBUG
> @@ -932,6 +952,29 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
>  	return pdata->slots[0].get_ro(host->dev, 0);
>  }
> 
> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct mmc_omap_host *host = mmc_priv(mmc);
> +
> +	host->sdio_int = enable;
> +	if (enable) {
> +		OMAP_HSMMC_WRITE(host->base, ISE,
> +				(OMAP_HSMMC_READ(host->base, ISE) |
> +				 OMAP_HSMMC_CARD_INT));
> +		OMAP_HSMMC_WRITE(host->base, IE,
> +				(OMAP_HSMMC_READ(host->base, IE) |
> +				 OMAP_HSMMC_CARD_INT));
> +	} else {
> +		OMAP_HSMMC_WRITE(host->base, IE,
> +				(OMAP_HSMMC_READ(host->base, IE) &
> +				 (~OMAP_HSMMC_CARD_INT)));
> +		OMAP_HSMMC_WRITE(host->base, ISE,
> +				(OMAP_HSMMC_READ(host->base, ISE) &
> +				 (~OMAP_HSMMC_CARD_INT)));
> +	}
> +
> +}
> +
>  static void omap_hsmmc_init(struct mmc_omap_host *host)
>  {
>  	u32 hctl, capa, value;
> @@ -964,7 +1007,7 @@ static struct mmc_host_ops mmc_omap_ops = {
>  	.set_ios = omap_mmc_set_ios,
>  	.get_cd = omap_hsmmc_get_cd,
>  	.get_ro = omap_hsmmc_get_ro,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>  };
> 
>  static int __init omap_mmc_probe(struct platform_device *pdev)
> @@ -1011,6 +1054,7 @@ static int __init omap_mmc_probe(struct
> platform_device *pdev)
>  	host->irq	= irq;
>  	host->id	= pdev->id;
>  	host->slot_id	= 0;
> +	host->sdio_int 	= 0;
Not needed.

>  	host->mapbase	= res->start;
>  	host->base	= ioremap(host->mapbase, SZ_4K);
> 
> @@ -1080,6 +1124,10 @@ static int __init omap_mmc_probe(struct
> platform_device *pdev)
>  	else if (pdata->slots[host->slot_id].wires >= 4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> 
> +	mmc->caps |= MMC_CAP_SDIO_IRQ;
> +	OMAP_HSMMC_WRITE(host->base, CON,
> +			OMAP_HSMMC_READ(host->base, CON) | (CTPL |
CLKEXTFREE));
How about moving this to "enable_sdio_irq" so that these are done for SDIO
alone? Also can be disabled in the same fn.

Regards,
Madhusudhan
> +
>  	omap_hsmmc_init(host);
> 
>  	/* Select DMA lines */
> --
> 1.6.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


