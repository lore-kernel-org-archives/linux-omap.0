From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 8/8] ARM: dts: omap5: update omap-control-usb node
Date: Mon, 26 Aug 2013 18:08:33 +0300
Message-ID: <1377529713-19762-9-git-send-email-rogerq@ti.com>
References: <1377529713-19762-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab3HZPJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 11:09:30 -0400
In-Reply-To: <1377529713-19762-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, thomas.langer@lantiq.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Split USB2 PHY and USB3 PHY into separate omap-control-usb
nodes. Get rid of "ti,type" property.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 07be2cd..7cda18b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -626,12 +626,16 @@
 			hw-caps-temp-alert;
 		};
 
-		omap_control_usb: omap-control-usb@4a002300 {
-			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a002370 0x4>;
-			reg-names = "control_dev_conf", "phy_power_usb";
-			ti,type = <2>;
+		omap_control_usb2phy: omap-control-usb@4a002300 {
+			compatible = "ti,usb2-control-usb";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usb3phy: omap-control-usb@0x4a002370 {
+			compatible = "ti,usb3-control-usb";
+			reg = <0x4a002370 0x4>;
+			reg-names = "power";
 		};
 
 		omap_dwc3@4a020000 {
@@ -661,7 +665,7 @@
 			usb2_phy: usb2phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb2phy>;
 			};
 
 			usb3_phy: usb3phy@4a084400 {
@@ -670,7 +674,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb3phy>;
 			};
 		};
 
-- 
1.7.4.1

