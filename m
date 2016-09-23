From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 8/8] DT:omap3+ads7846: use new common touchscreen bindings
Date: Fri, 23 Sep 2016 14:41:16 +0200
Message-ID: <161de1f3131808ae4a33beed5eae0d7acd0f2680.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The standard touch screen bindings [1] replace the private ti,swap-xy
with touchscreen-swaped-x-y. And for the Openpandora we use
touchscreen-size etc. to match the LCD screen size.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Tested with OpenPandora.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi              |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi          | 17 +++++++++++++----
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |  3 ++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index eff816e..af6b66c 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -325,7 +325,7 @@
 		ti,y-max = /bits/ 16 <3600>;
 		ti,x-plate-ohms = /bits/ 16 <80>;
 		ti,pressure-max = /bits/ 16 <255>;
-		ti,swap-xy;
+		touchscreen-swapped-x-y;
 
 		wakeup-source;
 	};
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index cbc47af..f66a2b4 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -700,10 +700,19 @@
 		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vaux4>;
 
-		ti,x-min = /bits/ 16 <0>;
-		ti,x-max = /bits/ 16 <8000>;
-		ti,y-min = /bits/ 16 <0>;
-		ti,y-max = /bits/ 16 <4800>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-max-pressure = <1000>;
+		touchscreen-fuzz-x = <16>;
+		touchscreen-fuzz-y = <16>;
+		touchscreen-fuzz-pressure = <10>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+
+		ti,x-min = /bits/ 16 <160>;
+		ti,x-max = /bits/ 16 <3900>;
+		ti,y-min = /bits/ 16 <220>;
+		ti,y-max = /bits/ 16 <3750>;
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index 157345b..3627a63 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -66,6 +66,7 @@
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
 		ti,swap-xy;
-		wakeup-source;
+		touchscreen-swapped-x-y;
+		linux,wakeup;
 	};
 };
-- 
2.7.3
