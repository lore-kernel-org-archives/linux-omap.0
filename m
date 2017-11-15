From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Wed, 15 Nov 2017 12:56:08 +0200
Message-ID: <698b35f4-71e1-b5d6-ebc5-37c027325d12@ti.com>
References: <20171111211656.neoypp7gdyfasteg@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211656.neoypp7gdyfasteg@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:16, Ladislav Michl wrote:
> Compatible property is required for OMAP2+ mtd driver. Also
> add R/B pin gpio description and delete unused dma-channel
> property.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v4: new patch
> 
>  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> index b6e8bfd024f4..9d7b1409deab 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>  
>  Required properties:
>  
> + - compatible:		"ti,omap2-onenand"
>   - reg:			The CS line the peripheral is connected to
> - - gpmc,device-width	Width of the ONENAND device connected to the GPMC
> + - gpmc,device-width:	Width of the ONENAND device connected to the GPMC
>  			in bytes. Must be 1 or 2.
>  
>  Optional properties:
>  
> - - dma-channel:		DMA Channel index
> + - rb-gpios:		GPIO specifier for the ready/busy# pin.

As agreed let's call this int-gpios as this is really the INT pin. RDY pin is something different.

Then you can add my

Acked-by: Roger Quadros <rogerq@ti.com>

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
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
