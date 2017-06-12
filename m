From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] dt-bindings: power: supply: cpcap-battery: Add power-supplies property
Date: Mon, 12 Jun 2017 00:20:25 -0700
Message-ID: <20170612072025.30033-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

The binding for cpcap-battery is missing the standard power-supplies
property as noted by Sebastian Reichel <sebastian.reichel@collabora.co.uk>.

Cc: devicetree@vger.kernel.org
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
--- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
@@ -8,6 +8,7 @@ Required properties:
 - io-channels: IIO ADC channel specifier for each name in io-channel-names
 - io-channel-names: Should contain the following entries:
 		    "battdetb", "battp", "chg_isense", "batti"
+- power-supplies: List of devices that supply power, typically cpcap_charger
 
 Example:
 
@@ -24,4 +25,5 @@ cpcap_battery: battery {
 		       &cpcap_adc 5 &cpcap_adc 6>;
 	io-channel-names = "battdetb", "battp",
 			   "chg_isense", "batti";
+	power-supplies = <&cpcap_charger>;
 };
-- 
2.13.0
