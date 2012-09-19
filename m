From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/3] ARM: dts: Add twl4030-usb data
Date: Wed, 19 Sep 2012 15:02:07 +0530
Message-ID: <1348047128-25692-3-git-send-email-kishon@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348047128-25692-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, gregkh@linuxfoundation.org, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add twl4030-usb data node in twl4030 device tree file. twl4030-usb is the phy
driver for MUSB used in omap3 chipsets. The dt data is comprised of two
interrupts, one for ID and one for VBUS and three phandles to regulator.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ff00017..18fa7a4 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -37,6 +37,18 @@
 		regulator-max-microvolt = <3150000>;
 	};
 
+	vusb1v5: regulator-vusb1v5 {
+		compatible = "ti,twl4030-vusb1v5";
+	};
+
+	vusb1v8: regulator-vusb1v8 {
+		compatible = "ti,twl4030-vusb1v8";
+	};
+
+	vusb3v1: regulator-vusb3v1 {
+		compatible = "ti,twl4030-vusb3v1";
+	};
+
 	twl_gpio: gpio {
 		compatible = "ti,twl4030-gpio";
 		gpio-controller;
@@ -44,4 +56,13 @@
 		interrupt-controller;
 		#interrupt-cells = <1>;
 	};
+
+	twl4030-usb {
+		compatible = "ti,twl4030-usb";
+		interrupts = <10>, <4>;
+		usb1v5-supply = <&vusb1v5>;
+		usb1v8-supply = <&vusb1v8>;
+		usb3v1-supply = <&vusb3v1>;
+		usb_mode = <1>;
+	};
 };
-- 
1.7.9.5
