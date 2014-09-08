From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Fix NAND GPMC timings (for 3.17)
Date: Mon, 8 Sep 2014 11:08:07 +0300
Message-ID: <540D63E7.7000907@ti.com>
References: <1409918662-20547-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1409918662-20547-1-git-send-email-rogerq@ti.com>
Sender: stable-owner@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This is needed for 3.17 otherwise NAND is broken on dra7-evm. Thanks.

cheers,
-roger

On 09/05/2014 03:04 PM, Roger Quadros wrote:
> The nand timings were scaled down by 2 to account for
> the 2x rate returned by clk_get_rate(gpmc_fclk).
> 
> As the clock data got fixed by [1], revert back to actual
> timings (i.e. scale them up by 2).
> 
> Without this NAND doesn't work on dra7-evm.
> 
> [1] - commit dd94324b983afe114ba9e7ee3649313b451f63ce
>     ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates
> 
> Fixes: ff66a3c86e00 ("ARM: dts: dra7: add support for parallel NAND flash")
> Cc: <stable@vger.kernel.org>        [3.16]
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 990ee6a..a120d8f 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -427,22 +427,19 @@
>  		gpmc,device-width = <2>;
>  		gpmc,sync-clk-ps = <0>;
>  		gpmc,cs-on-ns = <0>;
> -		gpmc,cs-rd-off-ns = <40>;
> -		gpmc,cs-wr-off-ns = <40>;
> +		gpmc,cs-rd-off-ns = <80>;
> +		gpmc,cs-wr-off-ns = <80>;
>  		gpmc,adv-on-ns = <0>;
> -		gpmc,adv-rd-off-ns = <30>;
> -		gpmc,adv-wr-off-ns = <30>;
> -		gpmc,we-on-ns = <5>;
> -		gpmc,we-off-ns = <25>;
> -		gpmc,oe-on-ns = <2>;
> -		gpmc,oe-off-ns = <20>;
> -		gpmc,access-ns = <20>;
> -		gpmc,wr-access-ns = <40>;
> -		gpmc,rd-cycle-ns = <40>;
> -		gpmc,wr-cycle-ns = <40>;
> -		gpmc,wait-pin = <0>;
> -		gpmc,wait-on-read;
> -		gpmc,wait-on-write;
> +		gpmc,adv-rd-off-ns = <60>;
> +		gpmc,adv-wr-off-ns = <60>;
> +		gpmc,we-on-ns = <10>;
> +		gpmc,we-off-ns = <50>;
> +		gpmc,oe-on-ns = <4>;
> +		gpmc,oe-off-ns = <40>;
> +		gpmc,access-ns = <40>;
> +		gpmc,wr-access-ns = <80>;
> +		gpmc,rd-cycle-ns = <80>;
> +		gpmc,wr-cycle-ns = <80>;
>  		gpmc,bus-turnaround-ns = <0>;
>  		gpmc,cycle2cycle-delay-ns = <0>;
>  		gpmc,clk-activation-ns = <0>;
> 
