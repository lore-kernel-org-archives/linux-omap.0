From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 18/39] ARM: dts: am437x-sk-evm: Use AM4372_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:56 -0300
Message-ID: <1447390457-1158-19-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am437x-sk-evm.dts | 298 ++++++++++++++++++------------------
 1 file changed, 149 insertions(+), 149 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 63de2a1b4315..d82dd6e3f9b1 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -157,259 +157,259 @@
 &am43xx_pinmux {
 	matrix_keypad_pins: matrix_keypad_pins {
 		pinctrl-single,pins = <
-			0x24c (PIN_OUTPUT | MUX_MODE7)	/* gpio5_13.gpio5_13 */
-			0x250 (PIN_OUTPUT | MUX_MODE7)	/* spi4_sclk.gpio5_4 */
-			0x254 (PIN_INPUT | MUX_MODE7)	/* spi4_d0.gpio5_5 */
-			0x258 (PIN_INPUT | MUX_MODE7)	/* spi4_d1.gpio5_5 */
+			AM4372_IOPAD(0xa4c, PIN_OUTPUT | MUX_MODE7)	/* gpio5_13.gpio5_13 */
+			AM4372_IOPAD(0xa50, PIN_OUTPUT | MUX_MODE7)	/* spi4_sclk.gpio5_4 */
+			AM4372_IOPAD(0xa54, PIN_INPUT | MUX_MODE7)	/* spi4_d0.gpio5_5 */
+			AM4372_IOPAD(0xa58, PIN_INPUT | MUX_MODE7)	/* spi4_d1.gpio5_5 */
 		>;
 	};
 
 	leds_pins: leds_pins {
 		pinctrl-single,pins = <
-			0x228 (PIN_OUTPUT | MUX_MODE7)	/* uart3_rxd.gpio5_2 */
-			0x22c (PIN_OUTPUT | MUX_MODE7)	/* uart3_txd.gpio5_3 */
-			0x230 (PIN_OUTPUT | MUX_MODE7)	/* uart3_ctsn.gpio5_0 */
-			0x234 (PIN_OUTPUT | MUX_MODE7)	/* uart3_rtsn.gpio5_1 */
+			AM4372_IOPAD(0xa28, PIN_OUTPUT | MUX_MODE7)	/* uart3_rxd.gpio5_2 */
+			AM4372_IOPAD(0xa2c, PIN_OUTPUT | MUX_MODE7)	/* uart3_txd.gpio5_3 */
+			AM4372_IOPAD(0xa30, PIN_OUTPUT | MUX_MODE7)	/* uart3_ctsn.gpio5_0 */
+			AM4372_IOPAD(0xa34, PIN_OUTPUT | MUX_MODE7)	/* uart3_rtsn.gpio5_1 */
 		>;
 	};
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: i2c1_pins {
 		pinctrl-single,pins = <
-			0x15c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
-			0x158 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+			AM4372_IOPAD(0x95c, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
+			AM4372_IOPAD(0x958, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x0f0 (PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			0x0f4 (PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			0x0f8 (PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			0x0fc (PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x8f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			AM4372_IOPAD(0x8f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			AM4372_IOPAD(0x8f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			AM4372_IOPAD(0x8fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			AM4372_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			AM4372_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
-			0x164 (PIN_OUTPUT | MUX_MODE0) /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out */
+			AM4372_IOPAD(0x964, PIN_OUTPUT | MUX_MODE0) /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out */
 		>;
 	};
 
 	edt_ft5306_ts_pins: edt_ft5306_ts_pins {
 		pinctrl-single,pins = <
-			0x74 (PIN_INPUT | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
-			0x78 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_be1n.gpio1_28 */
+			AM4372_IOPAD(0x874, PIN_INPUT | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
+			AM4372_IOPAD(0x878, PIN_OUTPUT | MUX_MODE7)	/* gpmc_be1n.gpio1_28 */
 		>;
 	};
 
 	vpfe0_pins_default: vpfe0_pins_default {
 		pinctrl-single,pins = <
-			0x1b0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
-			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
-			0x1b8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_field mode 0*/
-			0x1bc (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_wen mode 0*/
-			0x1c0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_pclk mode 0*/
-			0x1c4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data8 mode 0*/
-			0x1c8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data9 mode 0*/
-			0x208 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data0 mode 0*/
-			0x20c (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data1 mode 0*/
-			0x210 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data2 mode 0*/
-			0x214 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data3 mode 0*/
-			0x218 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data4 mode 0*/
-			0x21c (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data5 mode 0*/
-			0x220 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data6 mode 0*/
-			0x224 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data7 mode 0*/
+			AM4372_IOPAD(0x9b0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
+			AM4372_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
+			AM4372_IOPAD(0x9b8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_field mode 0*/
+			AM4372_IOPAD(0x9bc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_wen mode 0*/
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
-			0x1b0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1b4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1b8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1bc (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1c0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1c4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x1c8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x208 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x20c (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x210 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x214 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x218 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x21c (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x220 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-			0x224 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9b0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9b4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9b8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9bc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9c0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9c4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0x9c8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa08, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa0c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa10, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa14, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa18, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa1c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa20, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+			AM4372_IOPAD(0xa24, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x12c (PIN_OUTPUT | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
-			0x114 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			0x128 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			0x124 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			0x120 (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
-			0x11c (PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
-			0x130 (PIN_INPUT | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
-			0x118 (PIN_INPUT | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			0x140 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
-			0x13c (PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			0x138 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
-			0x134 (PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
+			AM4372_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
+			AM4372_IOPAD(0x914, PIN_OUTPUT | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM4372_IOPAD(0x928, PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM4372_IOPAD(0x924, PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM4372_IOPAD(0x920, PIN_OUTPUT | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
+			AM4372_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
+			AM4372_IOPAD(0x930, PIN_INPUT | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			AM4372_IOPAD(0x918, PIN_INPUT | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM4372_IOPAD(0x940, PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM4372_IOPAD(0x93c, PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM4372_IOPAD(0x938, PIN_INPUT | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
+			AM4372_IOPAD(0x934, PIN_INPUT | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
 
 			/* Slave 2 */
-			0x58 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			0x40 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			0x54 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			0x50 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			0x4c (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			0x48 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			0x5c (PIN_INPUT | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			0x44 (PIN_INPUT | MUX_MODE2)	/* gpmc_a1.rgmii2_rtcl */
-			0x6c (PIN_INPUT | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
-			0x68 (PIN_INPUT | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			0x64 (PIN_INPUT | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			0x60 (PIN_INPUT | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM4372_IOPAD(0x858, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM4372_IOPAD(0x840, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM4372_IOPAD(0x854, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM4372_IOPAD(0x850, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM4372_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM4372_IOPAD(0x848, PIN_OUTPUT | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM4372_IOPAD(0x85c, PIN_INPUT | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM4372_IOPAD(0x844, PIN_INPUT | MUX_MODE2)	/* gpmc_a1.rgmii2_rtcl */
+			AM4372_IOPAD(0x86c, PIN_INPUT | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM4372_IOPAD(0x868, PIN_INPUT | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM4372_IOPAD(0x864, PIN_INPUT | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM4372_IOPAD(0x860, PIN_INPUT | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
 
 			/* Slave 2 reset value */
-			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM4372_IOPAD(0x948, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM4372_IOPAD(0x94c, PIN_OUTPUT | MUX_MODE0)			/* mdio_clk.mdio_clk */
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
 
 	dss_pins: dss_pins {
 		pinctrl-single,pins = <
-			0x020 (PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
-			0x024 (PIN_OUTPUT | MUX_MODE1)
-			0x028 (PIN_OUTPUT | MUX_MODE1)
-			0x02c (PIN_OUTPUT | MUX_MODE1)
-			0x030 (PIN_OUTPUT | MUX_MODE1)
-			0x034 (PIN_OUTPUT | MUX_MODE1)
-			0x038 (PIN_OUTPUT | MUX_MODE1)
-			0x03c (PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
-			0x0a0 (PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 0 */
-			0x0a4 (PIN_OUTPUT | MUX_MODE0)
-			0x0a8 (PIN_OUTPUT | MUX_MODE0)
-			0x0ac (PIN_OUTPUT | MUX_MODE0)
-			0x0b0 (PIN_OUTPUT | MUX_MODE0)
-			0x0b4 (PIN_OUTPUT | MUX_MODE0)
-			0x0b8 (PIN_OUTPUT | MUX_MODE0)
-			0x0bc (PIN_OUTPUT | MUX_MODE0)
-			0x0c0 (PIN_OUTPUT | MUX_MODE0)
-			0x0c4 (PIN_OUTPUT | MUX_MODE0)
-			0x0c8 (PIN_OUTPUT | MUX_MODE0)
-			0x0cc (PIN_OUTPUT | MUX_MODE0)
-			0x0d0 (PIN_OUTPUT | MUX_MODE0)
-			0x0d4 (PIN_OUTPUT | MUX_MODE0)
-			0x0d8 (PIN_OUTPUT | MUX_MODE0)
-			0x0dc (PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 15 */
-			0x0e0 (PIN_OUTPUT | MUX_MODE0)	/* DSS VSYNC */
-			0x0e4 (PIN_OUTPUT | MUX_MODE0)	/* DSS HSYNC */
-			0x0e8 (PIN_OUTPUT | MUX_MODE0)	/* DSS PCLK */
-			0x0ec (PIN_OUTPUT | MUX_MODE0)	/* DSS AC BIAS EN */
+			AM4372_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
+			AM4372_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)
+			AM4372_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
+			AM4372_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 0 */
+			AM4372_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)
+			AM4372_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 15 */
+			AM4372_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* DSS VSYNC */
+			AM4372_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* DSS HSYNC */
+			AM4372_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* DSS PCLK */
+			AM4372_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* DSS AC BIAS EN */
 
 		>;
 	};
 
 	qspi_pins: qspi_pins {
 		pinctrl-single,pins = <
-			0x7c (PIN_OUTPUT | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
-			0x88 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_csn3.qspi_clk */
-			0x90 (PIN_INPUT | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
-			0x94 (PIN_INPUT | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
-			0x98 (PIN_INPUT | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
-			0x9c (PIN_INPUT | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
+			AM4372_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
+			AM4372_IOPAD(0x888, PIN_OUTPUT | MUX_MODE2)	/* gpmc_csn3.qspi_clk */
+			AM4372_IOPAD(0x890, PIN_INPUT | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
+			AM4372_IOPAD(0x894, PIN_INPUT | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
+			AM4372_IOPAD(0x898, PIN_INPUT | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
+			AM4372_IOPAD(0x89c, PIN_INPUT | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
-			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
+			AM4372_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
 	mcasp1_pins_sleep: mcasp1_pins_sleep {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
-			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
+			AM4372_IOPAD(0x81c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
 		>;
 	};
 
 	usb1_pins: usb1_pins {
 		pinctrl-single,pins = <
-			0x2c0 (PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
+			AM4372_IOPAD(0xac0, PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
 		>;
 	};
 
 	usb2_pins: usb2_pins {
 		pinctrl-single,pins = <
-			0x2c4 (PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
+			AM4372_IOPAD(0xac4, PIN_OUTPUT | MUX_MODE0) /* usb0_drvvbus.usb0_drvvbus */
 		>;
 	};
 };
-- 
2.4.3
