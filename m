From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 09/10] arm: dts: dra7: Add qspi device.
Date: Fri, 6 Dec 2013 19:54:50 +0530
Message-ID: <1386339891-32717-10-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50987 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759230Ab3LFO0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 09:26:10 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

These add device tree entry for qspi controller driver on dra7.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
use "MUX_MODE1" instead of numeric value
 arch/arm/boot/dts/dra7-evm.dts |   32 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    |   13 +++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..4a57fdf 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -93,6 +93,21 @@
 			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
 		>;
 	};
+
+	qspi1_pins: pinmux_qspi1_pins {
+		pinctrl-single,pins = <
+			0x4c (PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
+			0x50 (PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
+			0x74 (PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
+			0x78 (PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
+			0x7c (PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
+			0x80 (PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
+			0x84 (PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
+			0x88 (PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
+			0xb8 (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
+			0xbc (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -273,3 +288,20 @@
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
+
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_pins>;
+
+	spi-max-frequency = <48000000>;
+	m25p80@0 {
+		compatible = "s25fl256s1";
+		spi-max-frequency = <48000000>;
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-cpol;
+		spi-cpha;
+	};
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 67275c8..b06d899 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -582,6 +582,19 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		qspi: qspi@4b300000 {
+			compatible = "ti,dra7xxx-qspi";
+			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+					<0x5c000000 0x3ffffff>;
+			reg-names = "qspi_base", "qspi_ctrlmod", "qspi_mmap";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "qspi";
+			num-cs = <4>;
+			interrupts = <0 124 0x4>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
1.7.1

