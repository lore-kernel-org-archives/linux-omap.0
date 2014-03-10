From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv3 1/2] arm: dts: dra7: Add qspi device.
Date: Mon, 10 Mar 2014 17:21:01 +0530
Message-ID: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39029 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaCJLvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 07:51:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

These add device tree entry for qspi controller driver on dra7-evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
Done and tested on top of
linux-next + benoit for_15 + tony crossbar branch +
crossbar dts patches.
v2->v3:
This was added as part of the following series,
http://www.spinics.net/lists/linux-omap/msg101024.html
Few patches of the above series are picked.
Sending this dts patch with updates[1] to enable spi mode
operations with flash device.
[1]: 
 - Enables only SPI mode operations
 - Add partition table
 - Add crossbar interrupt value.

 arch/arm/boot/dts/dra7-evm.dts |   80 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    |   13 +++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..986fcf3 100644
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
@@ -273,3 +288,68 @@
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* MTD partition table.
+		 * The ROM checks the first four physical blocks
+		 * for a valid file to boot and the flash here is
+		 * 64KiB block size.
+		 */
+		partition@0 {
+			label = "QSPI.SPL";
+			reg = <0x00000000 0x000010000>;
+		};
+		partition@1 {
+			label = "QSPI.SPL.backup1";
+			reg = <0x00010000 0x00010000>;
+		};
+		partition@2 {
+			label = "QSPI.SPL.backup2";
+			reg = <0x00020000 0x00010000>;
+		};
+		partition@3 {
+			label = "QSPI.SPL.backup3";
+			reg = <0x00030000 0x00010000>;
+		};
+		partition@4 {
+			label = "QSPI.u-boot";
+			reg = <0x00040000 0x00180000>;
+		};
+		partition@5 {
+			label = "QSPI.u-boot-spl-os";
+			reg = <0x001c0000 0x00010000>;
+		};
+		partition@6 {
+			label = "QSPI.u-boot-env";
+			reg = <0x001d0000 0x00010000>;
+		};
+		partition@7 {
+			label = "QSPI.u-boot-env.backup1";
+			reg = <0x001e0000 0x0010000>;
+		};
+		partition@8 {
+			label = "QSPI.kernel";
+			reg = <0x001f0000 0x00500000>;
+		};
+		partition@9 {
+			label = "QSPI.file-system";
+			reg = <0x006f0000 0x01910000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d2ff52..a7a2fa8 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -645,6 +645,19 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		qspi: qspi@4b300000 {
+			compatible = "ti,dra7xxx-qspi";
+			reg = <0x4b300000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "qspi";
+			clocks = <&qspi_gfclk_div>;
+			clock-names = "fck";
+			num-cs = <4>;
+			interrupts = <0 343 0x4>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.9.5

