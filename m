From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 6/9] dt-bindings: leds: Add support for the LM3633
Date: Fri, 28 Sep 2018 13:29:51 -0500
Message-ID: <20180928182954.25446-7-dmurphy@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928182954.25446-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for the TI LM3633 LED driver.
This device has 9 control banks 3 high voltage
LED channels and 6 low voltage LED channels.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3633.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3633.txt b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
new file mode 100644
index 000000000000..d791b891ea6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
@@ -0,0 +1,102 @@
+* Texas Instruments - LM3633 Lighting Power Solution for Smartphone Handsets
+
+The LM3633 is a complete power source for
+backlight, keypad, and indicator LEDs in smartphone
+handsets.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3633"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - HVLED is Controlled by bank A
+		1 - HVLED is Controlled by bank B
+		2,3,4 - LVLED1, 2 and 3 are Controlled by bank C, D and E
+		5,6,7 - LVLED4, 5 and 6 are Controlled by bank F, G and H
+	- led-sources : Indicates which LED string is associated to which
+			control bank.
+			0 - LED is not active in this control bank
+			1 - LED string is controlled by this control bank
+
+Optional child properties:
+	- runtime-ramp-up-msec: Current ramping from one brightness level to
+				the a higher brightness level.
+				Range from 2048 us - 117.44 s
+	- runtime-ramp-down-msec: Current ramping from one brightness level to
+				  the a lower brightness level.
+				  Range from 2048 us - 117.44 s
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+Control bank C output to 3 LVLEDs and Control F, G and H have independent
+controls of the LVLEDs.
+
+led-controller@36 {
+	compatible = "ti,lm3633";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	led@0 {
+		reg = <0>;
+		led-sources = < 1 0 1 >;
+		label = "white:backlight";
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = < 0 1 0 >;
+		label = "white:light";
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+	};
+
+	led@2 {
+		reg = <2>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "white:indicator1";
+	};
+
+	led@5 {
+		reg = <5>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "red:light";
+	};
+
+	led@6 {
+		reg = <6>;
+		led-sources = <1>;
+		ramp-up-ms = <41940>;
+		ramp-down-ms = <1000>;
+		label = "green:light";
+	};
+
+	led@7 {
+		reg = <7>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "blue:light";
+	};
+};
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3633.pdf
-- 
2.19.0
