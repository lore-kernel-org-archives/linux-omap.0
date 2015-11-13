From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 14/39] ARM: dts: am335x-wega: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:52 -0300
Message-ID: <1447390457-1158-15-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-wega.dtsi | 58 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 2cecb3951e1b..282f6d4b27bc 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -28,8 +28,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			0x168 (PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			0x16c (PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
@@ -44,20 +44,20 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
-			0x40 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
-			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
-			0x48 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
-			0x4c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
-			0x50 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
-			0x54 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
-			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
-			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
-			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
-			0x74 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
-			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
 		>;
 	};
 };
@@ -79,13 +79,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1 {
 		pinctrl-single,pins = <
-			0x0F0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			0x0F4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			0x0F8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			0x0FC (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			0x160 (PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
 		>;
 	};
 };
@@ -103,17 +103,17 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
-			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
 		>;
 	};
 };
-- 
2.4.3
