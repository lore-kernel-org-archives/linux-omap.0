From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: Add remote-wakeup-connected for omap OHCI
Date: Thu, 18 May 2017 12:28:39 +0300
Message-ID: <4549017d-4031-a53c-6649-34e364be9330@ti.com>
References: <20170517225922.17723-1-tony@atomide.com>
 <20170517225922.17723-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170517225922.17723-5-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 18/05/17 01:59, Tony Lindgren wrote:
> Add remote-wakeup-connected for omap OHCI as that's needed by
> ehci-platform driver.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/boot/dts/omap3.dtsi | 1 +
>  arch/arm/boot/dts/omap4.dtsi | 1 +
>  arch/arm/boot/dts/omap5.dtsi | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -715,6 +715,7 @@
>  				reg = <0x48064400 0x400>;
>  				interrupt-parent = <&intc>;
>  				interrupts = <76>;
> +				remote-wakeup-connected;
>  			};
>  
>  			usbhsehci: ehci@48064800 {
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -863,6 +863,7 @@
>  				reg = <0x4a064800 0x400>;
>  				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +				remote-wakeup-connected;
>  			};
>  
>  			usbhsehci: ehci@4a064c00 {
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -939,6 +939,7 @@
>  				compatible = "ti,ohci-omap3";
>  				reg = <0x4a064800 0x400>;
>  				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +				remote-wakeup-connected;
>  			};
>  
>  			usbhsehci: ehci@4a064c00 {
> 

-- 
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
