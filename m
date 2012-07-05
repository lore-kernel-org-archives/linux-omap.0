From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 2/4] arm/dts: Add initial DT support for AM33XX SoC
 family
Date: Thu, 5 Jul 2012 08:16:24 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9EF09F@DBDE01.ent.ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
 <1340358050-29560-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab2GEIQg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 04:16:36 -0400
In-Reply-To: <1340358050-29560-3-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hi Tony,

On Fri, Jun 22, 2012 at 15:10:48, AnilKumar, Chimata wrote:
> Add device tree source include file for the AM33XX SoC family.
> An additional .dtsi file is created to describe the generic
> AM33XX CPU module like intc, ocp.
> 
> Actual selection of available peripherals is handled in seperate
> .dts files using this am33xx.dtsi generic header file.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |  189 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am33xx.dtsi
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> new file mode 100644
> index 0000000..f46e353
> --- /dev/null
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -0,0 +1,189 @@
> +/*
> + * Device Tree Source for AM33XX SoC
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "ti,am33xx";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a8";
> +		};
> +	};
> +
> +	/*
> +	 * The soc node represents the soc top level view. It is uses for IPs
> +	 * that are not memory mapped in the MPU view or for the MPU itself.
> +	 */
> +	soc {
> +		compatible = "ti,omap-infra";
> +		mpu {
> +			compatible = "ti,omap3-mpu";
> +			ti,hwmods = "mpu";
> +		};
> +	};
> +
> +	/*
> +	 * XXX: Use a flat representation of the AM33XX interconnect.
> +	 * The real AM33XX interconnect network is quite complex.Since
> +	 * that will not bring real advantage to represent that in DT
> +	 * for the moment, just use a fake OCP bus entry to represent
> +	 * the whole bus hierarchy.
> +	 */
> +	ocp {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		ti,hwmods = "l3_main";
> +
> +		intc: interrupt-controller@48200000 {
> +			compatible = "ti,omap2-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			ti,intc-size = <128>;
> +			reg = <0x48200000 0x1000>;
> +		};
> +
> +		gpio1: gpio@44e07000 {
> +			compatible = "ti,omap4-gpio";
> +			ti,hwmods = "gpio1";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		gpio2: gpio@4804C000 {
> +			compatible = "ti,omap4-gpio";
> +			ti,hwmods = "gpio2";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		gpio3: gpio@481AC000 {
> +			compatible = "ti,omap4-gpio";
> +			ti,hwmods = "gpio3";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		gpio4: gpio@481AE000 {
> +			compatible = "ti,omap4-gpio";
> +			ti,hwmods = "gpio4";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		uart1: serial@44E09000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart1";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart2: serial@48022000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart2";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart3: serial@48024000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart3";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart4: serial@481A6000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart4";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart5: serial@481A8000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart5";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart6: serial@481AA000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart6";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		i2c1: i2c@44E0B000 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c1";
> +		};
> +
> +		i2c2: i2c@4802A000 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c2";
> +		};
> +
> +		i2c3: i2c@4819C000 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c3";
> +		};
> +
> +		mcspi1: spi@48030000 {
> +			compatible = "ti,omap2-mcspi";

I realized that for mcspi and mmc, the compatible name supposed tobe close to
omap4-mcspi. 
These changes seems to went from my local branch, so could you please merge 
below patch with this
5fc0b42a98556bd9f01cecc6a64fcbd15ec363f0 "arm/dts: Add initial DT
support for AM33XX SoC family"


diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1e7b98f..258b10e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -166,36 +166,5 @@
                        #size-cells = <0>;
                        ti,hwmods = "i2c3";
                };
-
-               mcspi1: spi@48030000 {
-                       compatible = "ti,omap2-mcspi";
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       ti,hwmods = "spi0";
-                       ti,spi-num-cs = <4>;
-               };
-
-               mcspi2: spi@481Aa000 {
-                       compatible = "ti,omap2-mcspi";
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       ti,hwmods = "spi1";
-                       ti,spi-num-cs = <2>;
-               };
-
-               mmc1: mmc@48060000 {
-                       compatible = "ti,omap3-hsmmc";
-                       ti,hwmods = "mmc1";
-               };
-
-               mmc2: mmc@481D8000 {
-                       compatible = "ti,omap3-hsmmc";
-                       ti,hwmods = "mmc2";
-               };
-
-               mmc3: mmc@47810000 {
-                       compatible = "ti,omap3-hsmmc";
-                       ti,hwmods = "mmc3";
-               };
        };
 };
--

Thanks
AnilKumar