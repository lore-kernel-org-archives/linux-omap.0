From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 5/8] ARM: dts: am335x-sl50: add support for DS1339 Real Time Clock.
Date: Wed,  6 Jun 2018 17:54:10 +0200
Message-ID: <20180606155413.23542-5-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Production hardware will go with the DS1339 RTC chip, so replace the old
for the new one and also add the nIRQ pin to be able to properly wakeup
the system from suspend.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 1eabea4507aa..b15690155159 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -6,6 +6,7 @@
 
 #include "am33xx.dtsi"
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Toby Churchill SL50 Series";
@@ -374,6 +375,12 @@
 		>;
 	};
 
+	rtc0_irq_pins: pinmux_rtc0_irq_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE7)     /* gpmc_ad9.gpio0_23 */
+		>;
+	};
+
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_MOSI - spi0_d0.spi0_d0 */
@@ -408,9 +415,14 @@
 		reg = <0x24>;
 	};
 
-	bq32000: rtc@68 {
-		compatible = "ti,bq32000";
-		trickle-resistor-ohms = <1120>;
+	rtc0: rtc@68 {
+		compatible = "dallas,ds1339";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc0_irq_pins>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>; /* gpio 23 */
+		wakeup-source;
+		trickle-resistor-ohms = <2000>;
 		reg = <0x68>;
 	};
 
-- 
2.17.1
