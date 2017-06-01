From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] dt-bindings: cpcap-battery: Add binding
Date: Wed, 31 May 2017 17:19:20 -0700
Message-ID: <20170601001921.11091-2-tony@atomide.com>
References: <20170601001921.11091-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170601001921.11091-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

---
 .../bindings/power/supply/cpcap-battery.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
@@ -0,0 +1,27 @@
+Motorola CPCAP PMIC battery driver binding
+
+Required properties:
+- compatible: Shall be "motorola,cpcap-battery"
+- interrupts: Interrupt specifier for each name in interrupt-names
+- interrupt-names: Should contain the following entries:
+		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
+- io-channels: IIO ADC channel specifier for each name in io-channel-names
+- io-channel-names: Should contain the following entries:
+		    "battdetb", "battp", "chg_isense", "batti"
+
+Example:
+
+cpcap_battery: battery {
+	compatible = "motorola,cpcap-battery";
+	interrupts-extended = <
+		&cpcap 5 0 &cpcap 3 0
+		&cpcap 20 0 &cpcap 54 0
+	>;
+	interrupt-names =
+		"lowbph", "lowbpl",
+		"chrgcurr1", "battdetb";
+	io-channels = <&cpcap_adc 0 &cpcap_adc 1
+		       &cpcap_adc 5 &cpcap_adc 6>;
+	io-channel-names = "battdetb", "battp",
+			   "chg_isense", "batti";
+};
-- 
2.13.0
