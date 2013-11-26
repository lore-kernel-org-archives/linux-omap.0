From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 16/17] arm: dts: am43x-epos: Add qspi device.
Date: Tue, 26 Nov 2013 13:05:12 +0530
Message-ID: <1385451313-1875-17-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52198 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755Ab3KZHgq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 02:36:46 -0500
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>

These add device tree entry for qspi controller driver on am43x-epos-evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |   12 ++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index f1dd131..6ccf5c2 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -663,6 +663,18 @@
 			       <&edma 11>;
 			dma-names = "tx", "rx";
 		};
+
+		qspi: qspi@47900000 {
+			compatible = "ti,am4372-qspi";
+			reg = <0x47900000 0x100>, <0x30000000 0x3ffffff>;
+			reg-names = "qspi_base", "qspi_mmap";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "qspi";
+			interrupts = <0 138 0x4>;
+			num-cs = <4>;
+                        status = "disabled";
+                };
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..a037a92 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -79,6 +79,17 @@
 				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
+
+		qspi1_default: qspi1_default {
+			pinctrl-single,pins = <
+				0x7c (PIN_INPUT_PULLUP | MUX_MODE3)
+				0x88 (PIN_INPUT_PULLUP | MUX_MODE2)
+				0x90 (PIN_INPUT_PULLUP | MUX_MODE3)
+				0x94 (PIN_INPUT_PULLUP | MUX_MODE3)
+				0x98 (PIN_INPUT_PULLUP | MUX_MODE3)
+				0x9c (PIN_INPUT_PULLUP | MUX_MODE3)
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -184,3 +195,20 @@
 &gpio3 {
 	status = "okay";
 };
+
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_default>;
+
+	spi-max-frequency = <48000000>;
+	m25p80@0 {
+		compatible = "mx66l51235l";
+		spi-max-frequency = <48000000>;
+		reg = <0>;
+		spi-cpol;
+		spi-cpha;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
-- 
1.7.1

