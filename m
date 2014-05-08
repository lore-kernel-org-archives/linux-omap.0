From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 4/5] arm: dts: am4372: Add hdq device tree data.
Date: Thu, 8 May 2014 11:30:07 +0530
Message-ID: <1399528808-6920-5-git-send-email-sourav.poddar@ti.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbaEHGBG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 02:01:06 -0400
In-Reply-To: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add device tree nodes and pinmux for hdq/1wire on
am43x epos evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |   10 ++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 36d523a..5f7c167 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -735,6 +735,16 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		hdq: hdq@48347000 {
+			compatible = "ti,am43xx-hdq";
+			reg = <0x48347000 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&func_12m_clk>;
+			clock-names = "fck";
+			ti,hwmods = "hdq1w";
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 167dbc8..e71ef1c 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -138,6 +138,12 @@
 				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 			>;
 		};
+
+		hdq_pins: pinmux_hdq_pins {
+			pinctrl-single,pins = <
+				0x234 (PIN_INPUT_PULLUP | MUX_MODE1)    /* cam1_wen.hdq_gpio */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -367,3 +373,9 @@
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 };
+
+&hdq {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdq_pins>;
+};
-- 
1.7.9.5

