From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] arm: dts: gta04: add pinctrl settings for wkup domain
Date: Thu, 31 Jan 2019 07:23:38 +0100
Message-ID: <20190131062338.27547-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

There is one button and a notifier for incoming phone
calls/text messages for which we should wakeup from
suspend.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index d58c117e429f..6f11bf3ee4ed 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -224,6 +224,15 @@
 	};
 };
 
+&omap3_pmx_wkup {
+	gpio1_pins: pinmux_gpio1_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a14, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_boot5.gpio_7 */
+			OMAP3_WKUP_IOPAD(0x2a1a, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_clkout.gpio_10 */
+		>;
+	};
+};
+
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
@@ -642,6 +651,11 @@
 	status = "disabled";
 };
 
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio1_pins>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
-- 
2.11.0
