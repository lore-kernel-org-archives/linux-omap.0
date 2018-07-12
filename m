From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
Date: Thu, 12 Jul 2018 09:01:33 +0100
Message-ID: <20180712080133.GI6920@n2100.armlinux.org.uk>
References: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neeraj Dantu <dantuguf14105@gmail.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Neeraj Dantu <neeraj.dantu@octavosystems.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2018 at 02:58:22PM +0000, Neeraj Dantu wrote:
> OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> Octavo Systems.
> 
> This board family can be indentified by the A335BNLTOS00 in the at24 eeprom:
> A2: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 4f 53 30 30 |.U3.A335BNLTOS00|]
> 
> https://octavosystems.com/octavo_products/osd3358-sm-red/
> 
> Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Robert Nelson <robertcnelson@gmail.com>
> CC: Jason Kridner <jkridner@gmail.com>
> ---
> Changes in v2:
> - Fix: Add patch description.
> Changes in v3:
> - Add include file for IRQ definitions
> - Add comment about AM335x LCD errata
> - Fix HDMI encoder node name
> 
> Signed-off-by: Neeraj Dantu <neeraj.dantu@octavosystems.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   3 +-
>  arch/arm/boot/dts/am335x-osd3358-sm-red.dts | 457 ++++++++++++++++++++++++++++
>  2 files changed, 459 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..d1ff69c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -698,7 +698,8 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>  	am335x-shc.dtb \
>  	am335x-sbc-t335.dtb \
>  	am335x-sl50.dtb \
> -	am335x-wega-rdk.dtb
> +	am335x-wega-rdk.dtb \
> +	am335x-osd3358-sm-red.dtb
>  dtb-$(CONFIG_ARCH_OMAP4) += \
>  	omap4-droid4-xt894.dtb \
>  	omap4-duovero-parlor.dtb \
> diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> new file mode 100644
> index 0000000..65a9bcb
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> @@ -0,0 +1,457 @@
> +//SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018 Octavo Systems LLC - http://www.octavosystems.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +#include "am335x-osd335x-common.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#include <dt-bindings/display/tda998x.h>
> +
> +/ {
> +	model = "Octavo Systems OSD3358-SM-RED";
> +	compatible = "oct,osd3358-sm-refdesign", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
> +};
> +
> +&ldo3_reg {
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-always-on;
> +};
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmcsd_fixed>;
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&vmmcsd_fixed>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_pins>;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
> +&am33xx_pinmux {
> +	nxp_hdmi_bonelt_pins: nxp-hdmi-bonelt-pins {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
> +			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
> +			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
> +			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
> +			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
> +			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
> +			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
> +			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
> +			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
> +			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
> +			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
> +			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
> +			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
> +			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
> +			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
> +			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
> +			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
> +			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
> +			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
> +			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
> +			AM33XX_IOPAD(0x8ec, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
> +		>;
> +	};
> +
> +	nxp_hdmi_bonelt_off_pins: nxp-hdmi-bonelt-off-pins {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
> +		>;
> +	};
> +
> +	mcasp0_pins: mcasp0-pins {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
> +			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
> +			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
> +			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
> +			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.GPIO1_27 */
> +		>;
> +	};
> +
> +	flash_enable: flash-enable {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7) 	/* rmii1_ref_clk.gpio0_29 */
> +		>;
> +	};
> +
> +	imu_interrupt: imu-interrupt {
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_rx_er.gpio3_2 */
> +		>;
> +	};
> +
> +	ethernet_interrupt: ethernet-interrupt{
> +		pinctrl-single,pins = <
> +			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_col.gpio3_0 */
> +		>;
> +	};
> +};
> +
> +&lcdc {
> +	status = "okay";
> +
> +	/* If you want to get 24 bit RGB and 16 BGR mode instead of
> +	 * current 16 bit RGB and 24 BGR modes, set the propety
> +	 * below to "crossed" and uncomment the video-ports -property
> +	 * in tda19988 node.
> +	 */
> +	blue-and-red-wiring = "straight";
> +
> +	port {
> +		lcdc_0: endpoint@0 {
> +			remote-endpoint = <&hdmi_0>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	hdmiencoder: tda19988 {
> +		compatible = "nxp,tda998x";
> +		reg = <0x70>;
> +
> +		pinctrl-names = "default", "off";
> +		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
> +		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
> +
> +		/* Convert 24bit BGR to RGB, e.g. cross red and blue wiring */
> +		/* AM335x errata for wiring: http://www.ti.com/lit/er/sprz360i/sprz360i.pdf */

Please place the errata comment in the lcdc node above, where it's more
relevant, thanks.

> +		/* video-ports = <0x234501>; */
> +
> +		#sound-dai-cells = <0>;
> +		audio-ports = <	TDA998x_I2S	0x03>;
> +
> +		ports {
> +			port@0 {
> +				hdmi_0: endpoint@0 {
> +					remote-endpoint = <&lcdc_0>;
> +				};
> +			};
> +		};

Most ignore the "ports" and drop the @0 on the port and endpoint nodes
here.  If a node name has a @<addr>, it's usual to also have a reg=
property, which also means you need to add #address-cells to the
parent node.  It's simpler for bindings that only contain one
port and endpoint to just omit the address entirely (as you've
already done in the lcdc description above.)  For a minimal example,
see arch/arm64/boot/dts/arm/juno-base.dtsi

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
