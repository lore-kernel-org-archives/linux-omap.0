From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 8/9] dt-bindings: leds: Add the LM3632 LED dt binding
Date: Fri, 28 Sep 2018 13:29:53 -0500
Message-ID: <20180928182954.25446-9-dmurphy@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928182954.25446-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the TI LM3632 LED binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3632.txt  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3632.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3632.txt b/Documentation/devicetree/bindings/leds/leds-lm3632.txt
new file mode 100644
index 000000000000..1befd17174ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3632.txt
@@ -0,0 +1,53 @@
+* Texas Instruments - lm3632 Single-Chip Backlight and 1.5-A Flash LED Driver
+
+The LM3632A integrates LED drivers for both
+the backlight of the LCD panel and the camera flash
+along with the bias power for the LCD panel into one
+device.
+
+Required properties:
+	- compatible : Can be one of the following
+		"ti,lm3632"
+	- reg : I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Required child properties:
+	- reg : 0 - Indicates a backlight mode
+		1 - Indicates a Torch/Strobe (white LED) mode
+
+Required properties for flash LED child nodes:
+	See Documentation/devicetree/bindings/leds/common.txt
+	- flash-max-microamp : Range from 100mA - 1.5A
+	- flash-max-timeout-us : Range from 32ms - 1024ms
+	- led-max-microamp : Range from 25mA - 375mA
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+led-controller@11 {
+	compatible = "ti,lm3632";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x11>;
+
+	led@0 {
+		reg = <0>;
+		label = "white:backlight";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		label = "white:torch";
+		led-max-microamp = <375000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <1000000>;
+	};
+}
+
+For more product information please see the links below:
+http://www.ti.com/product/LM3632
-- 
2.19.0
