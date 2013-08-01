From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 6/7] ARM: dts: omap4: update omap-control-usb nodes
Date: Thu, 1 Aug 2013 17:05:14 +0300
Message-ID: <1375365915-21380-7-git-send-email-rogerq@ti.com>
References: <1375365915-21380-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375365915-21380-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, kishon@ti.com, george.cherian@ti.com, dmurphy@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>
List-Id: linux-omap@vger.kernel.org

Split otghs_ctrl and USB2 PHY power down into separate
omap-control-usb nodes. Update ti,mode property.

CC: Benoit Cousson <benoit.cousson@linaro.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..9a6fa27 100644
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
 
@@ -643,11 +643,17 @@
 			};
 		};
 
-		omap_control_usb: omap-control-usb@4a002300 {
+		omap_control_usb2phy: omap-control-usb@4a002300 {
 			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a00233c 0x4>;
-			reg-names = "control_dev_conf", "otghs_control";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+			ti,type = <2>;
+		};
+
+		omap_control_usbotg: omap-control-usb@4a00233c {
+			compatible = "ti,omap-control-usb";
+			reg = <0x4a00233c 0x4>;
+			reg-names = "otghs_control";
 			ti,type = <1>;
 		};
 
@@ -662,6 +668,7 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 			ti,has-mailbox;
+			ctrl-module = <&omap_control_usbotg>;
 		};
 	};
 };
-- 
1.7.4.1
