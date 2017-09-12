From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH v2 3/4] ARM: dts: omap3: Fix Sharp LS037V7DW01 compatible string and envdd supply
Date: Mon, 11 Sep 2017 22:46:58 -0500
Message-ID: <20170912034659.13184-4-woods.technical@gmail.com>
References: <20170903003816.5536-1-woods.technical@gmail.com>
 <20170912034659.13184-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912034659.13184-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

The Sharp panel driver and regulator are now selected properly. This
commit eliminates a dummy regulator assignment.

Signed-off-by: Derald D. Woods <woods.technical@gmail.com>

---
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index 157345bb8e79..15f73e5adfdf 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -26,9 +26,10 @@
 	};
 
 	lcd0: display {
-		compatible = "sharp,ls037v7dw01";
+		compatible = "omapdss,sharp,ls037v7dw01";
 		label = "lcd";
 		power-supply = <&lcd_3v3>;
+		envdd-supply = <&lcd_3v3>;
 
 		port {
 			lcd_in: endpoint {
-- 
2.14.1
