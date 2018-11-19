From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654 SoCs
Date: Mon, 19 Nov 2018 15:15:09 +0530
Message-ID: <20181119094509.22542-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
handle AM654 SoCs. Also, it seems that existing compatible strings used
in the kernel DTs were never documented. So, document them now.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index b1163bf97146..aad5e34965eb 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -2,7 +2,12 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Required properties:
+- mfd
+	compatible: Should be
+		"ti,am3359-tscadc" for AM335x/AM437x SoCs
+		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
 - child "tsc"
+	compatible: Should be "ti,am3359-tsc".
 	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
 		  support on the platform.
 	ti,x-plate-resistance: X plate resistance
@@ -25,6 +30,9 @@ Required properties:
 			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 			XP  = 0, XN = 1, YP = 2, YN = 3.
 - child "adc"
+	compatible: Should be
+		    "ti,am3359-adc" for AM335x/AM437x SoCs
+		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
 
-- 
2.19.1
