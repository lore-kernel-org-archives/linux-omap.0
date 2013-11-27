From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 5/5] arm: dts: am43x-epos-evm: Add SPI data.
Date: Wed, 27 Nov 2013 13:00:47 +0530
Message-ID: <1385537447-6922-6-git-send-email-sourav.poddar@ti.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59503 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab3K0HbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 02:31:16 -0500
In-Reply-To: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add SPI dts data.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 7a504d1..2ebcde6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -104,6 +104,24 @@
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
@@ -249,3 +267,15 @@
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
1.7.1

