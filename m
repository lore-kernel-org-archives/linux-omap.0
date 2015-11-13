From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 17/39] ARM: dts: am437x-idk-evm: Use AM4372_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:55 -0300
Message-ID: <1447390457-1158-18-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am437x-idk-evm.dts | 128 +++++++++++++++++------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 337fb91ee74c..76dcfc6d5f0d 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -122,137 +122,137 @@
 &am43xx_pinmux {
 	gpio_keys_pins_default: gpio_keys_pins_default {
 		pinctrl-single,pins = <
-			0x1b8 (PIN_INPUT | MUX_MODE7)	/* cam0_field.gpio4_2 */
+			AM4372_IOPAD(0x9b8, PIN_INPUT | MUX_MODE7)	/* cam0_field.gpio4_2 */
 		>;
 	};
 
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c0_pins_sleep: i2c0_pins_sleep {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x18c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x98c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	i2c2_pins_default: i2c2_pins_default {
 		pinctrl-single,pins = <
-			0x1e8 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data1.i2c2_scl */
-			0x1ec (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data0.i2c2_sda */
+			AM4372_IOPAD(0x9e8, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data1.i2c2_scl */
+			AM4372_IOPAD(0x9ec, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data0.i2c2_sda */
 		>;
 	};
 
 	i2c2_pins_sleep: i2c2_pins_sleep {
 		pinctrl-single,pins = <
-			0x1e8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x1ec (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9e8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9ec, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	mmc1_pins_default: pinmux_mmc1_pins_default {
 		pinctrl-single,pins = <
-			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			0x1f0 (PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			0x1f4 (PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			0x1f8 (PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			0x1fc (PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			AM4372_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			AM4372_IOPAD(0x9f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			AM4372_IOPAD(0x9f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			AM4372_IOPAD(0x9f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			AM4372_IOPAD(0x9fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	mmc1_pins_sleep: pinmux_mmc1_pins_sleep {
 		pinctrl-single,pins = <
-			0x100 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x104 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x1f0 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x1f4 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x1f8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x1fc (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x160 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x900, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x904, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x960, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	ecap0_pins_default: backlight_pins_default {
 		pinctrl-single,pins = <
-			0x164 (PIN_OUTPUT | MUX_MODE0) /* ecap0_in_pwm0_out.ecap0_in_pwm0_out */
+			AM4372_IOPAD(0x964, PIN_OUTPUT | MUX_MODE0) /* ecap0_in_pwm0_out.ecap0_in_pwm0_out */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
-			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
-			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
-			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
-			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
-			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
+			AM4372_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM4372_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM4372_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM4372_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM4372_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
+			AM4372_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
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
 
 	qspi_pins_default: qspi_pins_default {
 		pinctrl-single,pins = <
-			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
-			0x88 (PIN_OUTPUT | MUX_MODE2)		/* gpmc_csn3.qspi_clk */
-			0x90 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
-			0x94 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
-			0x98 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
-			0x9c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
+			AM4372_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
+			AM4372_IOPAD(0x888, PIN_OUTPUT | MUX_MODE2)		/* gpmc_csn3.qspi_clk */
+			AM4372_IOPAD(0x890, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
+			AM4372_IOPAD(0x894, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
+			AM4372_IOPAD(0x898, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
+			AM4372_IOPAD(0x89c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
 		>;
 	};
 
 	qspi_pins_sleep: qspi_pins_sleep{
 		pinctrl-single,pins = <
-			0x7c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x90 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x94 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x98 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x9c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x87c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x888, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x890, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x894, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x898, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x89c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 };
-- 
2.4.3
