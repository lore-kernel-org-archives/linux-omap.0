From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 3/3] dt: binding documentation for bq2415x charger
Date: Sun, 24 Nov 2013 17:49:31 +0100
Message-ID: <1385311771-447-4-git-send-email-sre@debian.org>
References: <1385311771-447-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385311771-447-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add devicetree binding documentation for bq2415x charger.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../devicetree/bindings/power/bq2415x.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq2415x.txt

diff --git a/Documentation/devicetree/bindings/power/bq2415x.txt b/Documentation/devicetree/bindings/power/bq2415x.txt
new file mode 100644
index 0000000..cb2e753
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/bq2415x.txt
@@ -0,0 +1,43 @@
+Binding for TI bq2415x Li-Ion Charger
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "ti,bq24150"
+ * "ti,bq24150"
+ * "ti,bq24150a"
+ * "ti,bq24151"
+ * "ti,bq24151a"
+ * "ti,bq24152"
+ * "ti,bq24153"
+ * "ti,bq24153a"
+ * "ti,bq24155"
+ * "ti,bq24156"
+ * "ti,bq24156a"
+ * "ti,bq24158"
+- reg: integer, i2c address of the device
+- ti,current-limit: integer, current limit in mA
+- ti,weak-battery-voltage: integer, weak battery voltage threshold in mV
+- ti,battery-regulation-voltage: integer, battery regulation voltage in mV
+- ti,charge-current: integer, charging current in mA
+- ti,termination-current: integer, termination current in mA
+- ti,resistor-sense: integer, value of sensing resistor in milliohm
+
+Optional properties:
+- ti,usb-charger-detection: phandle to usb charger detection device
+			    (required for auto mode)
+
+Example from Nokia N900:
+
+bq24150a {
+	compatible = "ti,bq24150a";
+	reg = <0x6b>;
+
+	ti,current-limit = <100>;
+	ti,weak-battery-voltage = <3400>;
+	ti,battery-regulation-voltage = <4200>;
+	ti,charge-current = <650>;
+	ti,termination-current = <100>;
+	ti,resistor-sense = <68>;
+
+	ti,usb-charger-detection = <&isp1704>;
+};
-- 
1.8.4.3
