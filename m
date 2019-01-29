From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] arm: dts: gta04: add gps support
Date: Tue, 29 Jan 2019 08:38:43 +0100
Message-ID: <20190129073843.14979-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
which one is mounted so use the compatibility entry for w2sg0004
for all which will work for both.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- some s/gps/gnss/
- not added vcc-supply because the regulator is not modelled
  in dts at all

w2sg0004 bindings are in next-20190129

https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next
 arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e53d32691308..d58c117e429f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -312,6 +312,12 @@
 		>;
        };
 
+	gps_pins: pinmux_gps_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
+		>;
+	};
+
 	hdq_pins: hdq_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
@@ -644,6 +650,13 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+	gnss: gnss {
+		compatible = "wi2wi,w2sg0004";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gps_pins>;
+		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		lna-supply = <&vsim>;
+	};
 };
 
 &uart3 {
-- 
2.11.0
