From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 5/5] Documentation: dt: Document TSC2005 DT binding
Date: Sat, 26 Apr 2014 01:56:19 +0200
Message-ID: <1398470179-20880-6-git-send-email-sre@kernel.org>
References: <1398470179-20880-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398470179-20880-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add devicetree binding documentation for TSC2005 touchscreen.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/input/touchscreen/tsc2005.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
new file mode 100644
index 0000000..663f8ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
@@ -0,0 +1,39 @@
+* Texas Instruments tsc2005 touchscreen controller
+
+Required properties:
+ - compatible		      : "ti,tsc2005"
+ - reg			      : SPI device address
+ - spi-max-frequency	      : Maximal SPI speed
+ - interrupts		      : IRQ specifier
+ - reset-gpios		      : GPIO specifier
+
+Optional properties:
+ - ti,x-plate-ohms	      : integer, resistance of the touchscreen's X plates
+				in ohm (defaults to 280)
+ - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not respond after
+				the configured time (in milli seconds), the driver
+				will reset it. This is disabled by default.
+ - properties defined in touchscreen.txt
+
+Example:
+
+&mcspi1 {
+	tsc2005@0 {
+		compatible = "ti,tsc2005";
+		spi-max-frequency = <6000000>;
+		reg = <0>;
+
+		reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>; /* 104 */
+		interrupts-extended = <&gpio4 4 IRQ_TYPE_NONE>; /* 100 */
+
+		touchscreen-fuzz-x = <4>;
+		touchscreen-fuzz-y = <7>;
+		touchscreen-fuzz-pressure = <2>;
+		touchscreen-max-x = <4096>;
+		touchscreen-max-y = <4096>;
+		touchscreen-max-pressure = <2048>;
+
+		ti,x-plate-ohms = <280>;
+		ti,esd-recovery-timeout-ms = <8000>;
+	};
+}
-- 
1.9.2
