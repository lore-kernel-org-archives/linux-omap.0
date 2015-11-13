From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 16/39] ARM: dts: am437x-gp-evm: Use AM4372_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:54 -0300
Message-ID: <1447390457-1158-17-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am437x-gp-evm.dts | 380 ++++++++++++++++++------------------
 1 file changed, 190 insertions(+), 190 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index d2450ab0a380..7f00e85eebed 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -154,138 +154,138 @@
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: i2c1_pins {
 		pinctrl-single,pins = <
-			0x15c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
-			0x158 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+			AM4372_IOPAD(0x95c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
+			AM4372_IOPAD(0x958, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
-			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			AM4372_IOPAD(0x964, MUX_MODE0)       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 		>;
 	};
 
 	pixcir_ts_pins: pixcir_ts_pins {
 		pinctrl-single,pins = <
-			0x264 (PIN_INPUT_PULLUP | MUX_MODE7)  /* spi2_d0.gpio3_22 */
+			AM4372_IOPAD(0xa64, PIN_INPUT_PULLUP | MUX_MODE7)  /* spi2_d0.gpio3_22 */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_txen */
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rxctl */
-			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd3 */
-			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd2 */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
-			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd3 */
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd2 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM4372_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_txen */
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rxctl */
+			AM4372_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd3 */
+			AM4372_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd2 */
+			AM4372_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
+			AM4372_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
+			AM4372_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd3 */
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd2 */
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM4372_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM4372_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	nand_flash_x8: nand_flash_x8 {
 		pinctrl-single,pins = <
-			0x0  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			0x4  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			0x8  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			0xc  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			0x10 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			0x14 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			0x18 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			0x1c (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
-			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM4372_IOPAD(0x800, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM4372_IOPAD(0x804, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM4372_IOPAD(0x808, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM4372_IOPAD(0x810, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM4372_IOPAD(0x814, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM4372_IOPAD(0x818, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM4372_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM4372_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
+			AM4372_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM4372_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM4372_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM4372_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM4372_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 
 	dss_pins: dss_pins {
 		pinctrl-single,pins = <
-			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
-			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x02c (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x03c (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
-			0x0a0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
-			0x0a4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0a8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0ac (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0bc (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0cc (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0dc (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
-			0x0e0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
-			0x0e4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
-			0x0e8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
-			0x0ec (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			AM4372_IOPAD(0x820, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+			AM4372_IOPAD(0x824, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x828, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x82c, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x830, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x834, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x838, PIN_OUTPUT_PULLUP | MUX_MODE1)
+			AM4372_IOPAD(0x83c, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+			AM4372_IOPAD(0x8a0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			AM4372_IOPAD(0x8a4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8a8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8ac, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8bc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8cc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8dc, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+			AM4372_IOPAD(0x8e0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+			AM4372_IOPAD(0x8e4, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+			AM4372_IOPAD(0x8e8, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+			AM4372_IOPAD(0x8ec, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
 
 		>;
 	};
@@ -293,208 +293,208 @@
 	display_mux_pins: display_mux_pins {
 		pinctrl-single,pins = <
 			/* GPIO 5_8 to select LCD / HDMI */
-			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM4372_IOPAD(0xa38, PIN_OUTPUT_PULLUP | MUX_MODE7)
 		>;
 	};
 
 	dcan0_default: dcan0_default_pins {
 		pinctrl-single,pins = <
-			0x178 (PIN_OUTPUT | MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
-			0x17c (PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
+			AM4372_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)		/* uart1_ctsn.d_can0_tx */
+			AM4372_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_rtsn.d_can0_rx */
 		>;
 	};
 
 	dcan0_sleep: dcan0_sleep_pins {
 		pinctrl-single,pins = <
-			0x178 (PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_ctsn.gpio0_12 */
-			0x17c (PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_rtsn.gpio0_13 */
+			AM4372_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_ctsn.gpio0_12 */
+			AM4372_IOPAD(0x97c, PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_rtsn.gpio0_13 */
 		>;
 	};
 
 	dcan1_default: dcan1_default_pins {
 		pinctrl-single,pins = <
-			0x180 (PIN_OUTPUT | MUX_MODE2)		/* uart1_rxd.d_can1_tx */
-			0x184 (PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_txd.d_can1_rx */
+			AM4372_IOPAD(0x980, PIN_OUTPUT | MUX_MODE2)		/* uart1_rxd.d_can1_tx */
+			AM4372_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_txd.d_can1_rx */
 		>;
 	};
 
 	dcan1_sleep: dcan1_sleep_pins {
 		pinctrl-single,pins = <
-			0x180 (PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_rxd.gpio0_14 */
-			0x184 (PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_txd.gpio0_15 */
+			AM4372_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_rxd.gpio0_14 */
+			AM4372_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE7)	/* uart1_txd.gpio0_15 */
 		>;
 	};
 
 	vpfe0_pins_default: vpfe0_pins_default {
 		pinctrl-single,pins = <
-			0x1B0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
-			0x1B4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
-			0x1C0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_pclk mode 0*/
-			0x1C4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data8 mode 0*/
-			0x1C8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data9 mode 0*/
-			0x208 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data0 mode 0*/
-			0x20C (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data1 mode 0*/
-			0x210 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data2 mode 0*/
-			0x214 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data3 mode 0*/
-			0x218 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data4 mode 0*/
-			0x21C (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data5 mode 0*/
-			0x220 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data6 mode 0*/
-			0x224 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data7 mode 0*/
+			AM4372_IOPAD(0x9b0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
+			AM4372_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
+			AM4372_IOPAD(0x9c0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_pclk mode 0*/
+			AM4372_IOPAD(0x9c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data8 mode 0*/
+			AM4372_IOPAD(0x9c8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data9 mode 0*/
+			AM4372_IOPAD(0xa08, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data0 mode 0*/
+			AM4372_IOPAD(0xa0c, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data1 mode 0*/
+			AM4372_IOPAD(0xa10, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data2 mode 0*/
+			AM4372_IOPAD(0xa14, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data3 mode 0*/
+			AM4372_IOPAD(0xa18, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data4 mode 0*/
+			AM4372_IOPAD(0xa1c, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data5 mode 0*/
+			AM4372_IOPAD(0xa20, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data6 mode 0*/
+			AM4372_IOPAD(0xa24, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data7 mode 0*/
 		>;
 	};
 
 	vpfe0_pins_sleep: vpfe0_pins_sleep {
 		pinctrl-single,pins = <
-			0x1B0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_hd mode 0*/
-			0x1B4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_vd mode 0*/
-			0x1C0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_pclk mode 0*/
-			0x1C4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data8 mode 0*/
-			0x1C8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data9 mode 0*/
-			0x208 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data0 mode 0*/
-			0x20C (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data1 mode 0*/
-			0x210 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data2 mode 0*/
-			0x214 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data3 mode 0*/
-			0x218 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data4 mode 0*/
-			0x21C (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data5 mode 0*/
-			0x220 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data6 mode 0*/
-			0x224 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data7 mode 0*/
+			AM4372_IOPAD(0x9b0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_hd mode 0*/
+			AM4372_IOPAD(0x9b4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_vd mode 0*/
+			AM4372_IOPAD(0x9c0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_pclk mode 0*/
+			AM4372_IOPAD(0x9c4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data8 mode 0*/
+			AM4372_IOPAD(0x9c8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data9 mode 0*/
+			AM4372_IOPAD(0xa08, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data0 mode 0*/
+			AM4372_IOPAD(0xa0c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data1 mode 0*/
+			AM4372_IOPAD(0xa10, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data2 mode 0*/
+			AM4372_IOPAD(0xa14, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data3 mode 0*/
+			AM4372_IOPAD(0xa18, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data4 mode 0*/
+			AM4372_IOPAD(0xa1c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data5 mode 0*/
+			AM4372_IOPAD(0xa20, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data6 mode 0*/
+			AM4372_IOPAD(0xa24, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data7 mode 0*/
 		>;
 	};
 
 	vpfe1_pins_default: vpfe1_pins_default {
 		pinctrl-single,pins = <
-			0x1CC (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data9 mode 0*/
-			0x1D0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data8 mode 0*/
-			0x1D4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_hd mode 0*/
-			0x1D8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_vd mode 0*/
-			0x1DC (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_pclk mode 0*/
-			0x1E8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data0 mode 0*/
-			0x1EC (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data1 mode 0*/
-			0x1F0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data2 mode 0*/
-			0x1F4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data3 mode 0*/
-			0x1F8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data4 mode 0*/
-			0x1FC (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data5 mode 0*/
-			0x200 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data6 mode 0*/
-			0x204 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data7 mode 0*/
+			AM4372_IOPAD(0x9cc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data9 mode 0*/
+			AM4372_IOPAD(0x9d0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data8 mode 0*/
+			AM4372_IOPAD(0x9d4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_hd mode 0*/
+			AM4372_IOPAD(0x9d8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_vd mode 0*/
+			AM4372_IOPAD(0x9dC, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_pclk mode 0*/
+			AM4372_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data0 mode 0*/
+			AM4372_IOPAD(0x9ec, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data1 mode 0*/
+			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data2 mode 0*/
+			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data3 mode 0*/
+			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data4 mode 0*/
+			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data5 mode 0*/
+			AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data6 mode 0*/
+			AM4372_IOPAD(0xa04, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data7 mode 0*/
 		>;
 	};
 
 	vpfe1_pins_sleep: vpfe1_pins_sleep {
 		pinctrl-single,pins = <
-			0x1CC (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data9 mode 0*/
-			0x1D0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data8 mode 0*/
-			0x1D4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_hd mode 0*/
-			0x1D8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_vd mode 0*/
-			0x1DC (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_pclk mode 0*/
-			0x1E8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data0 mode 0*/
-			0x1EC (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data1 mode 0*/
-			0x1F0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data2 mode 0*/
-			0x1F4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data3 mode 0*/
-			0x1F8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data4 mode 0*/
-			0x1FC (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data5 mode 0*/
-			0x200 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data6 mode 0*/
-			0x204 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data7 mode 0*/
+			AM4372_IOPAD(0x9cc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data9 mode 0*/
+			AM4372_IOPAD(0x9d0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data8 mode 0*/
+			AM4372_IOPAD(0x9d4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_hd mode 0*/
+			AM4372_IOPAD(0x9d8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_vd mode 0*/
+			AM4372_IOPAD(0x9dc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_pclk mode 0*/
+			AM4372_IOPAD(0x9e8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data0 mode 0*/
+			AM4372_IOPAD(0x9ec, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data1 mode 0*/
+			AM4372_IOPAD(0x9f0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data2 mode 0*/
+			AM4372_IOPAD(0x9f4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data3 mode 0*/
+			AM4372_IOPAD(0x9f8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data4 mode 0*/
+			AM4372_IOPAD(0x9fc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data5 mode 0*/
+			AM4372_IOPAD(0xa00, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data6 mode 0*/
+			AM4372_IOPAD(0xa04, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data7 mode 0*/
 		>;
 	};
 
 	mmc3_pins_default: pinmux_mmc3_pins_default {
 		pinctrl-single,pins = <
-			0x8c (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_clk.mmc2_clk */
-			0x88 (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_csn3.mmc2_cmd */
-			0x44 (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a1.mmc2_dat0 */
-			0x48 (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a2.mmc2_dat1 */
-			0x4c (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a3.mmc2_dat2 */
-			0x78 (PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_be1n.mmc2_dat3 */
+			AM4372_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_clk.mmc2_clk */
+			AM4372_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_csn3.mmc2_cmd */
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a1.mmc2_dat0 */
+			AM4372_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a2.mmc2_dat1 */
+			AM4372_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a3.mmc2_dat2 */
+			AM4372_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_be1n.mmc2_dat3 */
 		>;
 	};
 
 	mmc3_pins_sleep: pinmux_mmc3_pins_sleep {
 		pinctrl-single,pins = <
-			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_clk.mmc2_clk */
-			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.mmc2_cmd */
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a1.mmc2_dat0 */
-			0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a2.mmc2_dat1 */
-			0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a3.mmc2_dat2 */
-			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_be1n.mmc2_dat3 */
+			AM4372_IOPAD(0x88c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_clk.mmc2_clk */
+			AM4372_IOPAD(0x888, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.mmc2_cmd */
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a1.mmc2_dat0 */
+			AM4372_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a2.mmc2_dat1 */
+			AM4372_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a3.mmc2_dat2 */
+			AM4372_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_be1n.mmc2_dat3 */
 		>;
 	};
 
 	wlan_pins_default: pinmux_wlan_pins_default {
 		pinctrl-single,pins = <
-			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a4.gpio1_20 WL_EN */
-			0x5c (PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)	/* gpmc_a7.gpio1_23 WL_IRQ*/
-			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a0.gpio1_16 BT_EN*/
+			AM4372_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a4.gpio1_20 WL_EN */
+			AM4372_IOPAD(0x85c, PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)	/* gpmc_a7.gpio1_23 WL_IRQ*/
+			AM4372_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a0.gpio1_16 BT_EN*/
 		>;
 	};
 
 	wlan_pins_sleep: pinmux_wlan_pins_sleep {
 		pinctrl-single,pins = <
-			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a4.gpio1_20 WL_EN */
-			0x5c (PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)	/* gpmc_a7.gpio1_23 WL_IRQ*/
-			0x40 (PIN_OUTPUT_PULLUP | MUX_MODE7)		/* gpmc_a0.gpio1_16 BT_EN*/
+			AM4372_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a4.gpio1_20 WL_EN */
+			AM4372_IOPAD(0x85c, PIN_INPUT | WAKEUP_ENABLE | MUX_MODE7)	/* gpmc_a7.gpio1_23 WL_IRQ*/
+			AM4372_IOPAD(0x840, PIN_OUTPUT_PULLUP | MUX_MODE7)		/* gpmc_a0.gpio1_16 BT_EN*/
 		>;
 	};
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			0x228 (PIN_INPUT | MUX_MODE0)		/* uart3_rxd.uart3_rxd */
-			0x22c (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_txd.uart3_txd */
-			0x230 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_ctsn.uart3_ctsn */
-			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
+			AM4372_IOPAD(0xa28, PIN_INPUT | MUX_MODE0)		/* uart3_rxd.uart3_rxd */
+			AM4372_IOPAD(0xa2c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_txd.uart3_txd */
+			AM4372_IOPAD(0xa30, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_ctsn.uart3_ctsn */
+			AM4372_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
+			AM4372_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
 	mcasp1_sleep_pins: mcasp1_sleep_pins {
 		pinctrl-single,pins = <
-			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	gpio0_pins: gpio0_pins {
 		pinctrl-single,pins = <
-			0x26c (PIN_OUTPUT | MUX_MODE9) /* spi2_cs0.gpio0_23 SEL_eMMCorNANDn */
+			AM4372_IOPAD(0xa6c, PIN_OUTPUT | MUX_MODE9) /* spi2_cs0.gpio0_23 SEL_eMMCorNANDn */
 		>;
 	};
 
 	emmc_pins_default: emmc_pins_default {
 		pinctrl-single,pins = <
-			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			0x0c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
-			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM4372_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM4372_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM4372_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM4372_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
+			AM4372_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
+			AM4372_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
 		>;
 	};
 
 	emmc_pins_sleep: emmc_pins_sleep {
 		pinctrl-single,pins = <
-			0x00 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad0.gpio1_0 */
-			0x04 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad1.gpio1_1 */
-			0x08 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad2.gpio1_2 */
-			0x0c (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad3.gpio1_3 */
-			0x10 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad4.gpio1_4 */
-			0x14 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad5.gpio1_5 */
-			0x18 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad6.gpio1_6 */
-			0x1c (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad7.gpio1_7 */
-			0x80 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn1.gpio1_30 */
-			0x84 (PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn2.gpio1_31 */
+			AM4372_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad0.gpio1_0 */
+			AM4372_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad1.gpio1_1 */
+			AM4372_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad2.gpio1_2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad3.gpio1_3 */
+			AM4372_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad4.gpio1_4 */
+			AM4372_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad5.gpio1_5 */
+			AM4372_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad6.gpio1_6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad7.gpio1_7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn1.gpio1_30 */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn2.gpio1_31 */
 		>;
 	};
 };
-- 
2.4.3
