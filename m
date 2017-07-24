From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 13/14] ARM: dts: omap4-droid4: improve LCD description
Date: Mon, 24 Jul 2017 19:33:10 +0200
Message-ID: <20170724173311.27170-14-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This improves LCD support for the Droid 4.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 3af4905a6b61..942bb6ec99e5 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -192,6 +192,10 @@
 		vddi-supply = <&lcd_regulator>;
 		reset-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;	/* gpio101 */
 
+		width-mm = <50>;
+		height-mm = <89>;
+		backlight = <&lcd_backlight>;
+
 		panel-timing {
 			clock-frequency = <0>;		/* Calculated by dsi */
 
@@ -361,7 +365,7 @@
 
 		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
 
-		backlight {
+		lcd_backlight: backlight {
 			compatible = "ti,lm3532-backlight";
 
 			lcd {
-- 
2.13.2
