From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] arm: omap5: dts: add palmas-usb node
Date: Mon, 15 Jul 2013 18:33:42 +0300
Message-ID: <1373902423-28654-4-git-send-email-balbi@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab3GOPeh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 11:34:37 -0400
In-Reply-To: <1373902423-28654-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>

Without this node, there will be no palmas
driver to notify dwc3 that a cable has
been connected and, without that, dwc3
will never initialize.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
 arch/arm/boot/dts/omap5.dtsi     |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..badceb8 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -272,6 +272,11 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		extcon_usb3: palmas_usb {
+			compatible = "ti,palmas-usb";
+			ti,wakeup;
+		};
+
 		palmas_pmic {
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
@@ -450,6 +455,11 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
+&usb3 {
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_reg>;
+};
+
 &mcspi1 {
 
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4e41409..1659246 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -634,7 +634,7 @@
 			ti,type = <2>;
 		};
 
-		omap_dwc3@4a020000 {
+		usb3: omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
 			reg = <0x4a020000 0x10000>;
-- 
1.8.2.1

