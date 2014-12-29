From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] ARM: dts: cm-t3x: add NAND support
Date: Mon, 29 Dec 2014 15:06:58 +0200
Message-ID: <54A151F2.9010904@ti.com>
References: <54A00BD6.8010507@compulab.co.il> <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34848 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaL2NH3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Dec 2014 08:07:29 -0500
In-Reply-To: <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?windows-1252?Q?Beno=EEt_?= =?windows-1252?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

Hi Dmitry,

On 28/12/14 16:30, Dmitry Lifshitz wrote:
> CM-T3517, CM-T3530 and CM-T3730 features NAND storage chip connected to
> GPMC bus.
> 
> Add GPMC DT entry into the root DT file omap3-cm-t3x.dtsi, common for
> all three modules.
> 
> NAND timings are calculated to be safe for CM-T3x devices as it works
> now in non DT boot (in this case the timings are updated by U-Boot).

I didn't get this part. You provide the GPMC timings in the DT now so they will override
u-boot configured timings.

> 
> Update GPMC ranges in boards DT files to include all connected devices.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> ---
> 
> v2 * Update GPMC ranges with NAND values in omap3-cm-t3x30.dtsi. 
>    * Add commit message details
> 
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   58 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    3 +-
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |    4 ++
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |   10 ++----
>  arch/arm/boot/dts/omap3-sbc-t3730.dts |    5 ++-
>  5 files changed, 70 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> index 6ea6d46..4d091ca 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> +++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
> @@ -259,3 +259,61 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mcbsp2_pins>;
>  };
> +
> +&gpmc {
> +	ranges = <0 0 0x00000000 0x01000000>;

Isn't this ranges property redundant as it will be overridden by the board specific dts?

> +
> +	nand@0,0 {
> +		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
> +		nand-bus-width = <8>;
> +		gpmc,device-width = <1>;
> +		ti,nand-ecc-opt = "sw";

any particular reason for sticking with "sw"? Isn't it better to use at least "ham1"
or migrate to stronger schemes like "bch4" or "bch8"?

"ham1" scheme is compatible with ROM loader so the boot partition could be flashed from Linux.
For bch4/8 you will have to keep boot partition/s locked from Linux access as we don't yet
support mixed ECC schemes among partitions.

> +
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <120>;
> +		gpmc,cs-wr-off-ns = <120>;
> +
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <120>;
> +		gpmc,adv-wr-off-ns = <120>;
> +
> +		gpmc,we-on-ns = <6>;
> +		gpmc,we-off-ns = <90>;
> +
> +		gpmc,oe-on-ns = <6>;
> +		gpmc,oe-off-ns = <90>;
> +
> +		gpmc,page-burst-access-ns = <6>;
> +		gpmc,access-ns = <72>;
> +		gpmc,cycle2cycle-delay-ns = <60>;
> +
> +		gpmc,rd-cycle-ns = <120>;
> +		gpmc,wr-cycle-ns = <120>;
> +		gpmc,wr-access-ns = <186>;
> +		gpmc,wr-data-mux-bus-ns = <90>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "xloader";
> +			reg = <0 0x80000>;
> +		};
> +		partition@0x80000 {
> +			label = "uboot";
> +			reg = <0x80000 0x1e0000>;
> +		};
> +		partition@0x260000 {
> +			label = "uboot environment";
> +			reg = <0x260000 0x40000>;
> +		};
> +		partition@0x2a0000 {
> +			label = "linux";
> +			reg = <0x2a0000 0x400000>;
> +		};
> +		partition@0x6a0000 {
> +			label = "rootfs";
> +			reg = <0x6a0000 0x1f880000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> index 9a4a3ab..d9e92b6 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> +++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> @@ -50,7 +50,8 @@
>  #include "omap-gpmc-smsc911x.dtsi"
>  
>  &gpmc {
> -	ranges = <5 0 0x2c000000 0x01000000>;
> +	ranges = <5 0 0x2c000000 0x01000000>, /* CM-T3x30 SMSC9x Eth */
> +		 <0 0 0x00000000 0x01000000>; /* CM-T3x NAND */

Isn't this ranges property redundant as it will anyways be overridden by the board specific dts?

>  
>  	smsc1: ethernet@gpmc {
>  		compatible = "smsc,lan9221", "smsc,lan9115";
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
> index 1798653..c2d5c28 100644
> --- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
> +++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
> @@ -69,3 +69,7 @@
>  	};
>  };
>  
> +&gpmc {
> +	ranges = <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
> +};
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
> index c994f0f..834bc78 100644
> --- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
> +++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
> @@ -26,14 +26,10 @@
>  	};
>  };
>  
> -/*
> - * The following ranges correspond to SMSC9x eth chips on CM-T3530 CoM and
> - * SB-T35 baseboard respectively.
> - * This setting includes both chips in SBC-T3530 board device tree.
> - */
>  &gpmc {
> -	ranges = <5 0 0x2c000000 0x01000000>,
> -		 <4 0 0x2d000000 0x01000000>;
> +	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
> +		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
>  };
>  
>  &mmc1 {
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
> index 5bdddf2..73c7bf4 100644
> --- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
> +++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
> @@ -27,8 +27,9 @@
>  };
>  
>  &gpmc {
> -	ranges = <5 0 0x2c000000 0x01000000>,
> -		 <4 0 0x2d000000 0x01000000>;
> +	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
> +		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
>  };
>  
>  &dss {
> 

cheers,
-roger

