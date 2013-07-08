From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 4/5] arm: dts: Add USB phy nodes for AM33XX
Date: Mon, 8 Jul 2013 16:13:20 +0530
Message-ID: <1373280201-31785-5-git-send-email-george.cherian@ti.com>
References: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373280201-31785-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com, bigeasy@linutronix.de, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DT bindings of phy nodes for AM33XX platform.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8e1248f..4f3cca0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -326,6 +326,25 @@
 			status = "disabled";
 		};
 
+		phy1: usbphy-gs70@44e10620 {
+			compatible = "ti,am335x-usb2";
+			#phy-cells = <0>;
+			id = <0>;
+		};
+
+		phy2: usbphy-gs71@44e10628 {
+			compatible = "ti,am335x-usb2";
+			#phy-cells = <0>;
+			id = <1>;
+		};
+
+		omap_control_usb: omap-control-usb@44e10620 {
+			compatible = "ti,omap-control-usb";
+			reg = <0x44e10620 0x10>;
+			reg-names = "control_dev_conf";
+			ti,type = <3>;
+		};
+
 		usb@47400000 {
 			compatible = "ti,musb-am33xx";
 			reg = <0x47400000 0x1000	/* usbss */
@@ -341,6 +360,9 @@
 			port1-mode = <3>;
 			power = <250>;
 			ti,hwmods = "usb_otg_hs";
+			phy-names = "am335x-usb0", "am335x-usb1";
+			phys	= <&phy1>, <&phy2>;
+
 		};
 
 		mac: ethernet@4a100000 {
-- 
1.8.1.4
