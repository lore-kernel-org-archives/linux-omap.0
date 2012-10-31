From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RESEND PATCH 01/11] ARM: OMAP4: USB: Host: Add USB2 Host Device Tree Node
Date: Wed, 31 Oct 2012 19:56:42 +0530
Message-ID: <1351693612-23314-2-git-send-email-keshava_mgowda@ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39083 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272Ab2JaO1F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 10:27:05 -0400
In-Reply-To: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, b-cousson@ti.com

The device tree node details of usb2 host and tll components
are included for OMAP4 SOC

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 .../devicetree/bindings/usb/omap-usb-host.txt      |   24 ++++++++++++++++++++
 .../devicetree/bindings/usb/omap-usb-tll.txt       |   21 +++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   22 ++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb-host.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap-usb-tll.txt

diff --git a/Documentation/devicetree/bindings/usb/omap-usb-host.txt b/Documentation/devicetree/bindings/usb/omap-usb-host.txt
new file mode 100644
index 0000000..2ea987f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/omap-usb-host.txt
@@ -0,0 +1,24 @@
+USB HOST
+
+OMAP USB2 UHH
+
+Required properties:
+ - compatible: Should be "ti,usbhs"
+ - reg : Address set of system configuration of the usb host.Also
+has the register address of ehci and ohci IPs.
+ - interrupts :interrupts of ehci and ohci IPs.
+
+This is usually a subnode of ocp to which it is connected.
+
+usbhs: usbhs@0x4a064000 {
+	compatible = "ti,usbhs";
+	reg = <0x4a064000 0x800>, /* uhh */
+		  <0x4a064800 0x400>, /* ohci */
+		  <0x4a064c00 0x400>; /* ehci */
+	reg-names = "uhh", "ohci", "ehci";
+	interrupts = <0 76 0x4>, <0 77 0x4>;
+	interrupt-names = "ohci-irq", "ehci-irq";
+	interrupt-parent = <&gic>;
+		ti,hwmods = "usb_host_hs";
+};
+
diff --git a/Documentation/devicetree/bindings/usb/omap-usb-tll.txt b/Documentation/devicetree/bindings/usb/omap-usb-tll.txt
new file mode 100644
index 0000000..e2e49fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/omap-usb-tll.txt
@@ -0,0 +1,21 @@
+USB TLL
+
+OMAP USB2 TLL
+
+Required properties:
+ - compatible: Should be "ti,usbtll"
+ - reg : Address set of system configuration of the usb tll.
+ - interrupts :interrupts of usb tll.
+
+This is usually a subnode of ocp to which it is connected.
+
+usbtll: usbtll@0x4a062000 {
+	compatible = "ti,usbtll";
+	reg = <0x4a062000 0x1000>;
+	reg-names = "tll";
+	interrupts = <0 78 0x4>;
+	interrupt-names = "tll-irq";
+	interrupt-parent = <&gic>;
+	ti,hwmods = "usb_tll_hs";
+};
+
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3883f94..fb76ba3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -438,5 +438,27 @@
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
 		};
+
+		usbhs: usbhs@0x4a064000 {
+			compatible = "ti,usbhs";
+			reg = <0x4a064000 0x800>, /* uhh */
+				  <0x4a064800 0x400>, /* ohci */
+				  <0x4a064c00 0x400>; /* ehci */
+			reg-names = "uhh", "ohci", "ehci";
+			interrupts = <0 76 0x4>, <0 77 0x4>;
+			interrupt-names = "ohci-irq", "ehci-irq";
+			interrupt-parent = <&gic>;
+			ti,hwmods = "usb_host_hs";
+		};
+
+		usbtll: usbtll@0x4a062000 {
+			compatible = "ti,usbtll";
+			reg = <0x4a062000 0x1000>;
+			reg-names = "tll";
+			interrupts = <0 78 0x4>;
+			interrupt-names = "tll-irq";
+			interrupt-parent = <&gic>;
+			ti,hwmods = "usb_tll_hs";
+		};
 	};
 };
-- 
1.7.9.5

