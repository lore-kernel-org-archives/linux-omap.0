From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 7/8] ARM: dts: omap4: update omap-control-usb nodes
Date: Tue, 20 Aug 2013 17:56:16 +0300
Message-ID: <1377010577-19355-8-git-send-email-rogerq@ti.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377010577-19355-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Split otghs_ctrl and USB2 PHY power down into separate
omap-control-usb nodes. Get rid of "ti,type" property.

Also get rid of "ti,has-mailbox" property from usb_otg_hs
node and provide the ctrl-module phandle.

CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..a77dd0a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -519,7 +519,7 @@
 			usb2_phy: usb2phy@4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb2phy>;
 			};
 		};
 
@@ -643,12 +643,16 @@
 			};
 		};
 
-		omap_control_usb: omap-control-usb@4a002300 {
-			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a00233c 0x4>;
-			reg-names = "control_dev_conf", "otghs_control";
-			ti,type = <1>;
+		omap_control_usb2phy: omap-control-usb@4a002300 {
+			compatible = "ti,usb2-control-usb";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usbotg: omap-control-usb@4a00233c {
+			compatible = "ti,omap4-control-usb";
+			reg = <0x4a00233c 0x4>;
+			reg-names = "otghs_control";
 		};
 
 		usb_otg_hs: usb_otg_hs@4a0ab000 {
@@ -661,7 +665,7 @@
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-			ti,has-mailbox;
+			ctrl-module = <&omap_control_usbotg>;
 		};
 	};
 };
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
