From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Date: Sat, 13 Aug 2016 05:14:34 +0200
Message-ID: <1471058078-5579-4-git-send-email-sre@kernel.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

---
 .../devicetree/bindings/net/nokia-bluetooth.txt    | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
new file mode 100644
index 000000000000..a0fceabb4cce
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
@@ -0,0 +1,43 @@
+Nokia bluetooth UART devices
+------
+
+Some vendors have custom versions of their chips, that can be found in Nokia
+devices. These chips are controlled differently, than the non-Nokia version,
+so a different binding is required. All chips listed here implement the Nokia
+H4+ protocol.
+
+Required properties:
+
+  - compatible: should be one of the following:
+	* "nokia,brcm,bcm2048"
+	* "nokia,ti,wl1271-bluetooth"
+  - reset-gpios:		Should specify the gpio for bluetooth reset
+  - host-wakeup-gpios:		Should specify the gpio for host wakeup
+  - bluetooth-wakeup-gpios:	Should specify the gpio for bluetooth wakeup
+  - clock-names:		Should be "sysclk"
+  - clocks:			Should contain a clock phandle for system clock
+
+Example:
+
+/ {
+	/* controlled (enabled/disabled) directly by wl1271 */
+	vctcxo: vctcxo {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
+};
+
+&uart2 {
+	bluetooth {
+		compatible = "nokia,ti,wl1271-bluetooth";
+
+		reset-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>; /* 26 */
+		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
+		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
+
+		clocks = <&vctcxo>;
+		clock-names = "sysclk";
+	};
+
+};
-- 
2.8.1
