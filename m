From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2 1/5] ARM: dts: omap3: Add support for INCOstartec a83x
 module
Date: Mon, 27 Jan 2014 01:04:49 +0100
Message-ID: <20140127000449.GB30378@mars>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
 <1390417460-3134-2-git-send-email-chf.fritz@googlemail.com>
 <52E0207E.3050900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:51717 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbaA0AE4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jan 2014 19:04:56 -0500
Content-Disposition: inline
In-Reply-To: <52E0207E.3050900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Nishanth,

 thanks for reviewing this patch. Please see my comments below.

On Wed, Jan 22, 2014 at 01:48:14PM -0600, Nishanth Menon wrote:
> On 01/22/2014 01:04 PM, Christoph Fritz wrote:

> > +	regulators {
> > +		compatible = "simple-bus";
> Shrug, just moving the fixed regulator to root also will do the job,
> not sure simple-bus much sense here :(
> 

will get fixed

> > +		reg_vcc3: vcc3 {
> > +                        compatible = "regulator-fixed";
> > +                        regulator-name = "VCC3";
> > +                        regulator-min-microvolt = <3300000>;
> > +                        regulator-max-microvolt = <3300000>;
> > +                        regulator-always-on;
> > +		};
> > +	};
> > +
> > +	hsusb1_phy: hsusb1_phy {
> > +		compatible = "usb-nop-xceiv";
> > +		vcc-supply = <&reg_vcc3>;
> > +	};
> > +};
> > +
> > +&omap3_pmx_wkup {
> > +	pinctrl-names = "default";
> > +
> > +	lan9221_pins: pinmux_lan9221_pins {
> > +		pinctrl-single,pins = <
> > +			0x5A (PIN_INPUT | MUX_MODE4)   /* gpio_129 */
> umm.. you might want to follow the convention as you followed later in
> comments.

My convention was: If pin can be described unique with one name,
don't use two. But I'll change that to be uniform with all comments.

> > +		>;
> > +	};
> > +
> > +	tsc2048_pins: pinmux_tsc2048_pins {
> > +		pinctrl-single,pins = <
> > +			0x16 (PIN_INPUT_PULLUP | MUX_MODE4)   /* gpio_8 */
> umm.. you might want to follow the convention as you followed later in
> comments.

will get fixed

> > +		>;
> > +	};
> > +
> > +	mmc1cd_pins: pinmux_mmc1cd_pins {
> > +		pinctrl-single,pins = <
> > +			0x56 (PIN_INPUT | MUX_MODE4)   /* gpio_126 */
> umm.. you might want to follow the convention as you followed later in
> comments.

will get fixed

> > +		>;
> > +	};
> > +};
> > +
> > +&omap3_pmx_core {
> > +	pinctrl-names = "default";
> > +
> > +	gpio1_pins: pinmux_gpio1_pins {
> > +		pinctrl-single,pins = <
> > +			0x5ca (PIN_OUTPUT_PULLDOWN | MUX_MODE4)   /* gpio_29 */
> umm.. you might want to follow the convention as you followed later in
> comments.

will get fixed

> > +		>;
> > +	};
> > +
> > +	uart1_pins: pinmux_uart1_pins {
> > +		pinctrl-single,pins = <
> > +			0x14c (PIN_OUTPUT | MUX_MODE0)   /* uart1_tx.uart1_tx */
> > +			0x14e (PIN_OUTPUT | MUX_MODE0)   /* uart1_rts.uart1_rts */
> > +			0x150 (PIN_INPUT | MUX_MODE0)    /* uart1_cts.uart1_cts */
> > +			0x152 (PIN_INPUT | MUX_MODE0)    /* uart1_rx.uart1_rx */
> > +		>;
> you may be interested in include/dt-bindings/pinctrl/omap.h
> OMAP3_CORE1_IOPAD, OMAP3_CORE2_IOPAD as needed here.

will get fixed

> > +	};
> > +
> > +	uart2_pins: pinmux_uart2_pins {
> > +		pinctrl-single,pins = <
> > +			0x140 (PIN_OUTPUT | MUX_MODE1)   /* mcbsp3_clkx.uart2_tx */
> > +			0x142 (PIN_INPUT | MUX_MODE1)    /* mcbsp3_fsx.uart2_rx */
> > +		>;
> > +	};
> > +
> > +	uart3_pins: pinmux_uart3_pins {
> > +		pinctrl-single,pins = <
> > +			0x16e (PIN_INPUT | MUX_MODE0)    /* uart3_rx_irrx.uart3_rx_irrx */
> > +			0x170 (PIN_OUTPUT | MUX_MODE0)   /* uart3_tx_irtx.uart3_tx_irtx */
> > +		>;
> > +	};
> > +
> > +	i2c1_pins: pinmux_i2c1_pins {
> > +		pinctrl-single,pins = <
> > +			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c1_scl */
> > +			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c1_sda */
> umm.. you might want to follow the convention as you followed
> elsewhere in comments.

will get fixed

> > +		>;
> > +	};
> > +
> > +	i2c2_pins: pinmux_i2c2_pins {
> > +		pinctrl-single,pins = <
> > +			0x18e (PIN_INPUT | MUX_MODE0)   /* i2c2_scl.i2c2_scl */
> > +			0x190 (PIN_INPUT | MUX_MODE0)   /* i2c2_sda.i2c2_sda */
> > +		>;
> > +	};
> > +
> > +	i2c3_pins: pinmux_i2c3_pins {
> > +		pinctrl-single,pins = <
> > +			0x192 (PIN_INPUT | MUX_MODE0)   /* i2c3_scl.i2c3_scl */
> > +			0x194 (PIN_INPUT | MUX_MODE0)   /* i2c3_sda.i2c3_sda */
> > +		>;
> > +	};
> > +
> > +	hsusb1_pins: pinmux_hsusb1_pins {
> > +		pinctrl-single,pins = <
> > +			0x5a8 (PIN_OUTPUT | MUX_MODE3)  /* etk_clk.hsusb1_stp */
> &omap3_pmx_core2 and OMAP3_CORE2_IOPAD probably here. and probably see
> similar usage in other board dtsi.

will get fixed

> > +
> > +#include "twl4030.dtsi"
> > +#include "twl4030_omap3.dtsi"
> > +
> > +&twl {
> > +	vmmc1: regulator-vmmc1 {
> > +		regulator-always-on;
> > +	};
> > +
> > +	vdd1: regulator-vdd1 {
> > +		regulator-always-on;
> > +	};
> > +
> > +	vdd2: regulator-vdd2 {
> > +		regulator-always-on;
> > +	};
> I hope you have covered all required regulators here including the
> ones you might need for IO.1P8 perhaps?

Yes, I rechecked all and it's fine now. IO.1P8 was low due to a
hardware error which is now fixed.

> > +
> > +&mmc1 {
> > +	reg = <0x4809c000 0x400>;
> little curious as to why this. is that to override length 0x200 to
> 0x400? that belongs to soc.dtsi then.

This is a remnant from last year and will get purged.

Let me reroll this patch in a new v3 set.

Thanks
  -- Christoph
