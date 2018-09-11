From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Tue, 11 Sep 2018 12:08:20 -0500
Message-ID: <20180911170825.17789-2-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove support for the LM3697 LED device
from the ti-lmu.  The LM3697 will be supported
via a stand alone LED driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/

 .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index c885cf89b8ce..920f910be4e9 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
   LM3632       Backlight and regulator
   LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
-  LM3697       Backlight and fault monitor
 
 Required properties:
   - compatible: Should be one of:
@@ -18,11 +17,10 @@ Required properties:
                 "ti,lm3632"
                 "ti,lm3633"
                 "ti,lm3695"
-                "ti,lm3697"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
-         0x36 for LM3633, LM3697
+         0x36 for LM3633
          0x38 for LM3532
          0x63 for LM3695
 
@@ -38,7 +36,6 @@ Optional nodes:
     Required properties:
       - compatible: Should be one of:
                     "ti,lm3633-fault-monitor"
-                    "ti,lm3697-fault-monitor"
   - leds: LED properties for LM3633. Please refer to [2].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
@@ -220,24 +217,3 @@ lm3695@63 {
 		};
 	};
 };
-
-lm3697@36 {
-	compatible = "ti,lm3697";
-	reg = <0x36>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3697-backlight";
-
-		lcd {
-			led-sources = <0 1 2>;
-			ramp-up-msec = <200>;
-			ramp-down-msec = <200>;
-		};
-	};
-
-	fault-monitor {
-		compatible = "ti,lm3697-fault-monitor";
-	};
-};
-- 
2.17.0.1855.g63749b2dea
