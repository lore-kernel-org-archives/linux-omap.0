From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 28/35] ARM: dts: am43xx-epos-evm: fix pinmux node layout
Date: Wed, 18 Mar 2015 16:44:13 +0200
Message-ID: <1426689860-17537-29-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175AbbCROpc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:32 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Pinmux node should be a reference to the base one, not a complete re-write
of it. Having the node like this also prevents modifying the node layout
in the base am4372.dtsi file, which is needed for control module changes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   84 +++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 257c099..72f01bb 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -69,7 +69,48 @@
 		};
 	};
 
-	am43xx_pinmux: pinmux@44e10800 {
+	matrix_keypad: matrix_keypad@0 {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <2>;
+
+		row-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH		/* Bank0, pin12 */
+			     &gpio0 13 GPIO_ACTIVE_HIGH		/* Bank0, pin13 */
+			     &gpio0 14 GPIO_ACTIVE_HIGH		/* Bank0, pin14 */
+			     &gpio0 15 GPIO_ACTIVE_HIGH>;	/* Bank0, pin15 */
+
+		col-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH		/* Bank3, pin9 */
+			     &gpio3 10 GPIO_ACTIVE_HIGH		/* Bank3, pin10 */
+			     &gpio2 18 GPIO_ACTIVE_HIGH		/* Bank2, pin18 */
+			     &gpio2 19 GPIO_ACTIVE_HIGH>;	/* Bank2, pin19 */
+
+		linux,keymap = <0x00000201	/* P1 */
+			0x01000204	/* P4 */
+			0x02000207	/* P7 */
+			0x0300020a	/* NUMERIC_STAR */
+			0x00010202	/* P2 */
+			0x01010205	/* P5 */
+			0x02010208	/* P8 */
+			0x03010200	/* P0 */
+			0x00020203	/* P3 */
+			0x01020206	/* P6 */
+			0x02020209	/* P9 */
+			0x0302020b	/* NUMERIC_POUND */
+			0x00030067	/* UP */
+			0x0103006a	/* RIGHT */
+			0x0203006c	/* DOWN */
+			0x03030069>;	/* LEFT */
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
+};
+
+&am43xx_pinmux {
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
 				/* Slave 1 */
@@ -279,47 +320,6 @@
 				0x204 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
 			>;
 		};
-	};
-
-	matrix_keypad: matrix_keypad@0 {
-			compatible = "gpio-matrix-keypad";
-			debounce-delay-ms = <5>;
-			col-scan-delay-us = <2>;
-
-			row-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH		/* Bank0, pin12 */
-				     &gpio0 13 GPIO_ACTIVE_HIGH		/* Bank0, pin13 */
-				     &gpio0 14 GPIO_ACTIVE_HIGH		/* Bank0, pin14 */
-				     &gpio0 15 GPIO_ACTIVE_HIGH>;	/* Bank0, pin15 */
-
-			col-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH		/* Bank3, pin9 */
-				     &gpio3 10 GPIO_ACTIVE_HIGH		/* Bank3, pin10 */
-				     &gpio2 18 GPIO_ACTIVE_HIGH		/* Bank2, pin18 */
-				     &gpio2 19 GPIO_ACTIVE_HIGH>;	/* Bank2, pin19 */
-
-			linux,keymap = <0x00000201	/* P1 */
-				0x01000204	/* P4 */
-				0x02000207	/* P7 */
-				0x0300020a	/* NUMERIC_STAR */
-				0x00010202	/* P2 */
-				0x01010205	/* P5 */
-				0x02010208	/* P8 */
-				0x03010200	/* P0 */
-				0x00020203	/* P3 */
-				0x01020206	/* P6 */
-				0x02020209	/* P9 */
-				0x0302020b	/* NUMERIC_POUND */
-				0x00030067	/* UP */
-				0x0103006a	/* RIGHT */
-				0x0203006c	/* DOWN */
-				0x03030069>;	/* LEFT */
-		};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 51 53 56 62 75 101 152 255>;
-		default-brightness-level = <8>;
-	};
 };
 
 &mmc1 {
-- 
1.7.9.5

