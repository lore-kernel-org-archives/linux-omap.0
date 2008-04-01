From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: [PATCH] OMAP: HSMMC: Fix 1.8V MMC2 host on OMAP2430/3430
Date: Tue, 01 Apr 2008 05:29:25 +0300
Message-ID: <47F19E05.7010409@indt.org.br>
References: <20080401013418.GA24856@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45083 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbYDAC32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 22:29:28 -0400
In-Reply-To: <20080401013418.GA24856@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Acked-by : Francisco Alecrim <francisco.alecrim@indt.org.br>

ext Seth Forshee wrote:
> OMAP2430/3430 contain an 1.8V-only MMC2 host that is not properly
> supported by the current driver.  This patch contains changes to
> correctly set up this host.
>
> Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
> Acked-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   32 ++++++++++++++++++++++++++------
>  1 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 248257f..d5d82a8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -388,8 +388,12 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
>  	 * If a MMC dual voltage card is detected, the set_ios fn calls
>  	 * this fn with VDD bit set for 1.8V. Upon card removal from the
>  	 * slot, mmc_omap_detect fn sets the VDD back to 3V.
> +	 *
> +	 * Only MMC1 supports 3.0V.  MMC2 will not function if SDVS30 is
> +	 * set in HCTL.
>  	 */
> -	if (((1 << vdd) == MMC_VDD_32_33) || ((1 << vdd) == MMC_VDD_33_34))
> +	if (host->id == OMAP_MMC1_DEVID && (((1 << vdd) == MMC_VDD_32_33) ||
> +				((1 << vdd) == MMC_VDD_33_34)))
>  		reg_val |= SDVS30;
>  	if ((1 << vdd) == MMC_VDD_165_195)
>  		reg_val |= SDVS18;
> @@ -517,10 +521,16 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
>  
>  	if (!(data->flags & MMC_DATA_WRITE)) {
>  		host->dma_dir = DMA_FROM_DEVICE;
> -		sync_dev = OMAP24XX_DMA_MMC1_RX;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_RX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_RX;
>  	} else {
>  		host->dma_dir = DMA_TO_DEVICE;
> -		sync_dev = OMAP24XX_DMA_MMC1_TX;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_TX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_TX;
>  	}
>  
>  	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
> @@ -692,6 +702,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  	struct mmc_omap_host *host = NULL;
>  	struct resource *res;
>  	int ret = 0, irq;
> +	u32 hctl, capa;
>  
>  	if (pdata == NULL) {
>  		dev_err(&pdev->dev, "Platform Data is missing\n");
> @@ -778,11 +789,20 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
>  	if (pdata->conf.wire4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
>  
> +	/* Only MMC1 supports 3.0V */
> +	if (host->id == OMAP_MMC1_DEVID) {
> +		hctl = SDVS30;
> +		capa = VS30 | VS18;
> +	} else {
> +		hctl = SDVS18;
> +		capa = VS18;
> +	}
> +
>  	OMAP_HSMMC_WRITE(host->base, HCTL,
> -			OMAP_HSMMC_READ(host->base, HCTL) | SDVS30);
> +			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
>  
> -	OMAP_HSMMC_WRITE(host->base, CAPA, OMAP_HSMMC_READ(host->base,
> -							CAPA) | VS30 | VS18);
> +	OMAP_HSMMC_WRITE(host->base, CAPA,
> +			OMAP_HSMMC_READ(host->base, CAPA) | capa);
>  
>  	/* Set the controller to AUTO IDLE mode */
>  	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017
Mobile: +55 92 9152-7000

