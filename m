From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 1/6] ARM: OMAP2+: dts: cm-t335: add initial support
Date: Tue, 24 Nov 2015 16:02:08 +0200
Message-ID: <1448373733-5839-2-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Add basic support for CompuLab cm-t335 module based on AM335X SoC.

CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
The module is built around the Texas Instruments Sitara AM3352/4
system-on-chip.

The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
Ethernet, CAN bus.

Current patch adds support:
UART0 and GPIO LED

Detailed description can be found at the module site:
http://www.compulab.co.il/products/computer-on-modules/cm-t335/

Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
[uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org: the default RAM amount reduced to
128MB to support also the minimal module configuration]
Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 .../devicetree/bindings/arm/omap/omap.txt          |  3 ++
 arch/arm/boot/dts/Makefile                         |  7 +--
 arch/arm/boot/dts/am335x-cm-t335.dts               | 63 ++++++++++++++++++++++
 3 files changed, 70 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..2154f97 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -138,6 +138,9 @@ Boards:
 - AM335X phyBOARD-WEGA: Single Board Computer dev kit
   compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx"
 
+- AM335X CM-T335 : System On Module, built around the Sitara AM3352/4
+  compatible = "compulab,cm-t335", "ti,am33xx"
+
 - OMAP5 EVM : Evaluation Module
   compatible = "ti,omap5-evm", "ti,omap5"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bb8fa02..0e011dc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -446,13 +446,14 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-base0033.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
-	am335x-sl50.dtb \
+	am335x-chiliboard.dtb \
+	am335x-cm-t335.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
+	am335x-lxm.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
-	am335x-lxm.dtb \
-	am335x-chiliboard.dtb \
+	am335x-sl50.dtb \
 	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-duovero-parlor.dtb \
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
new file mode 100644
index 0000000..719658e
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -0,0 +1,63 @@
+/*
+ * am335x-cm-t335.dts - Device Tree file for Compulab CM-T335
+ *
+ * Copyright (C) 2014 - 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "am33xx.dtsi"
+
+/ {
+	model = "CompuLab CM-T335";
+	compatible = "compulab,cm-t335", "ti,am33xx";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x8000000>;	/* 128 MB */
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_led_pins>;
+		led@0 {
+			label = "cm_t335:green";
+			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;	/* gpio2_0 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <>;
+
+	gpio_led_pins: pinmux_gpio_led_pins {
+		pinctrl-single,pins = <
+			/* gpmc_csn3.gpio2_0 */
+			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE7)
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+
+	status = "okay";
+};
+
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
