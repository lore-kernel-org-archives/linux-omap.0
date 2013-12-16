From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730
Date: Mon, 16 Dec 2013 15:55:38 +0200
Message-ID: <52AF065A.4010205@compulab.co.il>
References: <1386962541-18498-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:38441 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab3LPN4a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 08:56:30 -0500
In-Reply-To: <1386962541-18498-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Dmitry Lifshitz <lifshitz@compulab.co.il>

Hi Tony,

On 12/13/13 21:22, Tony Lindgren wrote:
> This adds support for CompuLab SBC-T3530, also known as cm-t3730:
> 
> http://compulab.co.il/products/sbcs/sbc-t3530/
> 
> It seems that with the sbc-3xxx mainboard is also used on
> SBC-T3517 and SBC-T3730 with just a different CPU module:
> 
> http://compulab.co.il/products/sbcs/sbc-t3517/
> http://compulab.co.il/products/sbcs/sbc-t3730/
> 
> So let's add a common omap3-sb-t35.dtsi and then separate SoC
> specific omap3-sbc-t3730.dts, omap3-sbc-t3530.dts and
> omap3-sbc-t3517.dts.
> 
> I've tested this with SBC-T3730 as that's the only one I have.
> At least serial, both Ethernet controllers, MMC, and wl12xx WLAN
> work.
> 
> Note that WLAN seems to be different for SBC-T3530.

Yes, it is Marvell 8686 chipset using the libertas driver.

