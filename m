From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP35xx : Add SDIO IRQ Support for OMAP35xx
Date: Mon, 9 Nov 2009 17:22:43 -0600
Message-ID: <00d201ca6193$89dba340$544ff780@am.dhcp.ti.com>
References: <97fbdb97-cdfc-4b00-b2c4-2893f03ce129@TX2EHSMHS024.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbZKIXWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 18:22:41 -0500
In-Reply-To: <97fbdb97-cdfc-4b00-b2c4-2893f03ce129@TX2EHSMHS024.ehs.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Phaneedra Kumar Alapati' <phani@embwise.com>, linux-omap@vger.kernel.org
Cc: 'Dirk Behme' <dirk.behme@googlemail.com>, 'Grosen Mark' <mgrosen@ti.com>, 'Gole Anant' <anantgole@ti.com>, 'Sriramakrishnan' <srk@ti.com>



> -----Original Message-----
> From: Phaneedra Kumar Alapati [mailto:phani@embwise.com]
> Sent: Friday, November 06, 2009 3:13 AM
> To: linux-omap@vger.kernel.org
> Cc: 'Madhusudhan'; 'Dirk Behme'; 'Grosen Mark'; 'Gole Anant';
> 'Sriramakrishnan'
> Subject: [PATCH] OMAP35xx : Add SDIO IRQ Support for OMAP35xx
> 
> This patch adds SDIO IRQ support for OMAP35xx. Tested on OMAP3530EVM
> with Marvell 88W8686 card and below are the observed throughput results
> (ttcp utility): 13Mbps (Downlink), 10.5 Mbps(Uplink).
> 
> Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   61
> ++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1cf9cfb..fe1a2da 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -92,6 +92,10 @@
>  #define DUAL_VOLT_OCR_BIT	7
>  #define SRC			(1 << 25)
>  #define SRD			(1 << 26)
> +#define CIRQ		(1 << 8)
> +#define CIRQ_ENABLE		(1 << 8)
> +#define CTPL			(1 << 11)
> +#define CLKEXTFREE		(1 << 16)
> 
>  /*
>   * FIXME: Most likely all the data using these _DEVID defines should come
> @@ -149,6 +153,7 @@ struct mmc_omap_host {
>  	int			slot_id;
>  	int			dbclk_enabled;
>  	int			response_busy;
> +	int			sdio_int;
>  	struct	omap_mmc_platform_data	*pdata;
>  };
> 
> @@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host *host,
> struct mmc_command *cmd,
>  	 * Clear status bits and enable interrupts
>  	 */
>  	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);

This does not look like the latest code. The driver in the LO master
configures IE under the check if(host->use_dma).How come your code does
not have that? You need to rebase your patch on the latest.

> +	if (host->sdio_int) {
> +		OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MASK |
> CIRQ_ENABLE));
> +		OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MASK |
> CIRQ_ENABLE));
> +	} else {
> +		OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> +	}
> 
>  	host->response_busy = 0;
>  	if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -430,17 +440,26 @@ static irqreturn_t mmc_omap_irq(int irq, void
> *dev_id)
>  	struct mmc_data *data;
>  	int end_cmd = 0, end_trans = 0, status;
> 
> +	data = host->data;
> +	status = OMAP_HSMMC_READ(host->base, STAT);
> +	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
> +
> +	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +		if (status & CIRQ) {
> +			dev_dbg(mmc_dev(host->mmc),
> +					" SDIO CARD interrupt\n");
> +			mmc_signal_sdio_irq(host->mmc);
> +		}
> +	}
> +
>  	if (host->mrq == NULL) {
>  		OMAP_HSMMC_WRITE(host->base, STAT,
> -			OMAP_HSMMC_READ(host->base, STAT));
> +				OMAP_HSMMC_READ(host->base, STAT));

Nope. Looks like you missed my comment on this extra tab.

>  		/* Flush posted write */
>  		OMAP_HSMMC_READ(host->base, STAT);
>  		return IRQ_HANDLED;
>  	}
> 
> -	data = host->data;
> -	status = OMAP_HSMMC_READ(host->base, STAT);
> -	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
> 
>  	if (status & ERR) {
>  #ifdef CONFIG_MMC_DEBUG
> @@ -932,6 +951,29 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
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
> +				 CIRQ_ENABLE));
> +		OMAP_HSMMC_WRITE(host->base, IE,
> +				(OMAP_HSMMC_READ(host->base, IE) |
> +				 CIRQ_ENABLE));
> +	} else {
> +		OMAP_HSMMC_WRITE(host->base, IE,
> +				(OMAP_HSMMC_READ(host->base, IE) &
> +				 (~CIRQ_ENABLE)));
> +		OMAP_HSMMC_WRITE(host->base, ISE,
> +				(OMAP_HSMMC_READ(host->base, ISE) &
> +				 (~CIRQ_ENABLE)));
> +	}
> +
> +}
> +
>  static void omap_hsmmc_init(struct mmc_omap_host *host)
>  {
>  	u32 hctl, capa, value;
> @@ -964,7 +1006,7 @@ static struct mmc_host_ops mmc_omap_ops = {
>  	.set_ios = omap_mmc_set_ios,
>  	.get_cd = omap_hsmmc_get_cd,
>  	.get_ro = omap_hsmmc_get_ro,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>  };
> 
>  static int __init omap_mmc_probe(struct platform_device *pdev)
> @@ -1011,6 +1053,7 @@ static int __init omap_mmc_probe(struct
> platform_device *pdev)
>  	host->irq	= irq;
>  	host->id	= pdev->id;
>  	host->slot_id	= 0;
> +	host->sdio_int 	= 0;
>  	host->mapbase	= res->start;
>  	host->base	= ioremap(host->mapbase, SZ_4K);
> 
> @@ -1080,6 +1123,10 @@ static int __init omap_mmc_probe(struct
> platform_device *pdev)
>  	else if (pdata->slots[host->slot_id].wires >= 4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> 
> +	mmc->caps |= MMC_CAP_SDIO_IRQ;
> +	OMAP_HSMMC_WRITE(host->base, CON,
> +			OMAP_HSMMC_READ(host->base, CON) | (CTPL |
> CLKEXTFREE));
> +
>  	omap_hsmmc_init(host);
> 
>  	/* Select DMA lines */
> --
> 1.6.3.3
> 


