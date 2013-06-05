From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 4/4] ARM: dts: omap5-uevm: Add uart pinctrl data
Date: Wed, 5 Jun 2013 12:16:10 +0530
Message-ID: <1370414770-1485-5-git-send-email-r.sricharan@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab3FEGqv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 02:46:51 -0400
In-Reply-To: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: r.sricharan@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Sourav Poddar <sourav.poddar@ti.com>

From: Sourav Poddar <sourav.poddar@ti.com>

Booting omap5 uevm results in the following error
"did not get pins for uart error: -19"

This happens because omap5 uevm dts file is not adapted to use uart through pinctrl
framework. Populating uart pinctrl data to get rid of the error.

Cc: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
[Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index a2aed5b..e545e64 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -192,6 +192,32 @@
 			0x196 (PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 OUTPUT | MODE6 */
 		>;
 	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x60 (PIN_OUTPUT | MUX_MODE0) /* uart1_tx.uart1_cts MODE0 */
+			0x62 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_tx.uart1_cts INPUT | PULLUP | MODE0 */
+			0x64 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_rx.uart1_rts INPUT | PULLUP | MODE0 */
+			0x66 (PIN_OUTPUT | MUX_MODE0) /* uart1_rx.uart1_rts MODE0 */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x19a (PIN_OUTPUT | MUX_MODE0) /* uart3_rts_irsd.uart3_tx_irtx MODE0 */
+			0x19c (PIN_INPUT_PULLUP | MUX_MODE0) /* uart3_rx_irrx.uart3_usbb3_hsic INPUT | PULLUP | MODE0 */
+		>;
+	};
+
+	uart5_pins: pinmux_uart5_pins {
+		pinctrl-single,pins = <
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_rx.uart5_rx INPUT | PULLUP | MODE0 */
+			0x172 (PIN_OUTPUT | MUX_MODE0) /* uart5_tx.uart5_tx MODE0 */
+			0x174 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_cts.uart5_rts INPUT | PULLUP | MODE0 */
+			0x176 (PIN_OUTPUT | MUX_MODE0) /* uart5_cts.uart5_rts MODE0 */
+		>;
+	};
+
 };
 
 &omap5_pmx_wkup {
@@ -276,3 +302,18 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi4_pins>;
 };
+
+&uart1 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart1_pins>;
+};
+
+&uart3 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart3_pins>;
+};
+
+&uart5 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart5_pins>;
+};
-- 
1.7.9.5

