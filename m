From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 7/7] DT:omap3+ads7846: use new common touchscreen bindings
Date: Fri,  6 Nov 2015 16:14:49 +0100
Message-ID: <1599beae6455bf2f784077ef7fd365907098f924.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
In-Reply-To: <cover.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The standard touch screen bindings [1] replace the private ti,swap-xy
with touchscreen-swaped-x-y. And for the Openpandora we use
touchscreen-size etc. to match the LCD screen size.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi              |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi          | 17 +++++++++++++----
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index d0dd036..01dae66 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -325,7 +325,7 @@
 		ti,y-max = /bits/ 16 <3600>;
 		ti,x-plate-ohms = /bits/ 16 <80>;
 		ti,pressure-max = /bits/ 16 <255>;
-		ti,swap-xy;
+		touchscreen-swapped-x-y;
 
 		linux,wakeup;
 	};
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f672a04..9497cc6 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -696,10 +696,19 @@
 		pendown-gpio = <&gpio3 30 0>;
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
index f4b1a61..c772b76 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -65,7 +65,7 @@
 		ti,y-max = /bits/ 16 <4800>;
 		ti,x-plate-ohms = /bits/ 16 <40>;
 		ti,pressure-max = /bits/ 16 <255>;
-		ti,swap-xy;
+		touchscreen-swapped-x-y;
 		linux,wakeup;
 	};
 };
-- 
2.5.1
