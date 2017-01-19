From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] ARM: dts: da850: Add the CPPI 4.1 DMA to the USB OTG controller
Date: Thu, 19 Jan 2017 15:15:07 +0100
Message-ID: <20170119141507.20158-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org
Cc: khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This adds the CPPI 4.1 DMA controller to the USB OTG controller.

Changes since v2:
- Fixed the the property reg-names (had glue register defined)
- Removed few useless property

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/da850.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..f4a637a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -396,12 +396,37 @@
 		usb0: usb@200000 {
 			compatible = "ti,da830-musb";
 			reg = <0x200000 0x10000>;
+			ranges;
 			interrupts = <58>;
 			interrupt-names = "mc";
 			dr_mode = "otg";
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			dmas = <&cppi41dma 0 0 &cppi41dma 1 0
+				&cppi41dma 2 0 &cppi41dma 3 0
+				&cppi41dma 0 1 &cppi41dma 1 1
+				&cppi41dma 2 1 &cppi41dma 3 1>;
+			dma-names =
+				"rx1", "rx2", "rx3", "rx4",
+				"tx1", "tx2", "tx3", "tx4";
+
+			cppi41dma: dma-controller@201000 {
+				compatible = "ti,da830-cppi41";
+				reg =  <0x201000 0x1000
+					0x202000 0x1000
+					0x204000 0x4000>;
+				reg-names = "controller",
+					    "scheduler", "queuemgr";
+				interrupts = <58>;
+				#dma-cells = <2>;
+				#dma-channels = <4>;
+				status = "okay";
+			};
 		};
 		mdio: mdio@224000 {
 			compatible = "ti,davinci_mdio";
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
