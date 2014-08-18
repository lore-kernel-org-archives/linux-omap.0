From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: fix interrupt-cells for GPIO
Date: Mon, 18 Aug 2014 13:46:11 -0500
Message-ID: <53F249F3.9070402@ti.com>
References: <1406748032-19417-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406748032-19417-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, inux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2014 02:20 PM, Nishanth Menon wrote:
> GPIO modules are also interrupt sources. However, they require both the
> GPIO number and IRQ type to function properly.
> 
> By declaring that GPIO uses interrupt-cells=<1>, we essentially do not
> allow users of the nodes to use the interrupt property appropritely.
> 
> With this change, the following now works:
> 
> interrupt-parent = <&gpio6>;
> interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> 
> Fixes: 6e58b8f1daaf ('ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board')
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> Based on v3.16-rc7
> 
>  arch/arm/boot/dts/dra7.dtsi |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Tony,
Gentle ping. we still have this issue on 3.17-rc1. any suggestions on
if we can pick this up during RC?

> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 8012763..f21ef39 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -172,7 +172,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio2: gpio@48055000 {
> @@ -183,7 +183,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio3: gpio@48057000 {
> @@ -194,7 +194,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio4: gpio@48059000 {
> @@ -205,7 +205,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio5: gpio@4805b000 {
> @@ -216,7 +216,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio6: gpio@4805d000 {
> @@ -227,7 +227,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio7: gpio@48051000 {
> @@ -238,7 +238,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		gpio8: gpio@48053000 {
> @@ -249,7 +249,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		uart1: serial@4806a000 {
> 


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
