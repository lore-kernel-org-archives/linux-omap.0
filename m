From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM/dts: omap3: Add support for IGEPv2 board
Date: Fri, 30 Nov 2012 10:48:37 +0100
Message-ID: <50B880F5.9060607@gmail.com>
References: <1354144466-750-1-git-send-email-javier.martinez@collabora.co.uk>
 <1354144466-750-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354144466-750-3-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enrico Butera <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/29/2012 12:14 AM, Javier Martinez Canillas wrote:
> ISEE IGEPv2 is an TI OMAP3 SoC based embedded board.
>
> This patch adds an initial device tree support to boot
> an IGEPv2 from the MMC/SD.
>
> Currently is working everything that is supported by DT
> on OMAP3 SoCs (MMC/SD, GPIO LEDs, EEPROM, TWL4030 audio).
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
Acked-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>   arch/arm/boot/dts/Makefile           |    1 +
>   arch/arm/boot/dts/omap3-igep0020.dts |   56 ++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/boot/dts/omap3-igep0020.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f37cf9f..1dc0f39 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>   	omap3-beagle-xm.dtb \
>   	omap3-evm.dtb \
>   	omap3-tobi.dtb \
> +	omap3-igep0020.dtb \
>   	omap4-panda.dtb \
>   	omap4-pandaES.dtb \
>   	omap4-var_som.dtb \
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> new file mode 100644
> index 0000000..9dd4d22
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -0,0 +1,56 @@
> +/*
> + * Device Tree Source for IGEPv2 board
> + *
> + * Copyright (C) 2012 Javier Martinez Canillas <javier-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> + * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "omap3-igep.dtsi"
> +
> +/ {
> +	model = "IGEPv2";
> +	compatible = "isee,omap3-igep0020", "ti,omap3";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		boot {
> +			 label = "omap3:green:boot";
> +			 gpios = <&gpio1 26 0>;
> +			 linux,default-trigger = "default-on";
> +		};
> +
> +		user0 {
> +			 label = "omap3:red:user0";
> +			 gpios = <&gpio1 27 0>;
> +			 default-state = "off";
> +		};
> +
> +		user1 {
> +			 label = "omap3:red:user1";
> +			 gpios = <&gpio1 28 0>;
> +			 default-state = "off";
> +		};
> +
> +		user2 {
> +			label = "omap3:green:user1";
> +			gpios = <&twl_gpio 19 1>;
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +
> +	/*
> +	 * Display monitor features are burnt in the EEPROM
> +	 * as EDID data.
> +	 */
> +	eeprom@50 {
> +		compatible = "ti,eeprom";
> +		reg = <0x50>;
> +	};
> +};
>
