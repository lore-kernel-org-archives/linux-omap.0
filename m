From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] arm/dts: Add omap3-beagle.dts
Date: Tue, 11 Sep 2012 13:29:16 +0200
Message-ID: <504F208C.8030507@ti.com>
References: <1347317870-13419-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042Ab2IKL3Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 07:29:24 -0400
In-Reply-To: <1347317870-13419-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 09/11/2012 12:57 AM, Jon Hunter wrote:
> Add a minimal dts for original OMAP3430/3530 version of the Beagle board. This
> version of the Beagle board has 256MB of DDR and features the same TWL4030
> power management IC (PMIC) as the Beagle board XM.

Thanks for the patch.

> Given that the Beagle and Beagle-XM boards use the same PMIC, move the
> definition of the VSIM regulator into the TWL4030.dtsi file so that we do not
> need to duplicate in the Beagle board dts file.

Good, catch, regulator definition has indeed nothing to do outside the
twl4030.dtsi.

> This has been boot tested on an OMAP3530 Beagle board and verifing that the
> SD/MMC interface is working with a SD card.
> 
> This patch is generated on top of Tony's patch for adding the Beagle board XM
> dts file [1].

Tony has just updated his devel-dt with the DTS series I pushed plus the
beagle-xm introduction, so I'm gonna put this one on top and built a
for_3.7/dts_part2 branch sinec there are a couplf of USB / AM33xx pending.

Thanks,
Benoit

> [1] http://marc.info/?l=linux-omap&m=134695790516943&w=2
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts |    6 -----
>  arch/arm/boot/dts/omap3-beagle.dts    |   46 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/twl4030.dtsi        |    6 +++++
>  arch/arm/mach-omap2/Makefile.boot     |    3 ++-
>  4 files changed, 54 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index df6d485..ef2c711 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -26,12 +26,6 @@
>  		reg = <0x48>;
>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>  		interrupt-parent = <&intc>;
> -
> -		vsim: regulator-vsim {
> -			compatible = "ti,twl4030-vsim";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <3000000>;
> -		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> new file mode 100644
> index 0000000..90790d9
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/

2012?

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
> +	model = "TI OMAP3 BeagleBoard";
> +	compatible = "ti,omap3-beagle", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
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
> +	};
> +};
> +
> +/include/ "twl4030.dtsi"
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
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index ff00017..c5337d4 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -37,6 +37,12 @@
>  		regulator-max-microvolt = <3150000>;
>  	};
>  
> +	vsim: regulator-vsim {
> +		compatible = "ti,twl4030-vsim";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3000000>;
> +	};
> +
>  	twl_gpio: gpio {
>  		compatible = "ti,twl4030-gpio";
>  		gpio-controller;
> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> index 0e602b7..a469a55 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -3,7 +3,8 @@ params_phys-y		:= 0x80000100
>  initrd_phys-y		:= 0x80800000
>  
>  dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
> -dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle-xm.dtb omap3-evm.dtb
> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-beagle-xm.dtb \
> +				   omap3-evm.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
>  dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> 

