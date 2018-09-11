From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 5/6] dt-bindings: leds: Add runtime ramp node for LM3697
Date: Tue, 11 Sep 2018 12:08:24 -0500
Message-ID: <20180911170825.17789-6-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add runtime ramp rates for the LM3697 LED
driver.  This LED driver supports separate
runtime ramp rates for going from a higher
or lower level of brightnesses

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series to support feature in ti-lmu

 .../devicetree/bindings/leds/leds-lm3697.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
index 85ae075f6677..4bb2ed51025b 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3697.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -30,6 +30,12 @@ Required child properties:
 			1 - HVLED string is controlled by this control bank
 
 Optional child properties:
+	- runtime-ramp-up-msec: Current ramping from one brightness level to
+				the a higher brightness level.
+				Range from 2048 us - 117.44 s
+	- runtime-ramp-down-msec: Current ramping from one brightness level to
+				  the a lower brightness level.
+				  Range from 2048 us - 117.44 s
 	- label : see Documentation/devicetree/bindings/leds/common.txt
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
@@ -51,6 +57,8 @@ led-controller@36 {
 	led@0 {
 		reg = <0>;
 		led-sources = <1 0 1>;
+		runtime-ramp-up-msec = <5000>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:first_backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
@@ -58,6 +66,8 @@ led-controller@36 {
 	led@1 {
 		reg = <1>;
 		led-sources = <0 1 0>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:second_backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
@@ -77,6 +87,8 @@ led-controller@36 {
 	led@0 {
 		reg = <0>;
 		led-sources = <1 1 1>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
-- 
2.17.0.1855.g63749b2dea
