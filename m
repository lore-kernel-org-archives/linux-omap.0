From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/5] ARM: dts: dra72-evm: Add extcon nodes for USB
Date: Mon, 19 Jan 2015 19:52:21 +0200
Message-ID: <1421689942-10201-5-git-send-email-rogerq@ti.com>
References: <1421689942-10201-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421689942-10201-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On this EVM, the USB cable state has to be determined via the
ID pin tied to a GPIO line. We use the gpio-usb-extcon driver
to read the ID pin and the extcon framework to forward
the USB cable state information to the USB driver so the
controller can be configured in the right mode (host/peripheral).

Gets USB peripheral mode to work on this EVM.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 89085d0..d93a98f 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "dra72x.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "TI DRA722";
@@ -24,6 +25,16 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	extcon_usb1: extcon_usb1 {
+		compatible = "linux,extcon-usb";
+		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	extcon_usb2: extcon_usb2 {
+		compatible = "linux,extcon-usb";
+		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &dra7_pmx_core {
@@ -243,6 +254,18 @@
 			ti,palmas-long-press-seconds = <6>;
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
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
 };
 
 &uart1 {
@@ -345,6 +368,14 @@
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
