From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 01/14] ARM: dts: am437x: cm-t43: add basic support for sbc-t43
Date: Tue,  1 Dec 2015 15:54:56 +0200
Message-ID: <1448978109-5614-2-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448978109-5614-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add basic support for SBC-T43: a CM-T43 based single board computer.
CM-T43 is an AM437x based System-on-Module designed to serve as a building
block in embedded applications. SBC-T43 is composed of CM-T43 module on
top of the SB-SOM-T43 baseboard.
Basic support includes UART, GPIO, and I2C.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
Changes in V2:
	- Added spaces between strings in "compatible" properties
	- Removed extra linebreak in end of am437x-sbc-t43.dts file

 .../devicetree/bindings/arm/omap/omap.txt          |  6 ++
 arch/arm/boot/dts/Makefile                         |  6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                | 90 ++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts               | 56 ++++++++++++++
 4 files changed, 156 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..04161f5 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -141,6 +141,12 @@ Boards:
 - OMAP5 EVM : Evaluation Module
   compatible = "ti,omap5-evm", "ti,omap5"
 
+- AM437x CM-T43
+  compatible = "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
+
+- AM437x SBC-T43
+  compatible = "compulab,am437x-sbc-t43", "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
+
 - AM43x EPOS EVM
   compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..dc3b9af 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -478,9 +478,11 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-var-stk-om44.dtb
 dtb-$(CONFIG_SOC_AM43XX) += \
 	am43x-epos-evm.dtb \
-	am437x-sk-evm.dtb \
+	am437x-cm-t43.dtb \
+	am437x-gp-evm.dtb \
 	am437x-idk-evm.dtb \
-	am437x-gp-evm.dtb
+	am437x-sbc-t43.dtb \
+	am437x-sk-evm.dtb
 dtb-$(CONFIG_SOC_OMAP5) += \
 	omap5-cm-t54.dtb \
 	omap5-igep0050.dtb \
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
new file mode 100644
index 0000000..a131b97
--- /dev/null
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/am43xx.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "am4372.dtsi"
+
+/ {
+	model = "CompuLab CM-T43";
+	compatible = "compulab,am437x-cm-t43", "ti,am4372", "ti,am43";
+
+	leds {
+		compatible = "gpio-leds";
+
+		ledb {
+			label = "cm-t43:green";
+			gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&am43xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cm_t43_led_pins>;
+
+	cm_t43_led_pins: cm_t43_led_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xa78, MUX_MODE7)
+		>;
+	};
+
+	i2c0_pins: i2c0_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+		>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <100000>;
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&gpio3 {
+	status = "okay";
+};
+
+&gpio4 {
+	status = "okay";
+};
+
+&gpio5 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cpu {
+	operating-points = <1000000 1330000>,
+			   <800000 1260000>,
+			   <720000 1200000>,
+			   <600000 1100000>,
+			   <300000 950000>;
+};
diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
new file mode 100644
index 0000000..6ca22b7
--- /dev/null
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "am437x-cm-t43.dts"
+
+/ {
+	model = "CompuLab CM-T43 on SB-SOM-T43";
+	compatible = "compulab,am437x-sbc-t43", "compulab,am437x-cm-t43", "ti,am4372", "ti,am43";
+};
+
+&am43xx_pinmux {
+	uart0_pins_default: uart0_pins_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)
+			AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)
+			AM4372_IOPAD(0x970, PIN_INPUT_PULLUP | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_rxd.uart0_rxd */
+			AM4372_IOPAD(0x974, PIN_INPUT | PULL_DISABLE | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_txd.uart0_txd */
+		>;
+	};
+
+	i2c1_pins: i2c1_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0xa6c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE1)  /* spi2_cs0.i2c1_sda  */
+			AM4372_IOPAD(0xa60, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE1)  /* spi2_sclk.i2c1_scl */
+		>;
+	};
+
+	i2c2_pins: i2c2_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x978, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE3)  /* uart1_ctsn.i2c2_sda  */
+			AM4372_IOPAD(0x97c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE3)  /* uart1_rtsn.i2c2_scl */
+		>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_default>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
