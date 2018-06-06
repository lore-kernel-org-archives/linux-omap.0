From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 7/8] ARM: dts: am335x-sl50: fix label names for all LEDs.
Date: Wed,  6 Jun 2018 17:54:12 +0200
Message-ID: <20180606155413.23542-7-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix the label for all LEDs, we made a mistake setting the label names on
all LEDs, where says green should say red, and viceversa, where says red
should be green.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 495a4a0be25c..e11a6def36a4 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -33,25 +33,25 @@
 		pinctrl-0 = <&led_pins>;
 
 		led0 {
-			label = "sl50:green:usr0";
+			label = "sl50:red:usr0";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		led1 {
-			label = "sl50:red:usr1";
+			label = "sl50:green:usr1";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		led2 {
-			label = "sl50:green:usr2";
+			label = "sl50:red:usr2";
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		led3 {
-			label = "sl50:red:usr3";
+			label = "sl50:green:usr3";
 			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
@@ -430,6 +430,12 @@
 			/* PDI Bus - Battery system */
 			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* nBattReset  gpmc_a0.gpio1_16 */
 			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE7)	/* BattPDIData gpmc_ad15.gpio1_15 */
+			/* FPGA */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE7)	/* FPGA_DONE - gpmc_ad8.gpio0_22 */
+			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* FPGA_NRST - gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* FPGA_RUN - gpmc_a1.gpio1_17 */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLUP | MUX_MODE7)	/* ENFPGA - gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* FPGA_PROGRAM - gpmc_a10.gpio1_26 */
 		>;
 	};
 };
-- 
2.17.1
