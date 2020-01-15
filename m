From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 09/11] mmc: sdhci-omap: Add ti,needs-special-reset
 property
Date: Wed, 15 Jan 2020 14:14:05 +0200
Message-ID: <df86859f-de3b-4419-02be-870b29b13a7a@intel.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-10-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200106110133.13791-10-faiz_abbas-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 6/01/20 1:01 pm, Faiz Abbas wrote:
> Some omap controllers need software to monitor a 0->1->0 for software
> reset. Add a ti,needs-special-reset property to indicate this and use
> the special_reset member to indicate when a controller needs this.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 1f05c8e98d62..34df30edd450 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -107,6 +107,7 @@ struct sdhci_omap_host {
>  	struct pinctrl		*pinctrl;
>  	struct pinctrl_state	**pinctrl_state;
>  	bool			is_tuning;
> +	bool			special_reset;
>  };
>  
>  static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
> @@ -779,15 +780,35 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_omap_start_clock(omap_host);
>  }
>  
> +#define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
>  static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long limit = MMC_TIMEOUT_US;
> +	unsigned long i = 0;
>  
>  	/* Don't reset data lines during tuning operation */
>  	if (omap_host->is_tuning)
>  		mask &= ~SDHCI_RESET_DATA;
>  
> +	if (omap_host->special_reset) {
> +		sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +		while ((!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)) &&
> +		       (i++ < limit))
> +			udelay(1);
> +		i = 0;
> +		while ((sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) &&
> +		       (i++ < limit))
> +			udelay(1);
> +
> +		if (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)
> +			dev_err(mmc_dev(host->mmc),
> +				"Timeout waiting on controller reset in %s\n",
> +				__func__);
> +		return;
> +	}
> +
>  	sdhci_reset(host, mask);
>  }
>  
> @@ -1107,6 +1128,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	if (!mmc_can_gpio_ro(mmc))
>  		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
>  
> +	if (of_find_property(dev->of_node, "ti,needs-special-reset", NULL))
> +		omap_host->special_reset = true;
> +
>  	pltfm_host->clk = devm_clk_get(dev, "fck");
>  	if (IS_ERR(pltfm_host->clk)) {
>  		ret = PTR_ERR(pltfm_host->clk);
> 
