From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: am43xx: Enable dual-role mode for USB1
Date: Mon, 22 Jan 2018 15:17:03 +0200
Message-ID: <d2c871ac-105b-2c11-747b-d430489b3cff@ti.com>
References: <1516626688-2302-1-git-send-email-rogerq@ti.com>
 <1516626688-2302-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516626688-2302-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Tony

On 22/01/18 15:11, Roger Quadros wrote:
> USB1 port is micro-AB type and can function as peripheral
> as well as host. Enable dual-role mode for USB1.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
>  arch/arm/boot/dts/am437x-sk-evm.dts  | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index afb8eb0..4aaf637 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -803,7 +803,7 @@
>  };
>  
>  &usb1 {
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 2c6bf06..096c87e 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -598,7 +598,7 @@
>  };
>  
>  &usb1 {
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&usb1_pins>;
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index a04d79e..7ee2199 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -854,7 +854,7 @@
>  };
>  
>  &usb1 {
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";
>  	status = "okay";
>  };
>  
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
