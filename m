From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Mon, 31 Mar 2008 23:45:21 +0300
Message-ID: <47F14D61.5030109@indt.org.br>
References: <20080331014640.GA14188@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62652 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbYCaUrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 16:47:09 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2VKkuNZ030758
	for <linux-omap@vger.kernel.org>; Mon, 31 Mar 2008 23:47:07 +0300
In-Reply-To: <20080331014640.GA14188@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello Seth,
    It's fine and work for 3430! Maybe you should resend changing the 
commit message. It's too big.

Remove "RFC" from subject.

What do you think?

if(changes)
    Acked-by: Francisco Alecrim <francisco.alecrim@indt.org.br>


ext Seth Forshee wrote:
> This patch contains some fixes for the 1.8V MMC2 interface on the OMAP
> 2430/3430 that I had submitted for comment in a previous patch, this time
> leaving out the device configuration in deference to the other patch submitted
> for this purpose (once it has been resubmitted).  These fixes were necessary
> for me to use MMC2 with an OMAP2430.  I don't know about applicability to the
> 3430 however, thus I am sending again for comment.
>   
^^^
Suggestion: "Fix for the 1.8V MMC2 on the OMAP 2430/3430."
> Cheers,
> Seth
>
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017
Mobile: +55 92 9152-7000

