From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
Date: Fri, 16 Sep 2016 14:50:12 +0300
Message-ID: <c7073c304d3069b7b6123658b222b38e3209175c.1474025756.git.jsarha@ti.com>
References: <cover.1474025756.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1474025756.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Whitespace cleanup of lcdc related nodes. Do all indentation and
alignment with tabs instead of spaces.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 09308d6..23b94e7 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -170,29 +170,29 @@
 		pinctrl-1 = <&lcd_pins_sleep>;
 		status = "okay";
 		panel-info {
-			ac-bias           = <255>;
-			ac-bias-intrpt    = <0>;
-			dma-burst-sz      = <16>;
-			bpp               = <32>;
-			fdd               = <0x80>;
-			sync-edge         = <0>;
-			sync-ctrl         = <1>;
-			raster-order      = <0>;
-			fifo-th           = <0>;
+			ac-bias		= <255>;
+			ac-bias-intrpt	= <0>;
+			dma-burst-sz	= <16>;
+			bpp		= <32>;
+			fdd		= <0x80>;
+			sync-edge	= <0>;
+			sync-ctrl	= <1>;
+			raster-order	= <0>;
+			fifo-th		= <0>;
 		};
 		display-timings {
 			480x272 {
-				hactive         = <480>;
-				vactive         = <272>;
-				hback-porch     = <43>;
-				hfront-porch    = <8>;
-				hsync-len       = <4>;
-				vback-porch     = <12>;
-				vfront-porch    = <4>;
-				vsync-len       = <10>;
+				hactive		= <480>;
+				vactive		= <272>;
+				hback-porch	= <43>;
+				hfront-porch	= <8>;
+				hsync-len	= <4>;
+				vback-porch	= <12>;
+				vfront-porch	= <4>;
+				vsync-len	= <10>;
 				clock-frequency = <9000000>;
-				hsync-active    = <0>;
-				vsync-active    = <0>;
+				hsync-active	= <0>;
+				vsync-active	= <0>;
 			};
 		};
 	};
@@ -711,5 +711,5 @@
 };
 
 &lcdc {
-      status = "okay";
+	status = "okay";
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
