From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730
Date: Mon, 16 Dec 2013 11:17:54 -0800
Message-ID: <20131216191754.GD26293@atomide.com>
References: <1386962541-18498-1-git-send-email-tony@atomide.com>
 <52AF065A.4010205@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35334 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754897Ab3LPTSC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 14:18:02 -0500
Content-Disposition: inline
In-Reply-To: <52AF065A.4010205@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Lifshitz <lifshitz@compulab.co.il>

* Igor Grinberg <grinberg@compulab.co.il> [131216 05:57]:
> On 12/13/13 21:22, Tony Lindgren wrote:
> 
> SB-T35 has only one SMSC Ethernet on-board (smsc2),
> while the first one is on the cm-t3530 and cm-t3730 modules.
> SBC-T3517 has only one _SMSC_ Ethernet and it is on the SB-T35 base board.
> cm-t3517 has EMAC Ethernet on-board instead of the SMSC.

OK, I'll move that.
 
> There is also another base board - CB-T3, which turns into
> EM-T3530 and EM-T3730 once you plug the cm-t3530 or cm-t3730 into CB-T3.
> 
> http://compulab.co.il/products/handheld-computers/em-t3730/
> http://compulab.co.il/products/handheld-computers/em-t3530/
> 
> The CB-T3 base board does not have any Ethernet controllers on it,
> so the EM-T3x systems have only one Ethernet controller - the one on the
> CPU board - SMSC.

OK
 
> This makes it four boards:
> sb-t35 - base board has only one Ethernet controller (SMSC)
> cb-t3 - base board has no Ethernet controllers
> cm-t3530 - CPU board (plugged into sb-t35) has only one Ethernet controller (SMSC)
> cm-t3730 - CPU board (plugged into sb-t35) has only one Ethernet controller (SMSC)
> cm-t3537 - CPU board (plugged into sb-t35) has only one Ethernet controller (EMAC)
> 
> The SBC-Txxx and EM-Txxx- means both boards connected (base board with CPU board).

OK
 
> > +
> > +	cpus {
> > +		cpu@0 {
> > +			cpu0-supply = <&vcc>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		ledb {
> > +			label = "cm-t35:green";
> > +			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;  /* gpio186 */
> > +			linux,default-trigger = "heartbeat";
> 
> Although all CPU boards have the same GPIO routed to the heartbeat LED,
> this property is related to the CPU board and not to the base (mother) board.
> The same GPIO is used intensionally for s/w simplicity.
> If we are about to save code duplication, I'd like to have a common
> to CPU boards file, say omap3-cm-t3x.dtsi - that way it will better reflect
> the actual hardware.

OK will move.
 
> > +&i2c1 {
> > +	clock-frequency = <2600000>;
> > +
> > +	twl: twl@48 {
> > +		reg = <0x48>;
> > +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> > +		interrupt-parent = <&intc>;
> > +	};
> > +};
> 
> This one should be a part of the common file.

OK 

> > +#include "twl4030.dtsi"
> > +#include "twl4030_omap3.dtsi"
> > +
> > +&i2c3 {
> > +	clock-frequency = <400000>;
> > +};
> > +
> > +&mmc1 {
> > +	vmmc-supply = <&vmmc1>;
> > +	vmmc_aux-supply = <&vsim>;
> 
> Is it essential to always provide vmmc_aux-supply property?
> In fact, the TPS65930 does not have the VSIM supply...
> It is a mistake in the upstream board file.

OK

> I fixed this locally a while ago, but haven't submitted upstream...
> So we should either leave this property unpopulated (if we can...) or
> provide a fixed regulator to populate it.
> 
> > +	bus-width = <8>;
> 
> I'm not sure what this property should reflect.
> Both cm-t3530 and cm-t3730 use 4 bit MMC1 bus.

Hmm except with the muxing it seems to work just fine with 8-bit :)
I noticed that by accident as I copied the entry from omap3-evm.

So it seems that all the 8 lines are available for the MMC1, but can
be optionally also routed somewhere else?
 
> > +++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Suppport for CompuLab SBC-T3517 with CM-T3517
> > + */
> > +/dts-v1/;
> > +
> > +#include "am3517.dtsi"
> > +#include "omap3-sb-t35.dtsi"
> > +
> > +
> > +/ {
> > +	model = "CompuLab SBC-T3517 with CM-T3517";
> > +	compatible = "compulab,omap3-sbc-t3517", "ti,am3517", "ti,omap3";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x10000000>; /* 256 MB */
> 
> Can we support multiple memory sizes through static DT, or
> the only way is to update this property in the bootloader?

Well we should probably have a minimal .dts file for the variants
too that can include omap3-cm-t37.dts and so on. I guess some
bootloaders are capable of rewriting the .dtb too.
 
> > +	mmc1_pins: pinmux_mmc1_pins {
> > +		pinctrl-single,pins = <
> > +			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
> > +			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
> > +			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
> > +			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
> > +			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
> > +			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
> > +			0x120 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
> > +			0x122 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
> > +			0x124 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
> > +			0x126 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
> 
> The dat{4,5,6,7} pins are not used either on cm-t3530, or cm-t3730.

But it seems to work and makes MMC1 faster :) Might be worth checking
though, maybe those pins have multiple optional routings available?
 
> > +	mmc2_pins: pinmux_mmc2_pins {
> > +		pinctrl-single,pins = <
> > +			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
> > +			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
> > +			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
> > +			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
> > +			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
> > +			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
> 
> Here the following is missing:
> 0x134 (PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */

That seems to be used for the wl12xx GPIO, so it's listed at
wl12xx_gpio below.
 
> > +			0x136 (PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat5.sdmmc2_dir_dat1 */
> > +			0x138 (PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat6.sdmmc2_dir_cmd */
> > +			0x13a (PIN_INPUT | MUX_MODE1)		/* sdmmc2_dat7.sdmmc2_clkin */
> 
> All four above pins (dat{4,5,6,7}) should be muxed only on cm-t3530.
> cm-t3730 uses the sdmmc2_dat4 (gpio136) for wl12xx irq,
> and does nor use the rest (dat{5,6,7}) at all.

Hmm OK, maybe those extra pins also have alternative routings available?
 
> > +	wl12xx_gpio: pinmux_wl12xx_gpio {
> > +		pinctrl-single,pins = <
> > +			0xb2 (PIN_OUTPUT | MUX_MODE4)		/* dss_data3.gpio_73 */
> > +			0x134 (PIN_INPUT | MUX_MODE4)		/* sdmmc2_dat4.gpio_136 */
> > +		>;
> > +	};
> > +};

Regards,

Tony
