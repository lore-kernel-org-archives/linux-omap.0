From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/6] arm: dts: am33xx: Add missing #phy-cells to ti,am335x-usb-phy
Date: Thu,  9 Nov 2017 16:26:14 -0600
Message-ID: <20171109222614.5719-6-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109222614.5719-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"ti,am335x-usb-phy" is using the phy binding, but is missing #phy-cells
property. Fixes the following warning in TI dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
Please apply to TI tree.

 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 2 ++
 arch/arm/boot/dts/am33xx.dtsi                        | 2 ++
 arch/arm/boot/dts/dm814x.dtsi                        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 7a33f22c815a..7a198a30408a 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -95,6 +95,7 @@ usb: usb@47400000 {
 		reg = <0x47401300 0x100>;
 		reg-names = "phy";
 		ti,ctrl_mod = <&ctrl_mod>;
+		#phy-cells = <0>;
 	};
 
 	usb0: usb@47401000 {
@@ -141,6 +142,7 @@ usb: usb@47400000 {
 		reg = <0x47401b00 0x100>;
 		reg-names = "phy";
 		ti,ctrl_mod = <&ctrl_mod>;
+		#phy-cells = <0>;
 	};
 
 	usb1: usb@47401800 {
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 7d7ca054c557..a39465a67ca2 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -626,6 +626,7 @@
 				reg-names = "phy";
 				status = "disabled";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb0: usb@47401000 {
@@ -674,6 +675,7 @@
 				reg-names = "phy";
 				status = "disabled";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb1: usb@47401800 {
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 9708157f5daf..b7a11c1168d1 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -75,6 +75,7 @@
 				reg = <0x47401300 0x100>;
 				reg-names = "phy";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb0: usb@47401000 {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