> And SBC-T3517
> may need some changes for the EMAC Ethernet if that's used
> instead of the smsc911x.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Great job!
I'm sorry I couldn't make it in time with the conversion... :-(

> ---
>  arch/arm/boot/dts/Makefile            |   3 +
>  arch/arm/boot/dts/omap3-sb-t35.dtsi   | 135 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-sbc-t3517.dts |  18 +++++
>  arch/arm/boot/dts/omap3-sbc-t3530.dts |  18 +++++
>  arch/arm/boot/dts/omap3-sbc-t3730.dts | 130 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c    |   7 ++
>  6 files changed, 311 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-sb-t35.dtsi
>  create mode 100644 arch/arm/boot/dts/omap3-sbc-t3517.dts
>  create mode 100644 arch/arm/boot/dts/omap3-sbc-t3530.dts
>  create mode 100644 arch/arm/boot/dts/omap3-sbc-t3730.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index fc37bca..41370d2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -179,6 +179,9 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap2420-n810-wimax.dtb \
>  	omap3430-sdp.dtb \
>  	omap3-beagle.dtb \
> +	omap3-sbc-t3530.dtb \
> +	omap3-sbc-t3730.dtb \
> +	omap3-sbc-t3517.dtb \
>  	omap3-devkit8000.dtb \
>  	omap3-beagle-xm.dtb \
>  	omap3-evm.dtb \
> diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
> new file mode 100644
> index 0000000..fc676c5
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
> @@ -0,0 +1,135 @@
> +/*
> + * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
> + */
> +
> +/ {
> +	aliases {
> +		ethernet0 = &smsc1;
> +		ethernet1 = &smsc2;
> +	};

SB-T35 has only one SMSC Ethernet on-board (smsc2),
while the first one is on the cm-t3530 and cm-t3730 modules.
SBC-T3517 has only one _SMSC_ Ethernet and it is on the SB-T35 base board.
cm-t3517 has EMAC Ethernet on-board instead of the SMSC.

There is also another base board - CB-T3, which turns into
EM-T3530 and EM-T3730 once you plug the cm-t3530 or cm-t3730 into CB-T3.

http://compulab.co.il/products/handheld-computers/em-t3730/
http://compulab.co.il/products/handheld-computers/em-t3530/

The CB-T3 base board does not have any Ethernet controllers on it,
so the EM-T3x systems have only one Ethernet controller - the one on the
CPU board - SMSC.

This makes it four boards:
sb-t35 - base board has only one Ethernet controller (SMSC)
cb-t3 - base board has no Ethernet controllers
cm-t3530 - CPU board (plugged into sb-t35) has only one Ethernet controller (SMSC)
cm-t3730 - CPU board (plugged into sb-t35) has only one Ethernet controller (SMSC)
cm-t3537 - CPU board (plugged into sb-t35) has only one Ethernet controller (EMAC)

The SBC-Txxx and EM-Txxx- means both boards connected (base board with CPU board).

> +
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply = <&vcc>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		ledb {
> +			label = "cm-t35:green";
> +			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;  /* gpio186 */
> +			linux,default-trigger = "heartbeat";

Although all CPU boards have the same GPIO routed to the heartbeat LED,
this property is related to the CPU board and not to the base (mother) board.
The same GPIO is used intensionally for s/w simplicity.
If we are about to save code duplication, I'd like to have a common
to CPU boards file, say omap3-cm-t3x.dtsi - that way it will better reflect
the actual hardware.

> +		};
> +	};
> +
> +	vddvario: regulator-vddvario {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddvario";
> +		regulator-always-on;
> +	};
> +
> +	vdd33a: regulator-vdd33a {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd33a";
> +		regulator-always-on;
> +	};
> +};
> +
> +&gpmc {
> +	ranges = <5 0 0x2c000000 0x01000000>,
> +		 <4 0 0x2d000000 0x01000000>;
> +
> +	smsc1: ethernet@5,0 {
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <5 0 0xff>;
> +		bank-width = <2>;
> +		gpmc,mux-add-data;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <186>;
> +		gpmc,cs-wr-off-ns = <186>;
> +		gpmc,adv-on-ns = <12>;
> +		gpmc,adv-rd-off-ns = <48>;
> +		gpmc,adv-wr-off-ns = <48>;
> +		gpmc,oe-on-ns = <54>;
> +		gpmc,oe-off-ns = <168>;
> +		gpmc,we-on-ns = <54>;
> +		gpmc,we-off-ns = <168>;
> +		gpmc,rd-cycle-ns = <186>;
> +		gpmc,wr-cycle-ns = <186>;
> +		gpmc,access-ns = <114>;
> +		gpmc,page-burst-access-ns = <6>;
> +		gpmc,bus-turnaround-ns = <12>;
> +		gpmc,cycle2cycle-delay-ns = <18>;
> +		gpmc,wr-data-mux-bus-ns = <90>;
> +		gpmc,wr-access-ns = <186>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-diffcsen;
> +		vddvario-supply = <&vddvario>;
> +		vdd33a-supply = <&vdd33a>;
> +		reg-io-width = <4>;
> +		smsc,save-mac-address;
> +	};

This one also should be a part of CPU board file or the common file.

> +
> +	smsc2: ethernet@4,0 {
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +		reg = <4 0 0xff>;
> +		bank-width = <2>;
> +		gpmc,mux-add-data;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <186>;
> +		gpmc,cs-wr-off-ns = <186>;
> +		gpmc,adv-on-ns = <12>;
> +		gpmc,adv-rd-off-ns = <48>;
> +		gpmc,adv-wr-off-ns = <48>;
> +		gpmc,oe-on-ns = <54>;
> +		gpmc,oe-off-ns = <168>;
> +		gpmc,we-on-ns = <54>;
> +		gpmc,we-off-ns = <168>;
> +		gpmc,rd-cycle-ns = <186>;
> +		gpmc,wr-cycle-ns = <186>;
> +		gpmc,access-ns = <114>;
> +		gpmc,page-burst-access-ns = <6>;
> +		gpmc,bus-turnaround-ns = <12>;
> +		gpmc,cycle2cycle-delay-ns = <18>;
> +		gpmc,wr-data-mux-bus-ns = <90>;
> +		gpmc,wr-access-ns = <186>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-diffcsen;
> +		vddvario-supply = <&vddvario>;
> +		vdd33a-supply = <&vdd33a>;
> +		reg-io-width = <4>;
> +		smsc,save-mac-address;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +	};
> +};

This one should be a part of the common file.

> +
> +#include "twl4030.dtsi"
> +#include "twl4030_omap3.dtsi"
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmc1>;
> +	vmmc_aux-supply = <&vsim>;

Is it essential to always provide vmmc_aux-supply property?
In fact, the TPS65930 does not have the VSIM supply...
It is a mistake in the upstream board file.
I fixed this locally a while ago, but haven't submitted upstream...
So we should either leave this property unpopulated (if we can...) or
provide a fixed regulator to populate it.

> +	bus-width = <8>;

I'm not sure what this property should reflect.
Both cm-t3530 and cm-t3730 use 4 bit MMC1 bus.

