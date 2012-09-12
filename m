From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2] arm/dts: Add omap3-beagle.dts
Date: Wed, 12 Sep 2012 19:18:30 +0200
Message-ID: <5050C3E6.3000908@ti.com>
References: <1347379319-8411-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53552 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2ILRSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 13:18:40 -0400
In-Reply-To: <1347379319-8411-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 09/11/2012 06:01 PM, Jon Hunter wrote:
> Add a minimal dts for original OMAP3430/3530 version of the Beagle board. This
> version of the Beagle board has 256MB of DDR and features the same TWL4030
> power management IC (PMIC) as the Beagle board XM.
> 
> Given that the Beagle and Beagle-XM boards use the same PMIC, move the
> definition of the VSIM regulator into the TWL4030.dtsi file so that we do not
> need to duplicate in the Beagle board dts file.
> 
> This has been boot tested on an OMAP3530 Beagle board and verifing that the
> SD/MMC interface is working with a SD card.
> 
> This patch is generated on top of Tony Lindgren's devel-dt branch [1].
> 
> V2 changes
> - Rebased upon of devel-dt
> - Corrected copyright date in omap3-beagle.dts file
> - Added LED support after verifing that Beagle and Beagle XM have the same LED
>   configuration
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git devel-dt
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

I've just applied your patch in my for_3.7/dts_part2 branch.

I changed the subject to use "ARM: dts: " prefix seems it seems to be
the convention nowadays.

I removed as well the reference to Tony's tree, since that will become
irrelevant when it will be the commit changelog in the git tree in 2
years from now :-)

Thanks,
Benoit


> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ---
>  arch/arm/boot/dts/omap3-beagle.dts    |   67 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/twl4030.dtsi        |    6 +++
>  arch/arm/mach-omap2/Makefile.boot     |    3 +-
>  4 files changed, 75 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index c38cf76..3705a81 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -55,12 +55,6 @@
>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>  		interrupt-parent = <&intc>;
>  
> -		vsim: regulator-vsim {
> -			compatible = "ti,twl4030-vsim";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <3000000>;
> -		};
> -
>  		twl_audio: audio {
>  			compatible = "ti,twl4030-audio";
>  			codec {
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> new file mode 100644
> index 0000000..f624dc8
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
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
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pmu_stat {
> +			label = "beagleboard::pmu_stat";
> +			gpios = <&twl_gpio 19 0>; /* LEDB */
> +		};
> +
> +		heartbeat {
> +			label = "beagleboard::usr0";
> +			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		mmc {
> +			label = "beagleboard::usr1";
> +			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +
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
> index be0fe92..384005a 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -3,7 +3,8 @@ params_phys-y		:= 0x80000100
>  initrd_phys-y		:= 0x80800000
>  
>  dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
> -dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle-xm.dtb omap3-evm.dtb omap3-tobi.dtb
> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-beagle-xm.dtb
> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-evm.dtb omap3-tobi.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
>  dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> 

