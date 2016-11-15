From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev
 device
Date: Tue, 15 Nov 2016 09:35:15 -0800
Message-ID: <20161115173515.GL4082@atomide.com>
References: <3071466.kDDk30H73u@corpeters>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3071466.kDDk30H73u@corpeters>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org> [161115 01:00]:
> This patch adds the PRM_DEV as a syscon compatible device to
> am33xx.dtsi. This is needed for the watchdog bootstatus patch.

We somehow need to see the bootreason for sure.. But we need to
check with Tero on the reset driver work too.

Tero, does setting up of PRM_DEVICE as syscon cause issues for
your reset driver work?

Regards,

Tony

> 
> Signed-off-by: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 194d884..e8faf19 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -115,6 +115,7 @@
>                         prcm: prcm@200000 {
>                                 compatible = "ti,am3-prcm";
>                                 reg = <0x200000 0x4000>;
> +                               ranges = <0 0x200000 0x4000>;
>  
>                                 prcm_clocks: clocks {
>                                         #address-cells = <1>;
> @@ -123,6 +124,11 @@
>  
>                                 prcm_clockdomains: clockdomains {
>                                 };
> +
> +                               prcm_wkup: prcm-wkup@f00 {
> +                                       compatible = "ti,omap3-prcm-dev", "syscon";
> +                                       reg = <0xf00 0xff>;
> +                               };
>                         };
>  
>                         scm: scm@210000 {
> -- 
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
