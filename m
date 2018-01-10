From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: Fix smartreflex compatible for omap3 shared mpu-iva instance
Date: Wed, 10 Jan 2018 10:14:15 -0800
Message-ID: <20180110181415.29197-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The smartreflex instance for mpu and iva is shared. Let's fix this as I've
already gotten confused myself few times wondering where the mpu instance
is. Note that we are still probing the driver using platform data so this
change is safe to do.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/power/ti-smartreflex.txt | 2 +-
 arch/arm/boot/dts/omap3.dtsi                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/ti-smartreflex.txt b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
--- a/Documentation/devicetree/bindings/power/ti-smartreflex.txt
+++ b/Documentation/devicetree/bindings/power/ti-smartreflex.txt
@@ -7,7 +7,7 @@ Required properties:
 
 compatible: Shall be one of the following:
 	    "ti,omap3-smartreflex-core"
-	    "ti,omap3-smartreflex-iva"
+	    "ti,omap3-smartreflex-mpu-iva"
 	    "ti,omap4-smartreflex-core"
 	    "ti,omap4-smartreflex-mpu"
 	    "ti,omap4-smartreflex-iva"
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		smartreflex_mpu_iva: smartreflex@480c9000 {
-			compatible = "ti,omap3-smartreflex-iva";
+			compatible = "ti,omap3-smartreflex-mpu-iva";
 			ti,hwmods = "smartreflex_mpu_iva";
 			reg = <0x480c9000 0x400>;
 			interrupts = <18>;
-- 
2.15.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
