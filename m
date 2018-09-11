From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Date: Tue, 11 Sep 2018 12:08:22 -0500
Message-ID: <20180911170825.17789-4-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings for the lm3697
LED driver for backlighting and display.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - Fix compatible from 3967 to 3697, and other comments. - https://lore.kernel.org/patchwork/patch/982550/

v6 - Fix minor issues - https://lore.kernel.org/patchwork/patch/975387/
v5 - Fix the comment for the example - https://lore.kernel.org/patchwork/patch/975060/
v4 - Removed HVLED definition in favor of HVLED place definition - https://lore.kernel.org/patchwork/patch/974812/
v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/

 .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
new file mode 100644
index 000000000000..85ae075f6677
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -0,0 +1,86 @@
+* Texas Instruments - LM3697 Highly Efficient White LED Driver
+
+The LM3697 11-bit LED driver provides high-
+performance backlight dimming for 1, 2, or 3 series
+LED strings while delivering up to 90% efficiency.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3697"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - LED is Controlled by bank A
+		1 - LED is Controlled by bank B
+	- led-sources : Indicates which HVLED string is associated to which
+			control bank.  Each element in the array is associated
+			with a specific HVLED string.  Element 0 is HVLED1,
+			element 1 is HVLED2 and element 2 HVLED3.
+			Additional information is contained
+			in Documentation/devicetree/bindings/leds/common.txt
+			0 - HVLED is not active in this control bank
+			1 - HVLED string is controlled by this control bank
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
+controlled by control bank B.
+
+led-controller@36 {
+	compatible = "ti,lm3697";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1 0 1>;
+		label = "white:first_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <0 1 0>;
+		label = "white:second_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+}
+
+All HVLED strings controlled by control bank A
+
+led-controller@36 {
+	compatible = "ti,lm3697";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1 1 1>;
+		label = "white:backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3697.pdf
-- 
2.17.0.1855.g63749b2dea
