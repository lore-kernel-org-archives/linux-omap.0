From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/2] Documentation: dt: Document TSC2005 DT binding
Date: Fri,  6 Dec 2013 00:09:39 +0100
Message-ID: <1386284979-9680-3-git-send-email-sre@debian.org>
References: <1386284979-9680-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386284979-9680-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add devicetree binding documentation for TSC2005 touchscreen.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../bindings/input/touchscreen/tsc2005.txt         | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
new file mode 100644
index 0000000..4e7df0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
@@ -0,0 +1,49 @@
+* TSC2005 Touchscreen
+
+Required properties:
+ - compatible		      : "ti,tsc2005"
+ - reg			      : SPI device address
+ - spi-max-frequency	      : Maximal SPI speed
+ - interrupts		      : IRQ specifier
+ - reset-gpio		      : GPIO specifier
+
+Optional properties:
+ - ti,fuzz-x		      : integer, X noise value of the touchscreen
+				(defaults to 4)
+ - ti,fuzz-y		      : integer, Y noise value of the touchscreen
+				(defaults to 8)
+ - ti,fuzz-pressure	      : integer, pressure noise value of the touchscreen
+				(defaults to 2)
+ - ti,max-x		      : integer, maximum reported x value
+				(defaults to 4096)
+ - ti,max-y		      : integer, maximum reported y value
+				(defaults to 4096)
+ - ti,max-pressure	      : integer, maximum reported pressure
+				(defaults to 4096)
+ - ti,x-plate-resistance      : integer, resistance of the touchscreen's X plates
+				in ohm (defaults to 280)
+ - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not respond after
+				the configured time (in milli seconds), the driver
+				will reset it. This is disabled by default.
+
+Example:
+
+&mcspi1 {
+	tsc2005@0 {
+		compatible = "ti,tsc2005";
+		spi-max-frequency = <6000000>;
+		reg = <0>;
+		reset-gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>; /* 104 */
+		interrupt-parent = <&gpio4>;
+		interrupts = <4 IRQ_TYPE_NONE>; /* gpio line 100 */
+
+		ti,fuzz-x = <4>;
+		ti,fuzz-y = <7>;
+		ti,fuzz-pressure = <2>;
+		ti,max-x = <4096>;
+		ti,max-y = <4096>;
+		ti,max-pressure = <2048>;
+		ti,x-plate-resistance = <280>;
+		ti,esd-recovery-timeout-ms = <8000>;
+	};
+}
-- 
1.8.4.3
