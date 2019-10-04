From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] ARM: dts: am3874-iceboard: Fix 'i2c-mux-idle-disconnect' usage
Date: Thu,  3 Oct 2019 18:45:48 -0700
Message-ID: <20191004014548.29583-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Graeme Smecher <gsmecher@threespeedlogic.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

According to
Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt,
i2c-mux-idle-disconnect is a property of a parent node since it
pertains to the mux/switch as a whole, so move it there and drop all
of the concurrences in child nodes.

Fixes: d031773169df ("ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

This is purely a drive-by fix, since it concerns the HW I've never
heard of before. However I was working with PCA9548
(vf610-zii-scu4-aib is my HW) and looking at various users in the
kernel, when this code caught my eye. Apologies for the noise if this
fix is somehow bogus.

In case that it matters this patch is based on top of 5.4-rc1.

Thanks,
Andrey Smirnov

 arch/arm/boot/dts/am3874-iceboard.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index 883fb85135d4..1b4b2b0500e4 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -111,13 +111,13 @@
 		reg = <0x70>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c@0 {
 			/* FMC A */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@1 {
@@ -125,7 +125,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@2 {
@@ -133,7 +132,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@3 {
@@ -141,7 +139,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@4 {
@@ -149,14 +146,12 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-			i2c-mux-idle-disconnect;
 
 			ina230@40 { compatible = "ti,ina230"; reg = <0x40>; shunt-resistor = <5000>; };
 			ina230@41 { compatible = "ti,ina230"; reg = <0x41>; shunt-resistor = <5000>; };
@@ -182,14 +177,12 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
-			i2c-mux-idle-disconnect;
 		};
 
 		i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-			i2c-mux-idle-disconnect;
 
 			u41: pca9575@20 {
 				compatible = "nxp,pca9575";
-- 
2.21.0
