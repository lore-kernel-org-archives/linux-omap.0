From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 5/9] arm: dts: am43x-epos-evm: Add SPI data.
Date: Thu, 19 Dec 2013 18:03:37 +0530
Message-ID: <1387456421-21379-6-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52000 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757021Ab3LSMeQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 07:34:16 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add SPI dts data.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index d781a69..a7d0db1 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -93,6 +93,24 @@
 				0x1c4 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_scl.i2c2_scl */
 			>;
 		};
+
+		spi0_pins: pinmux_spi0_pins {
+			pinctrl-single,pins = <
+				0x150 (PIN_INPUT | MUX_MODE0)           /* spi0_clk.spi0_clk */
+				0x154 (PIN_OUTPUT | MUX_MODE0)           /* spi0_d0.spi0_d0 */
+				0x158 (PIN_INPUT | MUX_MODE0)           /* spi0_d1.spi0_d1 */
+				0x15c (PIN_OUTPUT | MUX_MODE0)          /* spi0_cs0.spi0_cs0 */
+			>;
+		};
+
+		spi1_pins: pinmux_spi1_pins {
+			pinctrl-single,pins = <
+				0x190 (PIN_INPUT | MUX_MODE3)           /* mcasp0_aclkx.spi1_clk */
+				0x194 (PIN_OUTPUT | MUX_MODE3)           /* mcasp0_fsx.spi1_d0 */
+				0x198 (PIN_INPUT | MUX_MODE3)           /* mcasp0_axr0.spi1_d1 */
+				0x19c (PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -221,3 +239,15 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap0_pins>;
 };
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "okay";
+};
-- 
1.7.9.5

