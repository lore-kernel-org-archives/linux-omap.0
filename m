From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
Date: Mon, 7 Oct 2013 13:18:00 +0300
Message-ID: <52528A58.9060607@ti.com>
References: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk> <1381139740-13495-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43491 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3JGKSM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 06:18:12 -0400
In-Reply-To: <1381139740-13495-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On 10/07/2013 12:55 PM, Javier Martinez Canillas wrote:
> Add device nodes for the HS USB Host port 1, USB PHY and its
> required regulator and also pin mux setup for HS USB1 pins.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
> 
> Changes since v1:
>  - Add HST USB port 1 pinmux setup in omap3-igep0020 instead of
>    omap3-igep.dtsi since is not used by IGEP COM; suggested by Roger Quadros
> 
>  arch/arm/boot/dts/omap3-igep0020.dts | 49 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index eedf0d8..35346f2 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -55,6 +55,47 @@
>  		regulator-name = "vdd33a";
>  		regulator-always-on;
>  	};
> +
> +       /* HS USB Port 1 Power */
> +       hsusb1_power: hsusb1_power_reg {
> +               compatible = "regulator-fixed";
> +               regulator-name = "hsusb1_vbus";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* GPIO LEDA */
> +               startup-delay-us = <70000>;
> +       };
> +
> +	/* HS USB Host PHY on PORT 1 */
> +	hsusb1_phy: hsusb1_phy {
> +		compatible = "usb-nop-xceiv";
> +		reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
> +		vcc-supply = <&hsusb1_power>;
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&hsusbb1_pins
> +	>;
> +
> +	hsusbb1_pins: pinmux_hsusbb1_pins {
> +		pinctrl-single,pins = <
> +			0x5aa (PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
> +			0x5a8 (PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
> +			0x5bc (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
> +			0x5be (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
> +			0x5ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
> +			0x5ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
> +			0x5b0 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
> +			0x5b2 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
> +			0x5b4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
> +			0x5b6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
> +			0x5b8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
> +			0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
> +		>;
> +	};
>  };
>  
>  &leds_pins {
> @@ -166,3 +207,11 @@
>  		smsc,save-mac-address;
>  	};
>  };
> +
> +&usbhshost {
> +	port1-mode = "ehci-phy";
> +};
> +
> +&usbhsehci {
> +	phys = <&hsusb1_phy>;
> +};
> 

