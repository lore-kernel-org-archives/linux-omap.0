From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: dts: am437x-sk-evm.dts: fix LCD timings
Date: Fri, 5 Dec 2014 09:39:31 +0200
Message-ID: <1417765171-7384-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The lcd0 node for am437x-sk-evm.dts contains bad LCD timings, and while
they seem to work with a quick test, doing for example blank/unblank
will give you a black display.

This patch updates the timings to the 'typical' values from the LCD spec
sheet.

Also, the compatible string is completely bogus, as
"osddisplays,osd057T0559-34ts" is _not_ a 480x272 panel. The panel on
the board is a newhaven one. Update the compatible string to reflect
this. Note that this hasn't caused any issues, as the "panel-dpi"
matches the driver.

Cc: <stable@vger.kernel.org> # v3.17+
Tested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d620ee..66071c7b3dde 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -100,7 +100,7 @@
 	};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "newhaven,nhd-4.3-480272ef-atxl", "panel-dpi";
 		label = "lcd";
 
 		pinctrl-names = "default";
@@ -112,11 +112,11 @@
 			clock-frequency = <9000000>;
 			hactive = <480>;
 			vactive = <272>;
-			hfront-porch = <8>;
-			hback-porch = <43>;
-			hsync-len = <4>;
-			vback-porch = <12>;
-			vfront-porch = <4>;
+			hfront-porch = <2>;
+			hback-porch = <2>;
+			hsync-len = <41>;
+			vfront-porch = <2>;
+			vback-porch = <2>;
 			vsync-len = <10>;
 			hsync-active = <0>;
 			vsync-active = <0>;
-- 
2.2.0
