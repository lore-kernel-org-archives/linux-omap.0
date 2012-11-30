From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM/dts: omap3: Add generic DT support for IGEP
 devices
Date: Fri, 30 Nov 2012 10:48:04 +0100
Message-ID: <50B880D4.9050906@gmail.com>
References: <1354144466-750-1-git-send-email-javier.martinez@collabora.co.uk>
 <1354144466-750-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354144466-750-2-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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
> Add a generic .dtsi device tree source file for the
> common characteristics across IGEP Technology devices.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
Acked-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>   arch/arm/boot/dts/omap3-igep.dtsi |   93 +++++++++++++++++++++++++++++++++++++
>   1 files changed, 93 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/boot/dts/omap3-igep.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> new file mode 100644
> index 0000000..a093bff
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -0,0 +1,93 @@
> +/*
> + * Device Tree Source for IGEP Technology devices
> + *
> + * Copyright (C) 2012 Javier Martinez Canillas <javier-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> + * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	sound {
> +		compatible = "ti,omap-twl4030";
> +		ti,model = "igep2";
> +		ti,mcbsp = <&mcbsp2>;
> +		ti,codec = <&twl_audio>;
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		  &mcbsp2_pins
> +	>;
> +
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e 0x100	/* uart3_rx.uart3_rx INPUT | MODE0 */
> +			0x170 0		/* uart3_tx.uart3_tx OUTPUT | MODE0 */
> +		>;
> +	};
> +
> +	mcbsp2_pins: pinmux_mcbsp2_pins {
> +		pinctrl-single,pins = <
> +			0x1a2 0x0104	/* mcspi1_cs2.gpio_176 INPUT | MODE4 */
> +		>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		vsim: regulator@10 {
> +			compatible = "ti,twl4030-vsim";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3000000>;
> +		};
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +			codec {
> +			      };
> +		};
> +	};
> +};
> +
> +/include/ "twl4030.dtsi"
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmc1>;
> +	vmmc_aux-supply = <&vsim>;
> +	bus-width = <8>;
> +};
> +
> +&mmc2 {
> +	status = "disabled";
> +};
> +
> +&mmc3 {
> +	status = "disabled";
> +};
> +
> +&twl_gpio {
> +	ti,use-leds;
> +};
>
