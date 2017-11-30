From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Thu, 30 Nov 2017 11:25:44 +0100
Message-ID: <20171130112544.5509ca1b@bbrezillon>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
        <20171115162458.rtompijrsaobdemk@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171115162458.rtompijrsaobdemk@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Rob and the DT ML

On Wed, 15 Nov 2017 17:24:58 +0100
Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> wrote:

> Compatible property is required for OMAP2+ mtd driver. Also
> add INT pin gpio description and delete unused dma-channel
> property.
> 
> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
> 
> Changes in v5:
> - renamed R/B pin to INT pin
> 
> Changes in v4:
> - new patch
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> index b6e8bfd024f4..e9f01a963a0a 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>  
>  Required properties:
>  
> + - compatible:		"ti,omap2-onenand"

Don't you break backward compat by adding this new requirement?

>   - reg:			The CS line the peripheral is connected to
> - - gpmc,device-width	Width of the ONENAND device connected to the GPMC
> + - gpmc,device-width:	Width of the ONENAND device connected to the GPMC
>  			in bytes. Must be 1 or 2.
>  
>  Optional properties:
>  
> - - dma-channel:		DMA Channel index
> + - int-gpios:		GPIO specifier for the INT pin.
>  
>  For inline partition table parsing (optional):
>  
> @@ -35,6 +36,7 @@ Example for an OMAP3430 board:
>  		#size-cells = <1>;
>  
>  		onenand@0 {
> +			compatible = "ti,omap2-onenand";
>  			reg = <0 0 0>; /* CS0, offset 0 */
>  			gpmc,device-width = <2>;
>  

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
