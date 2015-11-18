From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
Date: Wed, 18 Nov 2015 14:15:38 +0000
Message-ID: <20151118141537.GC10644@leverpostej>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447855315-419-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, slash.tmp-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 18, 2015 at 04:01:55PM +0200, Grygorii Strashko wrote:
> Keep ARM TWD and Global timer's nodes disabled by default - if someone
> would like to use them then those nodes have to be enabled explicitly
> in board file.
> 
> The reason for this change is:
> - ARM TWD is not always-on timer on am437x and it will stop in low
>   CPUIdle states and, therefore, broadcast timer has to configured
>   properly if CPU_IDLE=y.
> - ARM Global timer is not always-on timer on am437x and it can't be
>   used as clocksource device if CPU_IDLE=y.

I don't understand. What timer do you use in the absence of a TWD, and
if it is better why is it not used even if TWD is present?

> - ARM Global timer driver doesn't support CPUfreq now.

Surely that should be fixed in the driver (e.g. make it fail to probe if
CPUfreq is present)? It's broken for any other users too...

Mark.

> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index d83ff9c..11376e3 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -75,6 +75,7 @@
>  		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
>  		clocks = <&dpll_mpu_m2_ck>;
> +		status = "disabled";
>  	};
>  
>  	local_timer: timer@48240600 {
> @@ -83,6 +84,7 @@
>  		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
>  		clocks = <&dpll_mpu_m2_ck>;
> +		status = "disabled";
>  	};
>  
>  	l2-cache-controller@48242000 {
> -- 
> 2.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
