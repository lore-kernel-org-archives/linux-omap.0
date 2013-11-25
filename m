From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix omap serial wake-up when booted with device
 tree
Date: Mon, 25 Nov 2013 12:11:42 -0800
Message-ID: <20131125201142.GT10023@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64889 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754934Ab3KYULq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 15:11:46 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

We've had deeper idle states working on omaps for few years now,
but only in the legacy mode. When booted with device tree, the
wake-up events did not have a chance to work until commit
3e6cee1786a1 (pinctrl: single: Add support for wake-up interrupts)
that recently got merged. In addition to that we also needed commit
79d9701559a9 (of/irq: create interrupts-extended property) that's
now also merged.

So let's fix the wake-up events for some selected omaps so devices
booted in device tree mode won't just hang if deeper power states
are enabled, and so systems can wake up from suspend to the serial
port event.

Note that there's no longer need to specify the wake-up bit in
the pinctrl settings, the request_irq on the wake-up pin takes
care of that.

Cc: devicetree@vger.kernel.org
Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

=46YI, this depends on the device resource populating patch posted in
thread "[PATCH] of/platform: Fix no irq domain found errors when
populating interrupts" to avoid intoducing nasty warnings.

--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -89,7 +89,16 @@
 	status =3D "disabled";
 };
=20
+&uart1 {
+	interrupts-extended =3D <&intc 72 &omap3_pmx_core OMAP3_UART1_RX>;
+};
+
+&uart2 {
+	interrupts-extended =3D <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
+};
+
 &uart3 {
+	interrupts-extended =3D <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart3_pins>;
 };
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -495,11 +495,13 @@
 };
=20
 &uart2 {
+	interrupts-extended =3D <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart2_pins>;
 };
=20
 &uart3 {
+	interrupts-extended =3D <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart3_pins>;
 };
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -207,7 +207,7 @@
 		uart1: serial@4806a000 {
 			compatible =3D "ti,omap3-uart";
 			reg =3D <0x4806a000 0x2000>;
-			interrupts =3D <72>;
+			interrupts-extended =3D <&intc 72>;
 			dmas =3D <&sdma 49 &sdma 50>;
 			dma-names =3D "tx", "rx";
 			ti,hwmods =3D "uart1";
@@ -217,7 +217,7 @@
 		uart2: serial@4806c000 {
 			compatible =3D "ti,omap3-uart";
 			reg =3D <0x4806c000 0x400>;
-			interrupts =3D <73>;
+			interrupts-extended =3D <&intc 73>;
 			dmas =3D <&sdma 51 &sdma 52>;
 			dma-names =3D "tx", "rx";
 			ti,hwmods =3D "uart2";
@@ -227,7 +227,7 @@
 		uart3: serial@49020000 {
 			compatible =3D "ti,omap3-uart";
 			reg =3D <0x49020000 0x400>;
-			interrupts =3D <74>;
+			interrupts-extended =3D <&intc 74>;
 			dmas =3D <&sdma 53 &sdma 54>;
 			dma-names =3D "tx", "rx";
 			ti,hwmods =3D "uart3";
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -396,6 +396,21 @@
 	usb-supply =3D <&vusb>;
 };
=20
+&uart2 {
+	interrupts-extended =3D <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART2_RX>;
+};
+
+&uart3 {
+	interrupts-extended =3D <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
+
+&uart4 {
+	interrupts-extended =3D <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART4_RX>;
+};
+
 &usb_otg_hs {
 	interface-type =3D <1>;
 	mode =3D <3>;
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -523,16 +523,22 @@
 };
=20
 &uart2 {
+	interrupts-extended =3D <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART2_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart2_pins>;
 };
=20
 &uart3 {
+	interrupts-extended =3D <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart3_pins>;
 };
=20
 &uart4 {
+	interrupts-extended =3D <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART4_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart4_pins>;
 };
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -236,7 +236,7 @@
 		uart2: serial@4806c000 {
 			compatible =3D "ti,omap4-uart";
 			reg =3D <0x4806c000 0x100>;
-			interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "uart2";
 			clock-frequency =3D <48000000>;
 		};
@@ -244,7 +244,7 @@
 		uart3: serial@48020000 {
 			compatible =3D "ti,omap4-uart";
 			reg =3D <0x48020000 0x100>;
-			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "uart3";
 			clock-frequency =3D <48000000>;
 		};
@@ -252,7 +252,7 @@
 		uart4: serial@4806e000 {
 			compatible =3D "ti,omap4-uart";
 			reg =3D <0x4806e000 0x100>;
-			interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "uart4";
 			clock-frequency =3D <48000000>;
 		};
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -49,5 +49,17 @@
 #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
=20
+/*
+ * Define some commonly used pins configured by the boards.
+ * Note that some boards use alternative pins, so check
+ * the schematics before using these.
+ */
+#define OMAP3_UART1_RX		0x152
+#define OMAP3_UART2_RX		0x14a
+#define OMAP3_UART3_RX		0x16e
+#define OMAP4_UART2_RX		0xdc
+#define OMAP4_UART3_RX		0x104
+#define OMAP4_UART4_RX		0x11c
+
 #endif
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
