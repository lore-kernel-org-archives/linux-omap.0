From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 9/9] arm: dts: am43x-gp-evm: Add matrix gpio keys.
Date: Thu, 19 Dec 2013 18:03:41 +0530
Message-ID: <1387456421-21379-10-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40944 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3LSMef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 07:34:35 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add gpio keys node for am43x gp evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 0dc248d..4eb72b8 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -13,6 +13,7 @@
 #include "am4372.dtsi"
 #include <dt-bindings/pinctrl/am43xx.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "TI AM437x GP EVM";
@@ -24,6 +25,26 @@
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
+
+	matrix_keypad: matrix_keypad@0 {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <2>;
+
+		row-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH /* Bank3, pin21 */
+				&gpio4 3 GPIO_ACTIVE_HIGH /* Bank4, pin3 */
+				&gpio4 2 GPIO_ACTIVE_HIGH>; /* Bank4, pin2 */
+
+		col-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH /* Bank3, pin19 */
+				&gpio3 20 GPIO_ACTIVE_HIGH>; /* Bank3, pin20 */
+
+		linux,keymap = <0x00000201      /* P1 */
+				0x00010202      /* P2 */
+				0x01000067      /* UP */
+				0x0101006a      /* RIGHT */
+				0x02000069      /* LEFT */
+				0x0201006c>;      /* DOWN */
+		};
 };
 
 &am43xx_pinmux {
-- 
1.7.9.5

