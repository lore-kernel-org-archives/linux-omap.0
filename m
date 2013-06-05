From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Wed, 5 Jun 2013 13:32:40 +0300
Message-ID: <51AF13C8.1010307@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34814 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3FEKdP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 06:33:15 -0400
In-Reply-To: <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

Hi Sricharan,

Thanks for sending this, but some parts are outdated. See below.

On 06/05/2013 09:46 AM, Sricharan R wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Provide the RESET regulators for the USB PHYs, the USB Host
> port modes and the PHY devices.
> 
> Also provide pin multiplexer information for the USB host
> pins.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> [Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |   77 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi     |   30 +++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 843a001..cf862df 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -25,6 +25,47 @@
>  		regulator-max-microvolt = <3000000>;
>  	};
>  
> +	/* HS USB Port 2 RESET */
> +	hsusb2_reset: hsusb2_reset_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "hsusb2_reset";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>; /* gpio3_80 HUB_NRESET */
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
> +
> +	/* HS USB Host PHY on PORT 2 */
> +	hsusb2_phy: hsusb2_phy {
> +		compatible = "usb-nop-xceiv";
> +		reset-supply = <&hsusb2_reset>;
> +	};
> +
> +	/* HS USB Port 3 RESET */
> +	hsusb3_reset: hsusb3_reset_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "hsusb3_reset";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>; /* gpio3_79 ETH_NRESET */
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
> +
> +	/* HS USB Host PHY on PORT 3 */
> +	hsusb3_phy: hsusb3_phy {
> +		compatible = "usb-nop-xceiv";
> +		reset-supply = <&hsusb3_reset>;
> +	};
> +
> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
> +	clock_alias {
> +		clock-name = "auxclk1_ck";
> +		clock-alias = "main_clk";
> +		device = <&hsusb2_phy>;
> +		clock-frequency = <19200000>; /* 19.2 MHz */
> +	};

clock_alias node is not required. Instead we need to rely on proper clock binding
and provide reference to the clock phandle in the PHY node.

as an example please see here
https://lkml.org/lkml/2013/4/19/124

However this clock binding technique is still under discussion/transition.
https://patchwork.kernel.org/patch/2541331/

So, I suggest you leave the auxclk1 part out for now and we can get it in later once
the clock binding stuff is sorted out. The side effect of this is that PORT 2 (i.e. USB Hub)
will not work. USB Ethernet should still work IMO.

cheers,
-roger

