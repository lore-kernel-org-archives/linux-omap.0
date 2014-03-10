From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv3 2/2] arm: dts: am43x-epos: Add qspi device.
Date: Mon, 10 Mar 2014 17:21:02 +0530
Message-ID: <1394452263-12975-2-git-send-email-sourav.poddar@ti.com>
References: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47566 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaCJLvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 07:51:17 -0400
In-Reply-To: <1394452263-12975-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

These add device tree entry for qspi controller driver on am43x-epos-evm.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
This was added as part of the following series,
http://www.spinics.net/lists/linux-omap/msg101024.html
Few patches of the above series are picked.
Sending this dts patch with updates[1] to enable spi mode
operations with flash device.
[1]: v2->v3
 - Enables only SPI mode operations
 - Add partition table

 arch/arm/boot/dts/am4372.dtsi        |   11 ++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |   63 ++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 5a7cc38..c426d25 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -698,6 +698,17 @@
 			       <&edma 11>;
 			dma-names = "tx", "rx";
 		};
+
+		qspi: qspi@47900000 {
+			compatible = "ti,am4372-qspi";
+			reg = <0x47900000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "qspi";
+			interrupts = <0 138 0x4>;
+			num-cs = <4>;
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a7d0db1..20c7fa6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -111,6 +111,17 @@
 				0x19c (PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
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
@@ -251,3 +262,55 @@
 	pinctrl-0 = <&spi1_pins>;
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* MTD partition table.
+		 * The ROM checks the first 512KiB
+		 * for a valid file to boot(XIP).
+		 */
+		partition@0 {
+			label = "QSPI.U_BOOT";
+			reg = <0x00000000 0x000080000>;
+		};
+		partition@1 {
+			label = "QSPI.U_BOOT.backup";
+			reg = <0x00080000 0x00080000>;
+		};
+		partition@2 {
+			label = "QSPI.U-BOOT-SPL_OS";
+			reg = <0x00100000 0x00010000>;
+		};
+		partition@3 {
+			label = "QSPI.U_BOOT_ENV";
+			reg = <0x00110000 0x00010000>;
+		};
+		partition@4 {
+			label = "QSPI.U-BOOT-ENV.backup";
+			reg = <0x00120000 0x00010000>;
+		};
+		partition@5 {
+			label = "QSPI.KERNEL";
+			reg = <0x00130000 0x0800000>;
+		};
+		partition@6 {
+			label = "QSPI.FILESYSTEM";
+			reg = <0x00930000 0x36D0000>;
+		};
+	};
+};
-- 
1.7.9.5

