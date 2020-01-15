From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 04/11] mmc: sdhci-omap: Add using external dma
Date: Wed, 15 Jan 2020 14:02:25 +0200
Message-ID: <8c364afb-2a3a-3b5b-1f97-4c0a60c182b8@intel.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-5-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200106110133.13791-5-faiz_abbas-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 6/01/20 1:01 pm, Faiz Abbas wrote:
> From: Chunyan Zhang <zhang.chunyan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> sdhci-omap can support both external dma controller via dmaengine framework
> as well as ADMA which standard SD host controller provides.
> 
> Fixes by Faiz Abbas <fazi_abbas-l0cyMroinI0@public.gmane.org>:
> 1. Switch to DMA slave mode when using external DMA
> 2. Add offset to mapbase
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/Kconfig      |  1 +
>  drivers/mmc/host/sdhci-omap.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index adef971582a1..2c0d90b9383e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1010,6 +1010,7 @@ config MMC_SDHCI_OMAP
>  	depends on MMC_SDHCI_PLTFM && OF
>  	select THERMAL
>  	imply TI_SOC_THERMAL
> +	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's DRA7 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 083e7e053c95..84d85aa743da 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -685,7 +685,11 @@ static int sdhci_omap_enable_dma(struct sdhci_host *host)
>  	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>  
>  	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> -	reg |= CON_DMA_MASTER;
> +	reg &= ~CON_DMA_MASTER;
> +	/* Switch to DMA slave mode when using external DMA */
> +	if (!host->use_external_dma)
> +		reg |= CON_DMA_MASTER;
> +
>  	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
>  
>  	return 0;
> @@ -1037,6 +1041,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	struct sdhci_omap_data *data;
>  	const struct soc_device_attribute *soc;
> +	struct resource *regs;
>  
>  	match = of_match_device(omap_sdhci_match, dev);
>  	if (!match)
> @@ -1049,6 +1054,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	}
>  	offset = data->offset;
>  
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs)
> +		return -ENXIO;
> +
>  	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
>  				sizeof(*omap_host));
>  	if (IS_ERR(host)) {
> @@ -1065,6 +1074,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	omap_host->timing = MMC_TIMING_LEGACY;
>  	omap_host->flags = data->flags;
>  	host->ioaddr += offset;
> +	host->mapbase = regs->start + offset;
>  
>  	mmc = host->mmc;
>  	sdhci_get_of_property(pdev);
> @@ -1134,6 +1144,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
>  	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
>  
> +	/* Switch to external DMA only if there is the "dmas" property */
> +	if (of_find_property(dev->of_node, "dmas", NULL))
> +		sdhci_switch_external_dma(host, true);
> +
>  	ret = sdhci_setup_host(host);
>  	if (ret)
>  		goto err_put_sync;
> 
