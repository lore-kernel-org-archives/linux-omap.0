From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 13/39] ARM: dts: am335x-phycore-som: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:51 -0300
Message-ID: <1447390457-1158-14-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-phycore-som.dtsi | 60 +++++++++++++++----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 2f43e458ea4a..c20ae6c6f6c7 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -56,22 +56,22 @@
 &am33xx_pinmux {
 	ethernet0_pins: pinmux_ethernet0 {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-			0x114 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txen.rmii1_txen */
-			0x124 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd1.rmii1_txd1 */
-			0x128 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd0.rmii1_txd0 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT | MUX_MODE1)		/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT | MUX_MODE1)		/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT | MUX_MODE1)		/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
 		>;
 	};
 
 	mdio_pins: pinmux_mdio {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 };
@@ -103,8 +103,8 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 };
@@ -137,20 +137,20 @@
 &am33xx_pinmux {
 		nandflash_pins: pinmux_nandflash {
 			pinctrl-single,pins = <
-			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 };
@@ -324,10 +324,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			0x150 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_clk.spi0_clk */
-			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_d0.spi0_d0 */
-			0x158 (PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
-			0x15c (PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_clk.spi0_clk */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
 		>;
 	};
 };
-- 
2.4.3
