From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 17/17] ARM: dts: am335x: wega: Replaced register offsets with defines
Date: Fri, 12 Apr 2019 18:26:27 +0200
Message-ID: <20190412162627.24518-18-cquast@hanoverdisplays.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-wega.dtsi | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce541739b24..b7d28a20341f 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -32,11 +32,11 @@
 &am33xx_pinmux {
 	mcasp0_pins: pinmux_mcasp0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 };
@@ -84,8 +84,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
@@ -100,20 +100,20 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_ben1.mii2_col */
 		>;
 	};
 };
@@ -141,13 +141,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
 		>;
 	};
 };
@@ -171,17 +171,17 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 };
-- 
2.20.1
