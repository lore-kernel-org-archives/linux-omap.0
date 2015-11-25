From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/14] ARM: am437x: cm-t43: dts: add basic support for
 sbc-t43
Date: Wed, 25 Nov 2015 17:03:00 -0600
Message-ID: <20151125230300.GA23057@rob-hp-laptop>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-2-git-send-email-nikita@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448371155-17307-2-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 24, 2015 at 03:19:02PM +0200, Nikita Kiryanov wrote:
> Add basic support for SBC-T43: a CM-T43 based single board computer.
> CM-T43 is an AM437x based System-on-Module designed to serve as a building
> block in embedded applications. SBC-T43 is composed of CM-T43 module on
> top of the SB-SOM-T43 baseboard.
> Basic support includes UART, GPIO, and I2C.
> 
> Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>

Some minor nits below, otherwise:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |  6 ++
>  arch/arm/boot/dts/Makefile                         |  6 +-
>  arch/arm/boot/dts/am437x-cm-t43.dts                | 90 ++++++++++++++++++++++
>  arch/arm/boot/dts/am437x-sbc-t43.dts               | 57 ++++++++++++++
>  4 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
>  create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 9f4e513..da84372 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -141,6 +141,12 @@ Boards:
>  - OMAP5 EVM : Evaluation Module
>    compatible = "ti,omap5-evm", "ti,omap5"
>  
> +- AM437x CM-T43
> +  compatible = "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
> +
> +- AM437x SBC-T43
> +  compatible = "compulab,am437x-sbc-t43","compulab,am437x-cm-t43","ti,am4372","ti,am43"
                                            ^
spaces

> +
>  - AM43x EPOS EVM
>    compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 30bbc37..dc3b9af 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -478,9 +478,11 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
>  	omap4-var-stk-om44.dtb
>  dtb-$(CONFIG_SOC_AM43XX) += \
>  	am43x-epos-evm.dtb \
> -	am437x-sk-evm.dtb \
> +	am437x-cm-t43.dtb \
> +	am437x-gp-evm.dtb \
>  	am437x-idk-evm.dtb \
> -	am437x-gp-evm.dtb
> +	am437x-sbc-t43.dtb \
> +	am437x-sk-evm.dtb
>  dtb-$(CONFIG_SOC_OMAP5) += \
>  	omap5-cm-t54.dtb \
>  	omap5-igep0050.dtb \
> diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
> new file mode 100644
> index 0000000..69887c4
> --- /dev/null
> +++ b/arch/arm/boot/dts/am437x-cm-t43.dts
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/am43xx.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "am4372.dtsi"
> +
> +/ {
> +	model = "CompuLab CM-T43";
> +	compatible = "compulab,am437x-cm-t43","ti,am4372","ti,am43";
                                              ^
space

[...]

> diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
> new file mode 100644
> index 0000000..f3cd76b
> --- /dev/null
> +++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
> @@ -0,0 +1,57 @@
> +/*
> + * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "am437x-cm-t43.dts"
> +
> +/ {
> +	model = "CompuLab CM-T43 on SB-SOM-T43";
> +	compatible = "compulab,am437x-sbc-t43","compulab,am437x-cm-t43","ti,am4372","ti,am43";

spaces

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
