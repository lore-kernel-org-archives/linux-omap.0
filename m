From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH v3 3/4] ARM: dts: omap3: Add Sharp LS037V7DW01 'envdd' supply
Date: Tue, 12 Sep 2017 18:48:23 -0500
Message-ID: <20170912234824.6706-4-woods.technical@gmail.com>
References: <20170912034659.13184-1-woods.technical@gmail.com>
 <20170912234824.6706-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912234824.6706-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

The Sharp panel 'envdd' regulator is now selected properly. This commit
eliminates a dummy regulator assignment at boot.

Signed-off-by: Derald D. Woods <woods.technical@gmail.com>
---
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index 157345bb8e79..21e5683e7327 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -29,6 +29,7 @@
 		compatible = "sharp,ls037v7dw01";
 		label = "lcd";
 		power-supply = <&lcd_3v3>;
+		envdd-supply = <&lcd_3v3>;
 
 		port {
 			lcd_in: endpoint {
-- 
2.14.1
