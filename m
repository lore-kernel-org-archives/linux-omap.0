From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-pandora: add common device tree
Date: Thu, 12 Feb 2015 08:03:16 -0800
Message-ID: <20150212160316.GL2531@atomide.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery1.ore.mailhop.org ([54.149.155.156]:58702 "EHLO
	pmta2.delivery1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302AbbBLQIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Feb 2015 11:08:11 -0500
Content-Disposition: inline
In-Reply-To: <1423746226-700-2-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Hi,

Few comments below.

* Marek Belisko <marek@goldelico.com> [150212 05:07]:
> +
> +&omap3_pmx_core {
> +
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_clk.sdmmc1_clk */
> +			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_cmd.sdmmc1_cmd */
> +			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat0.sdmmc1_dat0 */
> +			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat1.sdmmc1_dat1 */
> +			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat2.sdmmc1_dat2 */
> +			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat3.sdmmc1_dat3 */
> +		>;
...

> +&omap3_pmx_core2 {
> +	/* define in CPU specific file that includes this one
> +	 * use either OMAP3430_CORE2_IOPAD() or OMAP3630_CORE2_IOPAD()
> +	 */
> +};

OK looks like you have some SoC specific pins too.. I assume you
guys have checked that all the pins defined in this file are at
the same offset between 34xx and 36xx variants?

> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		twl_power: power {
> +			compatible = "ti,twl4030-power-reset";
> +			ti,use_poweroff;
> +		};
> +
> +		twl_audio: audio {
> +			compatible = "ti,twl4030-audio";
> +
> +			codec {
> +				ti,ramp_delay_value = <3>;
> +			};
> +		};
> +	};
> +};

Can be done later naturally, but ere you probably want
ti,twl4030-power-idle or ti,twl4030-power-idle-osc-off
if the osicllator can be shut down during off-idle.

> +&gpmc {
> +	ranges = <0 0 0x30000000 0x04>; /* CS0: NAND */

The ranges here allocate the GPMC partition, so it needs to be
a minimum of 16MB:

	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */

> +	nand@0,0 {
> +		reg = <0 0 0>; /* CS0, offset 0 */

The reg is for the device driver to ioremap it's registers,
for NAND it's just 4:

		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */

> +		filesystem@680000 {
> +			label = "rootfs";
> +			reg = <0xc80000 0>;	/* 0 = MTDPART_SIZ_FULL */
> +		};
> +	};
> +};

Is the NAND the same size on all of them? I don't think dts
has a binding for MTDPART_SIZ_FULL type thing..

> +	lcd: lcd@1 {
> +		reg = <1>;	/* CS1 */
> +		compatible =	"omapdss,tpo,td043mtea1";
> +		spi-max-frequency = <100000>;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		label = "lcd";
> +		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;	/* GPIO_157 */
> +		vcc-supply = <&vaux1>;
> +
> +		port {
> +			lcd_in: endpoint {
> +				remote-endpoint = <&dpi_out>;
> +			};
> +		};
> +	};

Oh there's already a binding for the LCD too? That's great :)

Nine job, good to see this happening!

Regards,


Tony
