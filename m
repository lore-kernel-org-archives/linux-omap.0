From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 07/15] ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with defines
Date: Tue,  9 Apr 2019 18:03:38 +0200
Message-ID: <20190409160346.25599-8-cquast@hanoverdisplays.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 .../boot/dts/am335x-bonegreen-wireless.dts    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 57731f0daf10..7db86a9c836a 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -32,35 +32,35 @@
 &am33xx_pinmux {
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* mdio_clk.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x828, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
-			AM33XX_IOPAD(0x82C, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
-			AM33XX_IOPAD(0x87C, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
 		>;
 	};
 };
-- 
2.20.1
