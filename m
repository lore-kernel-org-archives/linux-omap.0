From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 16:37:48 +0200
Message-ID: <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48339 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932987Ab3GKOhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 10:37:18 -0400
In-Reply-To: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Philip Avinash <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Define PWM_POLARITY_NORMAL and PWM_POLARITY_INVERTED macros in
include/dt-bindings/pwm/pwm.h to be used by device tree sources.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt |  6 +++---
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt   |  5 +++--
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  5 +++--
 Documentation/devicetree/bindings/pwm/pwm.txt           |  8 +++++---
 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt    |  5 +++--
 arch/arm/boot/dts/am335x-evm.dts                        |  3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                      |  3 ++-
 arch/arm/boot/dts/wm8850-w70v2.dts                      |  3 ++-
 include/dt-bindings/pwm/pwm.h                           | 15 +++++++++++++++
 include/linux/pwm.h                                     |  4 ++--
 10 files changed, 40 insertions(+), 17 deletions(-)
 create mode 100644 include/dt-bindings/pwm/pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
index de0eaed..be09be4 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
@@ -4,9 +4,9 @@ Required properties:
 - compatible: should be "atmel,tcb-pwm"
 - #pwm-cells: Should be 3.  The first cell specifies the per-chip index
   of the PWM to use, the second cell is the period in nanoseconds and
-  bit 0 in the third cell is used to encode the polarity of PWM output.
-  Set bit 0 of the third cell in PWM specifier to 1 for inverse polarity &
-  set to 0 for normal polarity.
+  the third cell is used to encode the polarity of PWM output. Set the
+  PWM_POLARITY_NORMAL flag for normal polarity or the PWM_POLARITY_INVERSED
+  flag for inverted polarity. PWM flags are defined in <dt-bindings/pwm/pwm.h>.
 - tc-block: The Timer Counter block to use as a PWM chip.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index ac67c68..bece18b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -24,8 +24,9 @@ Required properties:
      - phandle to PWM controller node
      - index of PWM channel (from 0 to 4)
      - PWM signal period in nanoseconds
-     - bitmask of optional PWM flags:
-        0x1 - invert PWM signal
+     - bitmask of optional PWM flags as defined in <dt-bindings/pwm/pwm.h>:
+        PWM_POLARITY_NORMAL - normal polarity
+	PWM_POLARITY_INVERSED - inverted polarity
 
 Optional properties:
 - samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 337c6fc..9007d92 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -7,8 +7,9 @@ Required properties:
 - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
   First cell specifies the per-chip index of the PWM to use, the second
   cell is the period in nanoseconds and bit 0 in the third cell is used to
-  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
-  to 1 for inverse polarity & set to 0 for normal polarity.
+  encode the polarity of PWM output. Set the PWM_POLARITY_NORMAL flag for
+  normal polarity or the PWM_POLARITY_INVERSED flag for inverted polarity.
+  PWM flags are defined in <dt-bindings/pwm/pwm.h>.
 - reg: physical base address and size of the registers map.
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 06e6724..38c357a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -43,13 +43,15 @@ because the name "backlight" would be used as fallback anyway.
 pwm-specifier typically encodes the chip-relative PWM number and the PWM
 period in nanoseconds.
 
-Optionally, the pwm-specifier can encode a number of flags in a third cell:
-- bit 0: PWM signal polarity (0: normal polarity, 1: inverse polarity)
+Optionally, the pwm-specifier can encode a number of flags (defined in
+<dt-bindings/gpio/gpio.h>) in a third cell:
+- PWM_POLARITY_NORMAL: use the normal PWM signal polarity
+- PWM_POLARITY_INVERSED: invert the PWM signal polarity
 
 Example with optional PWM specifier for inverse polarity
 
 	bl: backlight {
-		pwms = <&pwm 0 5000000 1>;
+		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERSED>;
 		pwm-names = "backlight";
 	};
 
diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
index d21d82d..5b1b21f 100644
--- a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
@@ -6,8 +6,9 @@ Required properties:
 - #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
   First cell specifies the per-chip index of the PWM to use, the second
   cell is the period in nanoseconds and bit 0 in the third cell is used to
-  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
-  to 1 for inverse polarity & set to 0 for normal polarity.
+  encode the polarity of PWM output. Set the PWM_POLARITY_NORMAL flag for
+  normal polarity or the PWM_POLARITY_INVERSED flag for inverted polarity.
+  PWM flags are defined in <dt-bindings/pwm/pwm.h>.
 - clocks: phandle to the PWM source clock
 
 Example:
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 3aee1a4..c9da673 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TI AM335x EVM";
@@ -370,7 +371,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&ecap0 0 50000 0>;
+		pwms = <&ecap0 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 0c8ad17..5d4ec91 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TI AM335x EVM-SK";
@@ -298,7 +299,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&ecap2 0 50000 1>;
+		pwms = <&ecap2 0 50000 PWM_POLARITY_INVERSED>;
 		brightness-levels = <0 58 61 66 75 90 125 170 255>;
 		default-brightness-level = <8>;
 	};
diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
index 90e913f..171930a 100644
--- a/arch/arm/boot/dts/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/wm8850-w70v2.dts
@@ -11,13 +11,14 @@
 
 /dts-v1/;
 /include/ "wm8850.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Wondermedia WM8850-W70v2 Tablet";
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 1>;	/* duty inverted */
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERSED>;
 
 		brightness-levels = <0 40 60 80 100 130 190 255>;
 		default-brightness-level = <5>;
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
new file mode 100644
index 0000000..f82be30
--- /dev/null
+++ b/include/dt-bindings/pwm/pwm.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for most PWM bindings.
+ *
+ * Most PWM bindings can include a flags cell as part of the PWM specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#ifndef _DT_BINDINGS_PWM_PWM_H
+#define _DT_BINDINGS_PWM_PWM_H
+
+#define PWM_POLARITY_NORMAL			(0 << 0)
+#define PWM_POLARITY_INVERSED			(1 << 0)
+
+#endif
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f0feafd..ffde99b 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -69,8 +69,8 @@ struct pwm_chip;
  * period
  */
 enum pwm_polarity {
-	PWM_POLARITY_NORMAL,
-	PWM_POLARITY_INVERSED,
+	PWM_POLARITY_NORMAL = 0,
+	PWM_POLARITY_INVERSED = 1,
 };
 
 enum {
-- 
1.8.1.5

