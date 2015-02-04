From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Wed,  4 Feb 2015 23:14:32 +0100
Message-ID: <1423088075-10025-4-git-send-email-marek@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: mark.rutland@arm.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, gta04-owner@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt

diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
new file mode 100644
index 0000000..bb3580c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
@@ -0,0 +1,43 @@
+twl4030_madc_battery
+
+Required properties:
+ - compatible : "ti,twl4030-madc-battery"
+ - capacity-uah : battery capacity in uAh
+ - volt-to-capacity-charging-map : list of voltage(mV):level(%) values
+	for charging calibration (see example)
+ - volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
+	for discharging calibration (see example)
+ - io-channels: Should contain IIO channel specifiers
+	for each element in io-channel-names.
+- io-channel-names: Should contain the following values:
+ * "temp" - The ADC channel for temperature reading
+ * "ichg" - The ADC channel for battery charging status
+ * "vbat" - The ADC channel to measure the battery voltage
+
+Example:
+	madc-battery {
+		compatible = "ti,twl4030-madc-battery";
+		capacity-uah = <1200000>;
+		volt-to-capacity-charging-map = <4200 100>,
+					        <4100 75>,
+					        <4000 55>,
+					        <3900 25>,
+					        <3800 5>,
+					        <3700 2>,
+					        <3600 1>,
+					        <3300 0>;
+
+		volt-to-capacity-discharging-map = <4200 100>
+						   <4100 95>,
+						   <4000 70>,
+						   <3800 50>,
+						   <3700 10>,
+						   <3600 5>,
+						   <3300 0>;
+		io-channels = <&twl_madc 1>,
+	                      <&twl_madc 10>,
+			      <&twl_madc 12>;
+		io-channel-names = "temp",
+		                   "ichg",
+		                   "vbat";
+	};
-- 
1.9.1
