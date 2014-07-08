From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] arm: dts: dra7: Enable CPSW and MDIO for dra7xx EVM
Date: Tue,  8 Jul 2014 20:40:51 +0200
Message-ID: <1404844852-19980-2-git-send-email-bigeasy@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34183 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbaGHSlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 14:41:15 -0400
In-Reply-To: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Praveen Rao <prao@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Mugunthan V N <mugunthanvnm@ti.com>

Adding CPSW phy-id, CPSW and MDIO pinmux configuration for active
and sleep states and enable them in board evm dts file.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
[Resolved merge conflict and rebased on 3.8 kernel.
Update the pinmux configuration for CPSW and MDIO by removing the
macro definitons to match the 3.8 implementation.]
Signed-off-by: Praveen Rao <prao@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/dra7-evm.dts | 61 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 4adc280..956a7bd 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -94,6 +94,46 @@
 		>;
 	};
 
+	cpsw_default_pins: pinmux_cpsw_default_pins {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			0x250	0x0 /* rgmii1_tclk PIN_OUTPUT | MUX_MODE0 */
+			0x254	0x0 /* rgmii1_tctl PIN_OUTPUT | MUX_MODE0 */
+			0x258	0x0 /* rgmii1_td3 PIN_OUTPUT | MUX_MODE0 */
+			0x25c	0x0 /* rgmii1_td2 PIN_OUTPUT | MUX_MODE0 */
+			0x260	0x0 /* rgmii1_td1 PIN_OUTPUT | MUX_MODE0 */
+			0x264	0x0 /* rgmii1_td0 PIN_OUTPUT | MUX_MODE0 */
+			0x268	0x00040000 /* rgmii1_rclk PIN_INPUT | MUX_MODE0 */
+			0x26c	0x00040000 /* rgmii1_rctl PIN_INPUT | MUX_MODE0 */
+			0x270	0x00040000 /* rgmii1_rd3 PIN_INPUT | MUX_MODE0 */
+			0x274	0x00040000 /* rgmii1_rd2 PIN_INPUT | MUX_MODE0 */
+			0x278	0x00040000 /* rgmii1_rd1 PIN_INPUT | MUX_MODE0 */
+			0x27c	0x00040000 /* rgmii1_rd0 PIN_INPUT | MUX_MODE0 */
+
+			/* Slave 2 */
+			0x198	0x4 /* rgmii2_tclk PIN_OUTPUT | MUX_MODE4 */
+			0x19c	0x4 /* rgmii2_tctl PIN_OUTPUT | MUX_MODE4 */
+			0x1a0	0x4 /* rgmii2_td3 PIN_OUTPUT | MUX_MODE4 */
+			0x1a4	0x4 /* rgmii2_td2 PIN_OUTPUT | MUX_MODE4 */
+			0x1a8	0x4 /* rgmii2_td1 PIN_OUTPUT | MUX_MODE4 */
+			0x1ac	0x4 /* rgmii2_td0 PIN_OUTPUT | MUX_MODE4 */
+			0x1b0	0x00040004 /* rgmii2_rclk PIN_INPUT | MUX_MODE4 */
+			0x1b4	0x00040004 /* rgmii2_rctl PIN_INPUT | MUX_MODE4 */
+			0x1b8	0x00040004 /* rgmii2_rd3 PIN_INPUT | MUX_MODE4 */
+			0x1bc	0x00040004 /* rgmii2_rd2 PIN_INPUT | MUX_MODE4 */
+			0x1c0	0x00040004 /* rgmii2_rd1 PIN_INPUT | MUX_MODE4 */
+			0x1c4	0x00040004 /* rgmii2_rd0 PIN_INPUT | MUX_MODE4 */
+		>;
+	};
+
+	davinci_mdio_default_pins: pinmux_davinci_mdio_default_pins {
+		pinctrl-single,pins = <
+			/* MDIO */
+			0x23c	0x30000 /* mdio_data PIN_OUTPUT_PULLUP | MUX_MODE0 */
+			0x240	0x70000 /* mdio_clk PIN_INPUT_PULLUP | MUX_MODE0 */
+			>;
+		};
+
 	qspi1_pins: pinmux_qspi1_pins {
 		pinctrl-single,pins = <
 			0x4c (PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
@@ -332,6 +372,27 @@
 	cpu0-supply = <&smps123_reg>;
 };
 
+&gmac {
+	status="okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default_pins>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&davinci_mdio_default_pins>;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <2>;
+	phy-mode = "rgmii-txid";
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <3>;
+	phy-mode = "rgmii-txid";
+};
+
 &qspi {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..daf7d36 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -763,6 +763,54 @@
 			status = "disabled";
 		};
 
+		gmac: ethernet@48484000 {
+			compatible = "ti,cpsw";
+			ti,hwmods = "gmac";
+			cpdma_channels = <8>;
+			ale_entries = <1024>;
+			bd_ram_size = <0x2000>;
+			no_bd_ram = <0>;
+			rx_descs = <64>;
+			mac_control = <0x20>;
+			slaves = <2>;
+			active_slave = <0>;
+			cpts_clock_mult = <0x80000000>;
+			cpts_clock_shift = <29>;
+			reg = <0x48484000 0x800
+				0x48485200 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/*
+			 * rx_thresh_pend
+			 * rx_pend
+			 * tx_pend
+			 * misc_pend
+			 */
+			interrupts = <0 50 0x4>,
+					<0 51 0x4>,
+					<0 52 0x4>,
+					<0 53 0x4>;
+			ranges;
+			status = "disabled";
+
+			davinci_mdio: mdio@48485000 {
+				compatible = "ti,davinci_mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				ti,hwmods = "davinci_mdio";
+				bus_freq = <1000000>;
+				reg = <0x48485000 0x100>;
+			};
+
+			cpsw_emac0: slave@48484200 {
+				mac-address = [ 00 00 00 00 00 00 ];
+			};
+
+			cpsw_emac1: slave@48484300 {
+				mac-address = [ 00 00 00 00 00 00 ];
+			};
+		};
+
 		qspi: qspi@4b300000 {
 			compatible = "ti,dra7xxx-qspi";
 			reg = <0x4b300000 0x100>;
-- 
2.0.1

