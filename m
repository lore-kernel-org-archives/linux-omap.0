From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP2+: remove uses of obsolete
 gpmc,device-nand
Date: Fri, 18 Apr 2014 15:41:15 -0700
Message-ID: <20140418224115.GL21823@atomide.com>
References: <1396948817-29362-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396948817-29362-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140408 02:25]:
> Remove all remaining uses of gpmc,device-nand that have been added since
> the property was removed by commit f40739faba8e ("ARM: dts: OMAP2+:
> Simplify NAND support").

Thanks applying into omap-for-v3.15/fixes.

Tony
 
> Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-igep0033.dtsi  | 1 -
>  arch/arm/boot/dts/omap3-devkit8000.dts  | 1 -
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
> index 7063311a58d9..06c822a48b71 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -118,7 +118,6 @@
>  		reg = <0 0 0>; /* CS0, offset 0 */
>  		nand-bus-width = <8>;
>  		ti,nand-ecc-opt = "bch8";
> -		gpmc,device-nand = "true";
>  		gpmc,device-width = <1>;
>  		gpmc,sync-clk-ps = <0>;
>  		gpmc,cs-on-ns = <0>;
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index bf5a515a3247..da402f0fdab4 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -112,7 +112,6 @@
>  		reg = <0 0 0>; /* CS0, offset 0 */
>  		nand-bus-width = <16>;
>  
> -		gpmc,device-nand;
>  		gpmc,sync-clk-ps = <0>;
>  		gpmc,cs-on-ns = <0>;
>  		gpmc,cs-rd-off-ns = <44>;
> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> index 6369d9f43ca2..cc1dce6978f5 100644
> --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> @@ -368,7 +368,6 @@
>  		/* no elm on omap3 */
>  
>  		gpmc,mux-add-data = <0>;
> -		gpmc,device-nand;
>  		gpmc,device-width = <2>;
>  		gpmc,wait-pin = <0>;
>  		gpmc,wait-monitoring-ns = <0>;
> -- 
> 1.8.3.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
