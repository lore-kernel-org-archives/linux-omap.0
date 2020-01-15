From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 11/11] mmc: sdhci-omap: Add am335x and am437x specific
 compatibles
Date: Wed, 15 Jan 2020 14:14:28 +0200
Message-ID: <7714819c-f850-082e-6ab4-be1ab3b8a248@intel.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-12-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200106110133.13791-12-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 6/01/20 1:01 pm, Faiz Abbas wrote:
> Add support for new compatible for TI's am335x and am437x devices.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 34df30edd450..4d7026daa8cd 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -919,6 +919,14 @@ static const struct sdhci_omap_data k2g_data = {
>  	.offset = 0x200,
>  };
>  
> +static const struct sdhci_omap_data am335_data = {
> +	.offset = 0x200,
> +};
> +
> +static const struct sdhci_omap_data am437_data = {
> +	.offset = 0x200,
> +};
> +
>  static const struct sdhci_omap_data dra7_data = {
>  	.offset = 0x200,
>  	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
> @@ -927,6 +935,8 @@ static const struct sdhci_omap_data dra7_data = {
>  static const struct of_device_id omap_sdhci_match[] = {
>  	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
>  	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
> +	{ .compatible = "ti,am335-sdhci", .data = &am335_data },
> +	{ .compatible = "ti,am437-sdhci", .data = &am437_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, omap_sdhci_match);
> 
