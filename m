From: Eyal Reizer <eyalreizer@gmail.com>
Subject: [PATCHv2] am335x-evm: add bluetooth support
Date: Mon,  4 May 2015 15:41:13 +0300
Message-ID: <1430743273-2518-1-git-send-email-eyalr@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37567 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbbEDMl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 08:41:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eliad Peller <eliad@wizery.com>, Eyal Reizer <eyalr@ti.com>

From: Eliad Peller <eliad@wizery.com>

uart1 is used for connecting to wilink8 bluetooth subsystem.
add the needed muxes and definitions.

Signed-off-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
Changes in v2:
removed ti shared transport bindings

 arch/arm/boot/dts/am335x-evm.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0f398fa..765be27 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -191,6 +191,15 @@
 		>;
 	};
 
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+		>;
+	};
+
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
 			0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
@@ -357,6 +366,13 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
1.7.9.5

