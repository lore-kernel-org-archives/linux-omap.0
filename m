From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: dra7x-evm: beagle-x14: Fix USB Peripheral
Date: Tue, 17 Mar 2015 11:43:51 +0200
Message-ID: <1426585431-29914-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38691 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbbCQJn4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 05:43:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Now that we have EXTCON_USB_GPIO queued for v4.1, revert
commit addfcde7c485 ("ARM: dts: dra7x-evm: beagle-x15: Fix USB Host")

On these EVMs, the USB cable state has to be determined via the
ID pin tied to a GPIO line. We use the gpio-usb-extcon driver
to read the ID pin and the extcon framework to forward
the USB cable state information to the USB driver so the
controller can be configured in the right mode (host/peripheral).

Gets USB peripheral mode to work on this EVM.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 8 ++++++++
 arch/arm/boot/dts/dra7-evm.dts          | 8 ++++++++
 arch/arm/boot/dts/dra72-evm.dts         | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index bd48dba..170fbf9 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -548,6 +548,14 @@
 	pinctrl-0 = <&usb1_pins>;
 };
 
+&omap_dwc3_1 {
+	extcon = <&extcon_usb1>;
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb2 {
 	dr_mode = "peripheral";
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index b1bd06c..aa46590 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -541,6 +541,14 @@
 	};
 };
 
+&omap_dwc3_1 {
+	extcon = <&extcon_usb1>;
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index daf2811..ce0390f 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -377,6 +377,14 @@
 	phy-supply = <&ldo4_reg>;
 };
 
+&omap_dwc3_1 {
+	extcon = <&extcon_usb1>;
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
-- 
2.1.0

