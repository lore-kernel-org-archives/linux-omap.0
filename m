From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/10] ARM: dts: Use ti-sysc module driver for omap4 musb
Date: Wed, 20 Sep 2017 15:46:21 -0700
Message-ID: <20170920224621.16236-11-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920224621.16236-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Let's make use of the generic ti-sysc module for musb to have
a child device with working runtime PM.

Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -1135,19 +1135,33 @@
 			reg-names = "otghs_control";
 		};
 
-		usb_otg_hs: usb_otg_hs@4a0ab000 {
-			compatible = "ti,omap4-musb";
-			reg = <0x4a0ab000 0x7ff>;
-			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mc", "dma";
+		target-module@4a0ab000 {
+			compatible = "ti,sysc-type1";
 			ti,hwmods = "usb_otg_hs";
-			usb-phy = <&usb2_phy>;
-			phys = <&usb2_phy>;
-			phy-names = "usb2-phy";
-			multipoint = <1>;
-			num-eps = <16>;
-			ram-bits = <12>;
-			ctrl-module = <&omap_control_usbotg>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x4a0ab000 0x4>,
+			      <0x4a0ab004 0x4>,
+			      <0x4a0ab008 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ranges = <0 0x4a0ab000 0x1000>;
+			clocks = <&l3_init_clkctrl OMAP4_USB_OTG_HS_CLKCTRL 0>;
+			clock-names = "clkctrl";
+
+			usb_otg_hs: otg@0 {
+				compatible = "ti,omap4-musb";
+				reg = <0x0 0x7ff>;
+				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "mc", "dma";
+				usb-phy = <&usb2_phy>;
+				phys = <&usb2_phy>;
+				phy-names = "usb2-phy";
+				multipoint = <1>;
+				num-eps = <16>;
+				ram-bits = <12>;
+				ctrl-module = <&omap_control_usbotg>;
+			};
 		};
 
 		aes1: aes@4b501000 {
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
