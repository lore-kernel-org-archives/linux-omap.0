From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 3/7] ARM: dts: am437x: Fix GPMC dma properties
Date: Fri, 11 Mar 2016 15:56:43 +0200
Message-ID: <56E2CE9B.8010503@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457654203-20856-4-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

+Peter

On 11/03/16 01:56, Franklin S Cooper Jr wrote:
> This patch updates the GPMC's DT DMA property to reflect the updated eDMA
> bindings.
> 
> Fixes: cce1ee000187 ("ARM: DTS: am437x: Use the new DT bindings for the eDMA3")
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
> Version 4 changes:
> Split into its own commit. Use proper Fixes syntax.
> 
>  arch/arm/boot/dts/am4372.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 92068fb..2878b04 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -884,7 +884,7 @@
>  		gpmc: gpmc@50000000 {
>  			compatible = "ti,am3352-gpmc";
>  			ti,hwmods = "gpmc";
> -			dmas = <&edma 52>;
> +			dmas = <&edma 52 0>;
>  			dma-names = "rxtx";
>  			clocks = <&l3s_gclk>;
>  			clock-names = "fck";
> 
