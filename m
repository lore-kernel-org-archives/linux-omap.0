From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node
Date: Fri, 16 Sep 2016 14:50:13 +0300
Message-ID: <a2507004ce5e9b41affad88cf9ac677def6b8430.1474025756.git.jsarha@ti.com>
References: <cover.1474025756.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1474025756.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add blue-and-red-wiring -property to lcdc node. The am335x-evmsk has
blue and red wires crossed to get 24-bit RGB (and 16-bit BGR)
support. After this patch am335x-evmsk supports BGR565, RGB888, and
XRGB8888 color formats. See details in
Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 23b94e7..034e117 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -712,4 +712,6 @@
 
 &lcdc {
 	status = "okay";
+
+	blue-and-red-wiring = "crossed";
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
