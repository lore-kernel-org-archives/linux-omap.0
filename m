From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 16/16] ARM: dts: Nokia: Use R/B pin
Date: Tue, 14 Nov 2017 13:42:56 -0800
Message-ID: <20171114214256.GG28152@atomide.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212939.jcf26v3w26bd7sn7@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171111212939.jcf26v3w26bd7sn7@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171111 21:31]:
> Enable use of R/B pin. This is just experimental placeholder patch
> as it lacks pinmux settings.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v4: new patch
> 
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 +---
>  arch/arm/boot/dts/omap3-n900.dts            | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> index 843f6a2f5e29..cfe5d02ea0ed 100644
> --- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> +++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> @@ -42,14 +42,12 @@
>  
>  &gpmc {
>  	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
> -
> -	/* gpio-irq for dma: 26 */
> -
>  	onenand@0,0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "ti,omap2-onenand";
>  		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> +		rb-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
>  
>  		gpmc,sync-read;
>  		gpmc,burst-length = <16>;


This should be then <&gpio1 26 GPIO_ACTIVE_HIGH>, there is no &gpio0. This
will produce a build error too.

> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index aa5b1a439564..718116d9f4ac 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -840,6 +840,7 @@
>  		#size-cells = <1>;
>  		compatible = "ti,omap2-onenand";
>  		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> +		rb-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
>  
>  		gpmc,sync-read;
>  		gpmc,sync-write;

This worked for me on n900, I'm currently unable to test n8x0.
But might be worth double checking if &gpio3 is correct here?

Regards,

Tony

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
