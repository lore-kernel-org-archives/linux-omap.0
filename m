From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
Date: Tue, 22 Nov 2016 15:57:59 +0000
Message-ID: <20161122155759.GG10134@dell.home>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121131515.8040-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 21 Nov 2016, Milo Kim wrote:

> AC and USB interrupts are related with external power input.
> PB interrupt means push button pressed or released event.
> Use better human readable definitions.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++--
>  include/dt-bindings/mfd/tps65217.h        | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index dc561d5..1848d58 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -319,13 +319,13 @@
>  	ti,pmic-shutdown-controller;
>  
>  	charger {
> -		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
> +		interrupts = <TPS65217_IRQ_AC_POWER>, <TPS65217_IRQ_USB_POWER>;
>  		interrupts-names = "AC", "USB";
>  		status = "okay";
>  	};
>  
>  	pwrbutton {
> -		interrupts = <TPS65217_IRQ_PB>;
> +		interrupts = <TPS65217_IRQ_PUSHBUTTON>;

Push button or power button?

>  		status = "okay";
>  	};
>  
> diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> index cafb9e6..0293fdd 100644
> --- a/include/dt-bindings/mfd/tps65217.h
> +++ b/include/dt-bindings/mfd/tps65217.h
> @@ -19,8 +19,8 @@
>  #ifndef __DT_BINDINGS_TPS65217_H__
>  #define __DT_BINDINGS_TPS65217_H__
>  
> -#define TPS65217_IRQ_USB	0
> -#define TPS65217_IRQ_AC		1
> -#define TPS65217_IRQ_PB		2
> +#define TPS65217_IRQ_USB_POWER		0	/* USB power state change */
> +#define TPS65217_IRQ_AC_POWER		1	/* AC power state change */
> +#define TPS65217_IRQ_PUSHBUTTON		2	/* Push button state change */

This changes the ABI.

It will require a DT Ack.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
