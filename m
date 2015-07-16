From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 2/2] ARM: dts: Add phyBOARD-WEGA-AM335x rdk
Date: Thu, 16 Jul 2015 10:30:49 +0200
Message-ID: <1437035449-26956-2-git-send-email-t.remmet@phytec.de>
References: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

phyBOARD-WEGA-AM335x represents a direct soldered
combination of a phyCORE-AM335x SoM and carrier board.

Different kind of SoM options can be connected to
the wega carrier board. So we created a separate
wega dtsi file. The final dts contains the actual
SoM on the carrier board.

WEGA carrier board features:
* ETH phy on carrier board: 1x MII
* 1x CAN
* 2x UART
* USB0 (device)
* USB1 (host)
* mSD slot

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/am335x-wega-rdk.dts              |  22 +++
 arch/arm/boot/dts/am335x-wega.dtsi                 | 151 +++++++++++++++++++++
 4 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-wega-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-wega.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 4f6a82c..9f4e513 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -135,6 +135,9 @@ Boards:
 - AM335X OrionLXm : Substation Automation Platform
   compatible = "novatech,am335x-lxm", "ti,am33xx"
 
+- AM335X phyBOARD-WEGA: Single Board Computer dev kit
+  compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx"
+
 - OMAP5 EVM : Evaluation Module
   compatible = "ti,omap5-evm", "ti,omap5"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a..b6393df 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -438,7 +438,8 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
 	am335x-lxm.dtb \
-	am335x-chiliboard.dtb
+	am335x-chiliboard.dtb \
+	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
diff --git a/arch/arm/boot/dts/am335x-wega-rdk.dts b/arch/arm/boot/dts/am335x-wega-rdk.dts
new file mode 100644
index 0000000..6431b7d
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega-rdk.dts
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2015 Phytec Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "am335x-phycore-som.dtsi"
+#include "am335x-wega.dtsi"
+
+/* SoM */
+&i2c_eeprom {
+	status = "okay";
+};
+
+&i2c_rtc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
new file mode 100644
index 0000000..5e541bd
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2015 Phytec Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	model = "Phytec AM335x phyBOARD-WEGA";
+	compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx";
+
+};
+
+/* CAN Busses */
+&am33xx_pinmux {
+	dcan1_pins: pinmux_dcan1 {
+		pinctrl-single,pins = <
+			0x168 (PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			0x16c (PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+		>;
+	};
+};
+
+&dcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins>;
+	status = "okay";
+};
+
+/* Ethernet */
+&am33xx_pinmux {
+	ethernet1_pins: pinmux_ethernet1 {
+		pinctrl-single,pins = <
+			0x40 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			0x48 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			0x4c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			0x50 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			0x54 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			0x74 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+		>;
+	};
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "mii";
+	dual_emac_res_vlan = <2>;
+};
+
+&mac {
+	slaves = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet0_pins &ethernet1_pins>;
+	dual_emac = <1>;
+};
+
+/* MMC */
+&am33xx_pinmux {
+	mmc1_pins: pinmux_mmc1 {
+		pinctrl-single,pins = <
+			0x0F0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			0x0F4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			0x0F8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			0x0FC (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			0x160 (PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+		>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+/* UARTs */
+&am33xx_pinmux {
+	uart0_pins: pinmux_uart0 {
+		pinctrl-single,pins = <
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
+			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart1_rtsn.uart1_rtsn */
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+/* USB */
+&cppi41dma {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb1_phy {
+	status = "okay";
+};
-- 
1.9.1
