From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DTS: ARM: OMAP3-N900: Add WL1251 support
Date: Mon, 5 May 2014 12:25:14 -0700
Message-ID: <20140505192514.GA25949@atomide.com>
References: <1394747995-25090-1-git-send-email-sre@debian.org>
 <1394747995-25090-2-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57164 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaEETZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 15:25:26 -0400
Content-Disposition: inline
In-Reply-To: <1394747995-25090-2-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, "John W. Linville" <linville@tuxdriver.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [140313 15:03]:
> Add device tree support for the wireless chip
> built into the Nokia N900.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Thanks applying into omap-for-v3.16/dt.

Tony

> ---
>  arch/arm/boot/dts/omap3-n900.dts | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index e91dae7..0f48b9b 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -148,6 +148,15 @@
>  		>;
>  	};
>  
> +	mcspi4_pins: pinmux_mcspi4_pins {
> +		pinctrl-single,pins = <
> +			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
> +			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
> +			0x160 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
> +			0x166 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
> +		>;
> +	};
> +
>  	mmc1_pins: pinmux_mmc1_pins {
>  		pinctrl-single,pins = <
>  			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
> @@ -203,6 +212,13 @@
>  			0x15e (PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
>  		>;
>  	};
> +
> +	wl1251_pins: pinmux_wl1251 {
> +		pinctrl-single,pins = <
> +			0x0ce (PIN_OUTPUT | MUX_MODE4)		/* gpio 87 => wl1251 enable */
> +			0x05a (PIN_INPUT | MUX_MODE4)		/* gpio 42 => wl1251 irq */
> +		>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -603,6 +619,30 @@
>  	};
>  };
>  
> +&mcspi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcspi4_pins>;
> +
> +	wl1251@0 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wl1251_pins>;
> +
> +		vio-supply = <&vio>;
> +
> +		compatible = "ti,wl1251";
> +		reg = <0>;
> +		spi-max-frequency = <48000000>;
> +
> +		spi-cpol;
> +		spi-cpha;
> +
> +		ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
> +
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
> +	};
> +};
> +
>  &usb_otg_hs {
>  	interface-type = <0>;
>  	usb-phy = <&usb2_phy>;
> -- 
> 1.9.0
> 
