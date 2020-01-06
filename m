From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 08/11] dt-bindings: sdhci-omap: Add documentation for
 ti,needs-special-reset property
Date: Mon, 6 Jan 2020 16:03:13 -0600
Message-ID: <20200106220313.GA6822@bogus>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-9-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106110133.13791-9-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, ulf.hansson@linaro.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 06, 2020 at 04:31:30PM +0530, Faiz Abbas wrote:
> Some controllers need a special software reset sequence. Document the
> ti,needs-special-reset binding to indicate that a controller needs this.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> index 97efb01617dd..0f5389c72bda 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -21,6 +21,7 @@ Optional properties:
>  - dma-names:	List of DMA request names. These strings correspond 1:1 with the
>  		DMA specifiers listed in dmas. The string naming is to be "tx"
>  		and "rx" for TX and RX DMA requests, respectively.
> +- ti,needs-special-reset: Requires a special softreset sequence

Why can't this be implied by the compatible string?

Rob
