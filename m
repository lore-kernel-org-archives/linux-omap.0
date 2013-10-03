From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 6/8] ARM: dts: omap4: update omap-control-usb nodes
Date: Thu, 3 Oct 2013 12:59:04 +0300
Message-ID: <1380794346-30185-7-git-send-email-rogerq@ti.com>
References: <1380794346-30185-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380794346-30185-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, thomas.langer@lantiq.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Split otghs_ctrl and USB2 PHY power-down into separate
omap-control-usb nodes. Get rid of "ti,type" property.

Also get rid of "ti,has-mailbox" property from usb_otg_hs
node and provide the ctrl-module phandle.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 1e8e2fe..ea4054b 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -519,7 +519,7 @@
 			usb2_phy: usb2phy@4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb2phy>;
 				#phy-cells = <0>;
 			};
 		};
@@ -644,12 +644,16 @@
 			};
 		};
 
-		omap_control_usb: omap-control-usb@4a002300 {
-			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a00233c 0x4>;
-			reg-names = "control_dev_conf", "otghs_control";
-			ti,type = <1>;
+		omap_control_usb2phy: control-phy@4a002300 {
+			compatible = "ti,control-phy-usb2";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usbotg: control-phy@4a00233c {
+			compatible = "ti,control-phy-otghs";
+			reg = <0x4a00233c 0x4>;
+			reg-names = "otghs_control";
 		};
 
 		usb_otg_hs: usb_otg_hs@4a0ab000 {
@@ -664,7 +668,7 @@
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
