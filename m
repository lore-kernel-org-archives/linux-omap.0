From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 03/16] ARM: dts: omap3-igep: Update onenand node timings
Date: Tue, 14 Nov 2017 17:12:28 +0200
Message-ID: <60c45fea-0eaf-8860-a31e-ff962da581a8@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111211831.hj7rynxwo6hx6hox@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211831.hj7rynxwo6hx6hox@lenoch>
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
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:18, Ladislav Michl wrote:
> Update node timings to be compatible with actual chip used -
> gpmc_cs_show_timings utilized to dump values.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  Changes:
>  -v4: new patch
> 
>  arch/arm/boot/dts/omap3-igep.dtsi | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index 4929ba1cb9d3..1e4b8d5c7572 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -144,32 +144,32 @@
>  		gpmc,sync-read;
>  		gpmc,sync-write;
>  		gpmc,burst-length = <16>;
> -		gpmc,burst-read;
>  		gpmc,burst-wrap;
> +		gpmc,burst-read;
>  		gpmc,burst-write;
>  		gpmc,device-width = <2>; /* GPMC_DEVWIDTH_16BIT */
>  		gpmc,mux-add-data = <2>; /* GPMC_MUX_AD */
>  		gpmc,cs-on-ns = <0>;
> -		gpmc,cs-rd-off-ns = <87>;
> -		gpmc,cs-wr-off-ns = <87>;
> +		gpmc,cs-rd-off-ns = <96>;
> +		gpmc,cs-wr-off-ns = <96>;
>  		gpmc,adv-on-ns = <0>;
> -		gpmc,adv-rd-off-ns = <10>;
> -		gpmc,adv-wr-off-ns = <10>;
> -		gpmc,oe-on-ns = <15>;
> -		gpmc,oe-off-ns = <87>;
> +		gpmc,adv-rd-off-ns = <12>;
> +		gpmc,adv-wr-off-ns = <12>;
> +		gpmc,oe-on-ns = <18>;
> +		gpmc,oe-off-ns = <96>;
>  		gpmc,we-on-ns = <0>;
> -		gpmc,we-off-ns = <87>;
> -		gpmc,rd-cycle-ns = <112>;
> -		gpmc,wr-cycle-ns = <112>;
> -		gpmc,access-ns = <81>;
> -		gpmc,page-burst-access-ns = <15>;
> +		gpmc,we-off-ns = <96>;
> +		gpmc,rd-cycle-ns = <114>;
> +		gpmc,wr-cycle-ns = <114>;
> +		gpmc,access-ns = <90>;
> +		gpmc,page-burst-access-ns = <12>;
>  		gpmc,bus-turnaround-ns = <0>;
>  		gpmc,cycle2cycle-delay-ns = <0>;
>  		gpmc,wait-monitoring-ns = <0>;
> -		gpmc,clk-activation-ns = <5>;
> +		gpmc,clk-activation-ns = <6>;
>  		gpmc,wr-data-mux-bus-ns = <30>;
> -		gpmc,wr-access-ns = <81>;
> -		gpmc,sync-clk-ps = <15000>;
> +		gpmc,wr-access-ns = <90>;
> +		gpmc,sync-clk-ps = <12000>;
>  
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
