From: Nishanth Menon <nm@ti.com>
Subject: Re: [Resend/PATCH] arm: dts: omap5: Add status parameter for i2c/spi/uart.
Date: Mon, 29 Jul 2013 08:12:51 -0500
Message-ID: <51F66A53.7050107@ti.com>
References: <1374907189-15848-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60972 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab3G2NMy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 09:12:54 -0400
In-Reply-To: <1374907189-15848-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: benoit.cousson@linaro.org, tony@atomide.com, devicetree@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org

On 07/27/2013 01:39 AM, Sourav Poddar wrote:
> This patch disabled I2C/SPI/UART device initially(status = "disabled").
> This devices will only be probed, if the devices are
> present in the dts file(status = "okay").
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Personally, I like this, though, if we are doing this, it should not be 
piecemeal - existing OMAP generation SoCs should follow this for all 
boards, else we will have a mishmash of the way we have hardware blocks 
are used. i2c-spi expect board files to set status=okay, but, 
GPIOs/UARTs/MMC/keypad etc - not so.. it tends to be tricky when others 
look at the resultant code.

> ---
>   arch/arm/boot/dts/omap5-uevm.dts |   10 +++++++++-
>   arch/arm/boot/dts/omap5.dtsi     |   15 +++++++++++++++
>   2 files changed, 24 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 08b7267..aef8de1 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -259,6 +259,7 @@
>   };
>
>   &i2c1 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c1_pins>;
>
> @@ -431,6 +432,7 @@
>   };
>
>   &i2c5 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c5_pins>;
>
> @@ -451,35 +453,41 @@
>   };
>
>   &mcspi1 {
> -
> +	status = "okay";
>   };
>
>   &mcspi2 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcspi2_pins>;
>   };
>
>   &mcspi3 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcspi3_pins>;
>   };
>
>   &mcspi4 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcspi4_pins>;
>   };
>
>   &uart1 {
> +	status = "okay";
>           pinctrl-names = "default";
>           pinctrl-0 = <&uart1_pins>;
>   };
>
>   &uart3 {
> +	status = "okay";
>           pinctrl-names = "default";
>           pinctrl-0 = <&uart3_pins>;
>   };
>
>   &uart5 {
> +	status = "okay";
>           pinctrl-names = "default";
>           pinctrl-0 = <&uart5_pins>;
>   };
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index e643620..fcd28c9 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -238,6 +238,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c1";
> +			status = "disabled";
>   		};
>
>   		i2c2: i2c@48072000 {
> @@ -247,6 +248,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c2";
> +			status = "disabled";
>   		};
>
>   		i2c3: i2c@48060000 {
> @@ -256,6 +258,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c3";
> +			status = "disabled";
>   		};
>
>   		i2c4: i2c@4807a000 {
> @@ -265,6 +268,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c4";
> +			status = "disabled";
>   		};
>
>   		i2c5: i2c@4807c000 {
> @@ -274,6 +278,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			ti,hwmods = "i2c5";
> +			status = "disabled";
>   		};
>
>   		mcspi1: spi@48098000 {
> @@ -294,6 +299,7 @@
>   			       <&sdma 42>;
>   			dma-names = "tx0", "rx0", "tx1", "rx1",
>   				    "tx2", "rx2", "tx3", "rx3";
> +			status = "disabled";
>   		};
>
>   		mcspi2: spi@4809a000 {
> @@ -309,6 +315,7 @@
>   			       <&sdma 45>,
>   			       <&sdma 46>;
>   			dma-names = "tx0", "rx0", "tx1", "rx1";
> +			status = "disabled";
>   		};
>
>   		mcspi3: spi@480b8000 {
> @@ -321,6 +328,7 @@
>   			ti,spi-num-cs = <2>;
>   			dmas = <&sdma 15>, <&sdma 16>;
>   			dma-names = "tx0", "rx0";
> +			status = "disabled";
>   		};
>
>   		mcspi4: spi@480ba000 {
> @@ -333,6 +341,7 @@
>   			ti,spi-num-cs = <1>;
>   			dmas = <&sdma 70>, <&sdma 71>;
>   			dma-names = "tx0", "rx0";
> +			status = "disabled";
>   		};
>
>   		uart1: serial@4806a000 {
> @@ -341,6 +350,7 @@
>   			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart1";
>   			clock-frequency = <48000000>;
> +			status = "disabled";
>   		};
>
>   		uart2: serial@4806c000 {
> @@ -349,6 +359,7 @@
>   			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart2";
>   			clock-frequency = <48000000>;
> +                        status = "disabled";
>   		};
>
>   		uart3: serial@48020000 {
> @@ -357,6 +368,7 @@
>   			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart3";
>   			clock-frequency = <48000000>;
> +                        status = "disabled";
>   		};
>
>   		uart4: serial@4806e000 {
> @@ -365,6 +377,7 @@
>   			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart4";
>   			clock-frequency = <48000000>;
> +			status = "disabled";
>   		};
>
>   		uart5: serial@48066000 {
> @@ -373,6 +386,7 @@
>   			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart5";
>   			clock-frequency = <48000000>;
> +			status = "disabled";
>   		};
>
>   		uart6: serial@48068000 {
> @@ -381,6 +395,7 @@
>   			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>   			ti,hwmods = "uart6";
>   			clock-frequency = <48000000>;
> +			status = "disabled";
>   		};
>
>   		mmc1: mmc@4809c000 {
>


-- 
Regards,
Nishanth Menon
