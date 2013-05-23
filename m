From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [RFC/RFT] ARM: dts: add minimal DT support for Nokia N950 & N9
Date: Thu, 23 May 2013 09:22:04 +0200
Message-ID: <519DC39C.6010809@ti.com>
References: <1369251845-29605-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53779 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3EWHWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 03:22:19 -0400
In-Reply-To: <1369251845-29605-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sakari Ailus <sakari.ailus@iki.fi>

Hi Aaro,

On 05/22/2013 09:44 PM, Aaro Koskinen wrote:
> Add minimal DT support for Nokia N950 & N9. The basic boot works. I can
> connect to both devices with USB networking & ssh. dmesg output looks OK.

That's great! Tony will like that :-)
It is too bad I just have a N900 :-(

> Functionality compared to the legacy board file:
> 
> 	- MMC not detected - reason unknown, any tips welcome

On OMAP4 panda I used to have the similar issue due to the pbias not set
properly.

> 	- OneNAND missing completely

The GPMC for OMAP3 support is pretty new, so maybe some tweak are still
needed.

Is it RFC because you are still working on the missing functionalities?
Otherwise the patches are already good to be merged if you want.
As soon as you don't break legacy boot, we can merge even half-working DTS.

Thanks,
Benoit


> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/boot/dts/Makefile           |    2 +
>  arch/arm/boot/dts/omap3-n9.dts       |   18 ++++++++
>  arch/arm/boot/dts/omap3-n950-n9.dtsi |   84 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-n950.dts     |   18 ++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-n9.dts
>  create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
>  create mode 100644 arch/arm/boot/dts/omap3-n950.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b9f7121..e7e1c82 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -144,6 +144,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-tobi.dtb \
>  	omap3-igep0020.dtb \
>  	omap3-igep0030.dtb \
> +	omap3-n9.dtb \
> +	omap3-n950.dtb \
>  	omap4-panda.dtb \
>  	omap4-panda-a4.dtb \
>  	omap4-panda-es.dtb \
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> new file mode 100644
> index 0000000..0553b33
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -0,0 +1,18 @@
> +/*
> + * omap3-n9.dts - Device Tree file for Nokia N9
> + *
> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "omap3-n950-n9.dtsi"
> +
> +/ {
> +	model = "Nokia N9";
> +	compatible = "nokia,omap3-n9", "ti,omap3";
> +};
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> new file mode 100644
> index 0000000..3f983f7
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -0,0 +1,84 @@
> +/*
> + * omap3-n950-n9.dtsi - Device Tree file for Nokia N950 & N9 (common stuff)
> + *
> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "omap36xx.dtsi"
> +
> +/ {
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply = <&vcc>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	rm6xx_vemmc: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VEMMC";
> +		regulator-min-microvolt = <2900000>;
> +		regulator-max-microvolt = <2900000>;
> +		gpio = <&gpio5 29 0>; /* gpio line 157 */
> +		startup-delay-us = <150>;
> +		enable-active-high;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <2900000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +	};
> +};
> +
> +/include/ "twl4030.dtsi"
> +
> +&twl {
> +	compatible = "ti,twl5031";
> +};
> +
> +&twl_gpio {
> +	ti,pullups	= <0x000001>; /* BIT(0) */
> +	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +};
> +
> +&mmc1 {
> +	status = "disabled";
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&rm6xx_vemmc>;
> +	bus-width = <4>;
> +	ti,non-removable;
> +};
> +
> +&mmc3 {
> +	status = "disabled";
> +};
> +
> +&usb_otg_hs {
> +	interface-type = <0>;
> +	usb-phy = <&usb2_phy>;
> +	mode = <3>;
> +	power = <50>;
> +};
> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
> new file mode 100644
> index 0000000..25fd9ec
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -0,0 +1,18 @@
> +/*
> + * omap3-n950.dts - Device Tree file for Nokia N950
> + *
> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "omap3-n950-n9.dtsi"
> +
> +/ {
> +	model = "Nokia N950";
> +	compatible = "nokia,omap3-n950", "ti,omap3";
> +};
> 

