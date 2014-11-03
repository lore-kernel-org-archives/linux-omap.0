From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] ARM: dts: dra7-evm: Add extcon nodes for USB
Date: Mon, 3 Nov 2014 10:46:27 -0600
Message-ID: <1415033187-11192-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbaKCQrF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2014 11:47:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, George Cherian <george.cherian@ti.com>, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>

From: George Cherian <george.cherian@ti.com>

Add extcon nodes for USB, without which USB won't
work.

EXTCON is used to tell dwc3-omap.ko that a cable
has been connected. It also passes the state of ID
pin so that can be written to UTMI_STATUS register
on dwc3-omap's address space.

Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

**********************************************************
**							**
**			UNTESTED			**
**********************************************************

This patch was taken from TI's v3.14 tree available at [1],
the patch was tested there. I didn't test on v3.18-rc3 because
my DRA7 board has broken down. Working to get a replacement.

Anyway, I'd suggest Tony to wait for a Tested-by tag.

Note that in order for this to work you need following extra
patches:

http://marc.info/?l=linux-omap&m=141503217215492&w=2
http://marc.info/?l=linux-omap&m=141503238715590&w=2
http://marc.info/?l=linux-omap&m=141503246515631&w=2
http://marc.info/?l=linux-omap&m=141503241315599&w=2
http://marc.info/?l=linux-omap&m=141503282815782&w=2

[1] http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commits/ti-linux-3.14.y

 arch/arm/boot/dts/dra7-evm.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index c6ce625..7710f29 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -26,6 +26,18 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	extcon1: dra7x_usbid_extcon1 {
+		compatible = "linux,extcon-gpio";
+		gpios = <&pcf_gpio_21 1 GPIO_ACTIVE_LOW>;
+		cable-name = "USB-HOST";
+	};
+
+	extcon2: dra7x_usbid_extcon2 {
+		compatible = "linux,extcon-gpio";
+		gpios = <&pcf_gpio_21 2 GPIO_ACTIVE_LOW>;
+		cable-name = "USB-HOST";
+	};
+
 	vtt_fixed: fixedregulator-vtt {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt_fixed";
@@ -291,6 +303,19 @@
 			};
 		};
 	};
+
+	pcf_gpio_21: gpio@21 {
+		compatible = "ti,pcf8575";
+		reg = <0x21>;
+		lines-initial-states = <0x1408>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 };
 
 &i2c2 {
@@ -420,6 +445,14 @@
 	};
 };
 
+&omap_dwc3_1 {
+	extcon = <&extcon1>;
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon2>;
+};
+
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
-- 
2.1.0.GIT