> +};
> +
> +&twl_gpio {
> +	ti,use-leds;
> +};
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
> new file mode 100644
> index 0000000..2df885b
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
> @@ -0,0 +1,18 @@
> +/*
> + * Suppport for CompuLab SBC-T3517 with CM-T3517
> + */
> +/dts-v1/;
> +
> +#include "am3517.dtsi"
> +#include "omap3-sb-t35.dtsi"
> +
> +
> +/ {
> +	model = "CompuLab SBC-T3517 with CM-T3517";
> +	compatible = "compulab,omap3-sbc-t3517", "ti,am3517", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */

Can we support multiple memory sizes through static DT, or
the only way is to update this property in the bootloader?

> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
> new file mode 100644
> index 0000000..5156147
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
> @@ -0,0 +1,18 @@
> +/*
> + * Suppport for CompuLab SBC-T3530 with CM-T3530
> + */
> +/dts-v1/;
> +
> +#include "omap34xx.dtsi"
> +#include "omap3-sb-t35.dtsi"
> +
> +
> +/ {
> +	model = "CompuLab SBC-T3530 with CM-T3530";
> +	compatible = "compulab,omap3-sbc-t3530", "ti,omap34xx", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
> new file mode 100644
> index 0000000..836f742
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
> @@ -0,0 +1,130 @@
> +/*
> + * Suppport for CompuLab SBC-T3730 with CM-T3730
> + */
> +/dts-v1/;
> +
> +#include "omap36xx.dtsi"
> +#include "omap3-sb-t35.dtsi"
> +
> +
> +/ {
> +	model = "CompuLab SBC-T3730 with CM-T3730";
> +	compatible = "compulab,omap3-sbc-t3730", "ti,omap36xx", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +
> +	wl12xx_vmmc2: wl12xx_vmmc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vw1271";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wl12xx_gpio>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;   /* gpio73 */
> +		startup-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +
> +	wl12xx_vaux2: wl12xx_vaux2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vwl1271_vaux2";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +		vin-supply = <&vaux2>;
> +	};
> +};
> +
> +&omap3_pmx_core {
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
> +			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
> +			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
> +			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
> +			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
> +			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
> +			0x120 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
> +			0x122 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
> +			0x124 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
> +			0x126 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */

The dat{4,5,6,7} pins are not used either on cm-t3530, or cm-t3730.

> +		>;
> +	};
> +
> +	mmc2_pins: pinmux_mmc2_pins {
> +		pinctrl-single,pins = <
> +			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
> +			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
> +			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
> +			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
> +			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
> +			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */

Here the following is missing:
0x134 (PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */

> +			0x136 (PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat5.sdmmc2_dir_dat1 */
> +			0x138 (PIN_OUTPUT | MUX_MODE1)		/* sdmmc2_dat6.sdmmc2_dir_cmd */
> +			0x13a (PIN_INPUT | MUX_MODE1)		/* sdmmc2_dat7.sdmmc2_clkin */

All four above pins (dat{4,5,6,7}) should be muxed only on cm-t3530.
cm-t3730 uses the sdmmc2_dat4 (gpio136) for wl12xx irq,
and does nor use the rest (dat{5,6,7}) at all.

> +		>;
> +	};
> +
> +	smsc1_pins: pinmux_smsc1_pins {
> +		pinctrl-single,pins = <
> +			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs5.gpmc_ncs5 */
> +			0x16a (PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
> +		>;
> +	};
> +
> +	smsc2_pins: pinmux_smsc2_pins {
> +		pinctrl-single,pins = <
> +			0x86 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs4.gpmc_ncs4 */
> +			0xa2 (PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
> +		>;
> +	};
> +
> +	uart3_pins: pinmux_uart3_pins {
> +		pinctrl-single,pins = <
> +			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
> +			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
> +		>;
> +	};
> +
> +	wl12xx_gpio: pinmux_wl12xx_gpio {
> +		pinctrl-single,pins = <
> +			0xb2 (PIN_OUTPUT | MUX_MODE4)		/* dss_data3.gpio_73 */
> +			0x134 (PIN_INPUT | MUX_MODE4)		/* sdmmc2_dat4.gpio_136 */
> +		>;
> +	};
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&wl12xx_vmmc2>;
> +	vmmc_aux-supply = <&wl12xx_vaux2>;
> +	non-removable;
> +	bus-width = <4>;
> +	cap-power-off-card;
> +};
> +
> +&smsc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&smsc1_pins>;
> +};
> +
> +&smsc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&smsc2_pins>;
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +};
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 78c6233..1a1bfc0 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -93,6 +93,12 @@ static void __init hsmmc2_internal_input_clk(void)
>  	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
>  }
>  
> +static void __init omap3_sbc_t3730_legacy_init(void)
> +{
> +	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 136);
> +	omap_ads7846_init(1, 57, 0, NULL);
> +}
> +
>  static void __init omap3_igep0020_legacy_init(void)
>  {
>  	omap3_igep2_display_init_of();
> @@ -229,6 +235,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
>   */
>  static struct pdata_init pdata_quirks[] __initdata = {
>  #ifdef CONFIG_ARCH_OMAP3
> +	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
>  	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
>  	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
>  	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
> 

-- 
Regards,
Igor.
