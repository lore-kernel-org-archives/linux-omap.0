From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/18] ARM: am57xx: sbc-am57x: dts: add basic board
 support
Date: Wed, 25 Nov 2015 14:05:59 -0600
Message-ID: <20151125200559.GE30473@rob-hp-laptop>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-12-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448433590-1399-12-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 25, 2015 at 08:39:43AM +0200, Dmitry Lifshitz wrote:
> SBC-AM57x is a single board computer designed for industrial and
> embedded applications. It is based on the Texas Instruments Sitara AM57x
> system-on-chip family. SBC-AM57x is implemented with the CL-SOM-AM57x
> computer-on-module providing most of the functions, and SB-SOM-AM57x
> carrier board providing additional peripheral functions and connectors.
> 
> https://www.compulab.co.il/products/sbcs/sbc-am57x-ti-am5728-am5718-single-board-computer/
> 
> https://www.compulab.co.il/products/computer-on-modules/cl-som-am57x-ti-am5728-am5718-system-on-module/
> 
> Add basic board support, including UART3, used as a serial console.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |  3 ++
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/am57xx-sbc-am57x.dts             | 36 ++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am57xx-sbc-am57x.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index dd53c90..42cdad1 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -159,6 +159,9 @@ Boards:
>  - AM57XX CL-SOM-AM57x
>    compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> +- AM57XX SBC-AM57x
> +  compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> +
>  - DRA742 EVM:  Software Development Board for DRA742
>    compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 803a020..4c73ab9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -479,6 +479,7 @@ dtb-$(CONFIG_SOC_OMAP5) += \
>  dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-cl-som-am57x.dtb \
> +	am57xx-sbc-am57x.dtb \
>  	dra7-evm.dtb \
>  	dra72-evm.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += \
> diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
> new file mode 100644
> index 0000000..804ad72
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
> @@ -0,0 +1,36 @@
> +/*
> + * Support for CompuLab SBC-AM57x single board computer
> + *
> + * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
> + * Author: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include "am57xx-cl-som-am57x.dts"
> +#include "compulab-sb-som.dtsi"
> +
> +/ {
> +	model = "CompuLab CL-SOM-AM57x on SB-SOM-AM57x";
> +	compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
> +};
> +
> +&dra7_pmx_core {
> +	uart3_pins_default: uart3_pins_default {
> +		pinctrl-single,pins = <
> +			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT_SLEW | MUX_MODE2)	/* uart2_ctsn.uart3_rxd */
> +			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1)	/* uart2_rtsn.uart3_txd */
> +		>;
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&dra7_pmx_core 0x3f8>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins_default>;
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
