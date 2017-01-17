From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] ARM: dts: am33x, da816x, da814x: Remove useless register address
Date: Tue, 17 Jan 2017 14:54:20 +0100
Message-ID: <20170117135420.10197-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In order to make CPPI 4.1 DMA driver more generic, accesses to USBSS
have been removed. So it is not required anymore to define "glue"
register's address and size in DT.
Remove "glue" register from cppi41dma node.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 ++---
 arch/arm/boot/dts/dm814x.dtsi | 5 ++---
 arch/arm/boot/dts/dm816x.dtsi | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9e96d60..2466ed5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -659,11 +659,10 @@
 
 			cppi41dma: dma-controller@47402000 {
 				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
+				reg =  <0x47402000 0x1000
 					0x47403000 0x1000
 					0x47404000 0x4000>;
-				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				reg-names = "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 9708157..2dd727a 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -156,11 +156,10 @@
 
 			cppi41dma: dma-controller@47402000 {
 				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
+				reg =  <0x47402000 0x1000
 					0x47403000 0x1000
 					0x47404000 0x4000>;
-				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				reg-names = "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 276211e..bb78511 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -493,11 +493,10 @@
 
 			cppi41dma: dma-controller@47402000 {
 				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
+				reg =  <0x47402000 0x1000
 					0x47403000 0x1000
 					0x47404000 0x4000>;
-				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				reg-names = "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
