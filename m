From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries
 for omap3
Date: Fri, 18 Oct 2013 17:55:23 +0200
Message-ID: <526159EB.8070301@baylibre.com>
References: <20131017221522.GE15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:53389 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3JRPz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 11:55:26 -0400
Received: by mail-wi0-f177.google.com with SMTP id h11so1241080wiv.4
        for <linux-omap@vger.kernel.org>; Fri, 18 Oct 2013 08:55:25 -0700 (PDT)
In-Reply-To: <20131017221522.GE15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Tony,

On 18/10/2013 00:15, Tony Lindgren wrote:
> Looks like omap3 is still relying on hwmod data for some basic
> device tree information. Let's add the information to omap3.dtsi
> so we can remove the related hwmod data once omap3 is DT only.
>
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Benoit Cousson <bcousson@baylibre.com>

Regards,
Benoit

>
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -37,6 +37,7 @@
>
>   	pmu {
>   		compatible =3D "arm,cortex-a8-pmu";
> +		reg =3D <0x54000000 0x800000>;
>   		interrupts =3D <3>;
>   		ti,hwmods =3D "debugss";
>   	};
> @@ -71,6 +72,8 @@
>   	 */
>   	ocp {
>   		compatible =3D "simple-bus";
> +		reg =3D <0x68000000 0x10000>;
> +		interrupts =3D <9 10>;
>   		#address-cells =3D <1>;
>   		#size-cells =3D <1>;
>   		ranges;
> @@ -193,24 +196,40 @@
>
>   		uart1: serial@4806a000 {
>   			compatible =3D "ti,omap3-uart";
> +			reg =3D <0x4806a000 0x2000>;
> +			interrupts =3D <72>;
> +			dmas =3D <&sdma 49 &sdma 50>;
> +			dma-names =3D "tx", "rx";
>   			ti,hwmods =3D "uart1";
>   			clock-frequency =3D <48000000>;
>   		};
>
>   		uart2: serial@4806c000 {
>   			compatible =3D "ti,omap3-uart";
> +			reg =3D <0x4806c000 0x400>;
> +			interrupts =3D <73>;
> +			dmas =3D <&sdma 51 &sdma 52>;
> +			dma-names =3D "tx", "rx";
>   			ti,hwmods =3D "uart2";
>   			clock-frequency =3D <48000000>;
>   		};
>
>   		uart3: serial@49020000 {
>   			compatible =3D "ti,omap3-uart";
> +			reg =3D <0x49020000 0x400>;
> +			interrupts =3D <74>;
> +			dmas =3D <&sdma 53 &sdma 54>;
> +			dma-names =3D "tx", "rx";
>   			ti,hwmods =3D "uart3";
>   			clock-frequency =3D <48000000>;
>   		};
>
>   		i2c1: i2c@48070000 {
>   			compatible =3D "ti,omap3-i2c";
> +			reg =3D <0x48070000 0x80>;
> +			interrupts =3D <56>;
> +			dmas =3D <&sdma 27 &sdma 28>;
> +			dma-names =3D "tx", "rx";
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "i2c1";
> @@ -218,6 +237,10 @@
>
>   		i2c2: i2c@48072000 {
>   			compatible =3D "ti,omap3-i2c";
> +			reg =3D <0x48072000 0x80>;
> +			interrupts =3D <57>;
> +			dmas =3D <&sdma 29 &sdma 30>;
> +			dma-names =3D "tx", "rx";
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "i2c2";
> @@ -225,6 +248,10 @@
>
>   		i2c3: i2c@48060000 {
>   			compatible =3D "ti,omap3-i2c";
> +			reg =3D <0x48060000 0x80>;
> +			interrupts =3D <61>;
> +			dmas =3D <&sdma 25 &sdma 26>;
> +			dma-names =3D "tx", "rx";
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "i2c3";
> @@ -232,6 +259,8 @@
>
>   		mcspi1: spi@48098000 {
>   			compatible =3D "ti,omap2-mcspi";
> +			reg =3D <0x48098000 0x100>;
> +			interrupts =3D <65>;
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "mcspi1";
> @@ -250,6 +279,8 @@
>
>   		mcspi2: spi@4809a000 {
>   			compatible =3D "ti,omap2-mcspi";
> +			reg =3D <0x4809a000 0x100>;
> +			interrupts =3D <66>;
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "mcspi2";
> @@ -263,6 +294,8 @@
>
>   		mcspi3: spi@480b8000 {
>   			compatible =3D "ti,omap2-mcspi";
> +			reg =3D <0x480b8000 0x100>;
> +			interrupts =3D <91>;
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "mcspi3";
> @@ -276,6 +309,8 @@
>
>   		mcspi4: spi@480ba000 {
>   			compatible =3D "ti,omap2-mcspi";
> +			reg =3D <0x480ba000 0x100>;
> +			interrupts =3D <48>;
>   			#address-cells =3D <1>;
>   			#size-cells =3D <0>;
>   			ti,hwmods =3D "mcspi4";
> @@ -284,8 +319,17 @@
>   			dma-names =3D "tx0", "rx0";
>   		};
>
> +		hdqw1w: 1w@480b2000 {
> +			compatible =3D "ti,omap3-1w";
> +			reg =3D <0x480b2000 0x1000>;
> +			interrupts =3D <58>;
> +			ti,hwmods =3D "hdq1w";
> +		};
> +
>   		mmc1: mmc@4809c000 {
>   			compatible =3D "ti,omap3-hsmmc";
> +			reg =3D <0x4809c000 0x200>;
> +			interrupts =3D <83>;
>   			ti,hwmods =3D "mmc1";
>   			ti,dual-volt;
>   			dmas =3D <&sdma 61>, <&sdma 62>;
> @@ -294,6 +338,8 @@
>
>   		mmc2: mmc@480b4000 {
>   			compatible =3D "ti,omap3-hsmmc";
> +			reg =3D <0x480b4000 0x200>;
> +			interrupts =3D <86>;
>   			ti,hwmods =3D "mmc2";
>   			dmas =3D <&sdma 47>, <&sdma 48>;
>   			dma-names =3D "tx", "rx";
> @@ -301,6 +347,8 @@
>
>   		mmc3: mmc@480ad000 {
>   			compatible =3D "ti,omap3-hsmmc";
> +			reg =3D <0x480ad000 0x200>;
> +			interrupts =3D <94>;
>   			ti,hwmods =3D "mmc3";
>   			dmas =3D <&sdma 77>, <&sdma 78>;
>   			dma-names =3D "tx", "rx";
> @@ -308,6 +356,7 @@
>
>   		wdt2: wdt@48314000 {
>   			compatible =3D "ti,omap3-wdt";
> +			reg =3D <0x48314000 0x80>;
>   			ti,hwmods =3D "wd_timer2";
>   		};
>
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap=
36xx.dtsi
> index f8b3765..380c22e 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -31,6 +31,10 @@
>   	ocp {
>   		uart4: serial@49042000 {
>   			compatible =3D "ti,omap3-uart";
> +			reg =3D <0x49042000 0x400>;
> +			interrupts =3D <80>;
> +			dmas =3D <&sdma 81 &sdma 82>;
> +			dma-names =3D "tx", "rx";
>   			ti,hwmods =3D "uart4";
>   			clock-frequency =3D <48000000>;
>   		};
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
