From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 20/39] ARM: dts: am57xx-beagle-x15: Use DRA7XX_CORE_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:58 -0300
Message-ID: <1447390457-1158-21-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macro to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 198 ++++++++++++++++----------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d9ba6b879fc1..d3b2a92e3a3c 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -181,97 +181,97 @@
 &dra7_pmx_core {
 	leds_pins_default: leds_pins_default {
 		pinctrl-single,pins = <
-			0x3a8 (PIN_OUTPUT | MUX_MODE14)	/* spi1_d1.gpio7_8 */
-			0x3ac (PIN_OUTPUT | MUX_MODE14)	/* spi1_d0.gpio7_9 */
-			0x3c0 (PIN_OUTPUT | MUX_MODE14)	/* spi2_sclk.gpio7_14 */
-			0x3c4 (PIN_OUTPUT | MUX_MODE14)	/* spi2_d1.gpio7_15 */
+			DRA7XX_CORE_IOPAD(0x37a8, PIN_OUTPUT | MUX_MODE14)	/* spi1_d1.gpio7_8 */
+			DRA7XX_CORE_IOPAD(0x37ac, PIN_OUTPUT | MUX_MODE14)	/* spi1_d0.gpio7_9 */
+			DRA7XX_CORE_IOPAD(0x37c0, PIN_OUTPUT | MUX_MODE14)	/* spi2_sclk.gpio7_14 */
+			DRA7XX_CORE_IOPAD(0x37c4, PIN_OUTPUT | MUX_MODE14)	/* spi2_d1.gpio7_15 */
 		>;
 	};
 
 	i2c1_pins_default: i2c1_pins_default {
 		pinctrl-single,pins = <
-			0x400 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda.sda */
-			0x404 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl.scl */
+			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda.sda */
+			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl.scl */
 		>;
 	};
 
 	hdmi_pins: pinmux_hdmi_pins {
 		pinctrl-single,pins = <
-			0x408 (PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
-			0x40c (PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
 		>;
 	};
 
 	i2c3_pins_default: i2c3_pins_default {
 		pinctrl-single,pins = <
-			0x2a4 (PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
-			0x2a8 (PIN_INPUT| MUX_MODE10)	/* mcasp1_fsx.i2c3_scl */
+			DRA7XX_CORE_IOPAD(0x36a4, PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
+			DRA7XX_CORE_IOPAD(0x36a8, PIN_INPUT| MUX_MODE10)	/* mcasp1_fsx.i2c3_scl */
 		>;
 	};
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
-			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
+			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
+			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
 		>;
 	};
 
 	mmc1_pins_default: mmc1_pins_default {
 		pinctrl-single,pins = <
-			0x36c (PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
-			0x354 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
-			0x358 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			0x35c (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			0x360 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			0x364 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			0x368 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
 		>;
 	};
 
 	mmc2_pins_default: mmc2_pins_default {
 		pinctrl-single,pins = <
-			0x9c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
-			0xb0 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
-			0xa0 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
-			0xa4 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
-			0xa8 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
-			0xac (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
-			0x8c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
-			0x90 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
-			0x94 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
-			0x98 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
+			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
+			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
+			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
+			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
+			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
+			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
+			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
+			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
+			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
+			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
 
 	cpsw_pins_default: cpsw_pins_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x250 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
-			0x254 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
-			0x258 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
-			0x25c (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
-			0x260 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
-			0x264 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
-			0x268 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
-			0x26c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
-			0x270 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
-			0x274 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
-			0x278 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
-			0x27c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
+			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
+			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
+			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
+			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
+			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
 
 			/* Slave 2 */
-			0x198 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
-			0x19c (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
-			0x1a0 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
-			0x1a4 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
-			0x1a8 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
-			0x1ac (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
-			0x1b0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
-			0x1b4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
-			0x1b8 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
-			0x1bc (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
-			0x1c0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
-			0x1c4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
+			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
 		>;
 
 	};
@@ -279,115 +279,115 @@
 	cpsw_pins_sleep: cpsw_pins_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x250 (PIN_INPUT | MUX_MODE15)
-			0x254 (PIN_INPUT | MUX_MODE15)
-			0x258 (PIN_INPUT | MUX_MODE15)
-			0x25c (PIN_INPUT | MUX_MODE15)
-			0x260 (PIN_INPUT | MUX_MODE15)
-			0x264 (PIN_INPUT | MUX_MODE15)
-			0x268 (PIN_INPUT | MUX_MODE15)
-			0x26c (PIN_INPUT | MUX_MODE15)
-			0x270 (PIN_INPUT | MUX_MODE15)
-			0x274 (PIN_INPUT | MUX_MODE15)
-			0x278 (PIN_INPUT | MUX_MODE15)
-			0x27c (PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3650, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3654, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3658, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x365c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3660, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3664, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE15)
 
 			/* Slave 2 */
-			0x198 (PIN_INPUT | MUX_MODE15)
-			0x19c (PIN_INPUT | MUX_MODE15)
-			0x1a0 (PIN_INPUT | MUX_MODE15)
-			0x1a4 (PIN_INPUT | MUX_MODE15)
-			0x1a8 (PIN_INPUT | MUX_MODE15)
-			0x1ac (PIN_INPUT | MUX_MODE15)
-			0x1b0 (PIN_INPUT | MUX_MODE15)
-			0x1b4 (PIN_INPUT | MUX_MODE15)
-			0x1b8 (PIN_INPUT | MUX_MODE15)
-			0x1bc (PIN_INPUT | MUX_MODE15)
-			0x1c0 (PIN_INPUT | MUX_MODE15)
-			0x1c4 (PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3598, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x359c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE15)
 		>;
 	};
 
 	davinci_mdio_pins_default: davinci_mdio_pins_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x23c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_mclk */
-			0x240 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
+			DRA7XX_CORE_IOPAD(0x363c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_mclk */
+			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
 		>;
 	};
 
 	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
 		pinctrl-single,pins = <
-			0x23c (PIN_INPUT | MUX_MODE15)
-			0x240 (PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x363c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT | MUX_MODE15)
 		>;
 	};
 
 	tps659038_pins_default: tps659038_pins_default {
 		pinctrl-single,pins = <
-			0x418 (PIN_INPUT_PULLUP | MUX_MODE14)	/* wakeup0.gpio1_0 */
+			DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14)	/* wakeup0.gpio1_0 */
 		>;
 	};
 
 	tmp102_pins_default: tmp102_pins_default {
 		pinctrl-single,pins = <
-			0x3C8 (PIN_INPUT_PULLUP | MUX_MODE14)	/* spi2_d0.gpio7_16 */
+			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_PULLUP | MUX_MODE14)	/* spi2_d0.gpio7_16 */
 		>;
 	};
 
 	mcp79410_pins_default: mcp79410_pins_default {
 		pinctrl-single,pins = <
-			0x424 (PIN_INPUT_PULLUP | MUX_MODE1)	/* wakeup3.sys_nirq1 */
+			DRA7XX_CORE_IOPAD(0x3824, PIN_INPUT_PULLUP | MUX_MODE1)	/* wakeup3.sys_nirq1 */
 		>;
 	};
 
 	usb1_pins: pinmux_usb1_pins {
 		pinctrl-single,pins = <
-			0x280 (PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
 		>;
 	};
 
 	extcon_usb1_pins: extcon_usb1_pins {
 		pinctrl-single,pins = <
-			0x3ec (PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_rtsn.gpio7_25 */
+			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_rtsn.gpio7_25 */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x3b0 (PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
-			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
-			0x370 (PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
+			DRA7XX_CORE_IOPAD(0x37b0, PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
+			DRA7XX_CORE_IOPAD(0x3770, PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
 		>;
 	};
 
 	clkout2_pins_default: clkout2_pins_default {
 		pinctrl-single,pins = <
-			0x294 (PIN_OUTPUT_PULLDOWN | MUX_MODE9)	/* xref_clk0.clkout2 */
+			DRA7XX_CORE_IOPAD(0x3694, PIN_OUTPUT_PULLDOWN | MUX_MODE9)	/* xref_clk0.clkout2 */
 		>;
 	};
 
 	clkout2_pins_sleep: clkout2_pins_sleep {
 		pinctrl-single,pins = <
-			0x294 (PIN_INPUT | MUX_MODE15)	/* xref_clk0.clkout2 */
+			DRA7XX_CORE_IOPAD(0x3694, PIN_INPUT | MUX_MODE15)	/* xref_clk0.clkout2 */
 		>;
 	};
 
 	mcasp3_pins_default: mcasp3_pins_default {
 		pinctrl-single,pins = <
-			0x324 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_aclkx.mcasp3_aclkx */
-			0x328 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_fsx.mcasp3_fsx */
-			0x32c (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr0.mcasp3_axr0 */
-			0x330 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr1.mcasp3_axr1 */
+			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_aclkx.mcasp3_aclkx */
+			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_fsx.mcasp3_fsx */
+			DRA7XX_CORE_IOPAD(0x372c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr0.mcasp3_axr0 */
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr1.mcasp3_axr1 */
 		>;
 	};
 
 	mcasp3_pins_sleep: mcasp3_pins_sleep {
 		pinctrl-single,pins = <
-			0x324 (PIN_INPUT | MUX_MODE15)
-			0x328 (PIN_INPUT | MUX_MODE15)
-			0x32c (PIN_INPUT | MUX_MODE15)
-			0x330 (PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x372c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT | MUX_MODE15)
 		>;
 	};
 };
-- 
2.4.3
