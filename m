From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: Remove TPS65217 interrupts
Date: Wed, 4 Jan 2017 10:21:57 +0000
Message-ID: <20170104102157.GU27589@dell>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-3-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161209062833.5768-3-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 09 Dec 2016, Milo Kim wrote:

> Interrupt numbers are from the datasheet, so no need to keep them in
> the ABI. Use the number in the DT file.
> 
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi |  8 +++-----
>  include/dt-bindings/mfd/tps65217.h        | 26 --------------------------
>  2 files changed, 3 insertions(+), 31 deletions(-)
>  delete mode 100644 include/dt-bindings/mfd/tps65217.h

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I'm happy for this to go in via your respective ARM tree.

> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 14b6269..3e32dd1 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -6,8 +6,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <dt-bindings/mfd/tps65217.h>
> -
>  / {
>  	cpus {
>  		cpu@0 {
> @@ -319,13 +317,13 @@
>  	ti,pmic-shutdown-controller;
>  
>  	charger {
> -		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
> -		interrupt-names = "AC", "USB";
> +		interrupts = <0>, <1>;
> +		interrupt-names = "USB", "AC";
>  		status = "okay";
>  	};
>  
>  	pwrbutton {
> -		interrupts = <TPS65217_IRQ_PB>;
> +		interrupts = <2>;
>  		status = "okay";
>  	};
>  
> diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> deleted file mode 100644
> index cafb9e6..0000000
> --- a/include/dt-bindings/mfd/tps65217.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * This header provides macros for TI TPS65217 DT bindings.
> - *
> - * Copyright (C) 2016 Texas Instruments
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef __DT_BINDINGS_TPS65217_H__
> -#define __DT_BINDINGS_TPS65217_H__
> -
> -#define TPS65217_IRQ_USB	0
> -#define TPS65217_IRQ_AC		1
> -#define TPS65217_IRQ_PB		2
> -
> -#endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
