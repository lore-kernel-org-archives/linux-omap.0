From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/3] arm: dts: Add Siemens Draco SOM dtsi
Date: Wed,  5 Feb 2014 13:12:40 +0100
Message-ID: <1391602361-2666-2-git-send-email-sr@denx.de>
References: <1391602361-2666-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.182]:29266 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaBEMMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 07:12:38 -0500
In-Reply-To: <1391602361-2666-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lukas Stockmann <lukas.stockmann@siemens.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>

This patch adds support for the Siemens Draco SOM (System On Module) which
is used by multiple Siemens boards. Support for one is posted in this
series as well, the dxr2-e.

This SOM is based on the TI AM3352 with the following configuration:

- CPU: AM3352BZCEA30
- RAM: 128MB DDR3@303MHz
- NAND FLASH: 256MB
- RTC: disabled via hw wiring (registers not available!)

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-draco.dtsi | 163 ++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-draco.dtsi

diff --git a/arch/arm/boot/dts/am335x-draco.dtsi b/arch/arm/boot/dts/am335x-draco.dtsi
new file mode 100644
index 0000000..88b414a
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-draco.dtsi
@@ -0,0 +1,163 @@
+/*
+ * Common support for Siemens Draco SOM (AM335x based)
+ *
+ * Copyright (C) 2013,2014 - Stefan Roese <sr@denx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x08000000>; /* 128 MB */
+	};
+
+	am33xx_pinmux: pinmux@44e10800 {
+		i2c0_pins: pinmux_i2c0_pins {
+			pinctrl-single,pins = <
+				0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			>;
+		};
+
+		uart0_pins: pinmux_uart0_pins {
+			pinctrl-single,pins = <
+				0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+				0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			>;
+		};
+
+		nandflash_pins: nandflash_pins {
+			pinctrl-single,pins = <
+				0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+				0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+				0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+				0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+				0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+				0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+				0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+				0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+				0x74 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			>;
+		};
+	};
+
+	ocp {
+		uart0: serial@44e09000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+			status = "okay";
+		};
+
+		i2c0: i2c@44e0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+
+			status = "okay";
+			clock-frequency = <400000>;
+
+			eeprom: eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+				pagesize = <64>;
+			};
+		};
+
+		musb: usb@47400000 {
+			status = "okay";
+
+			control@44e10000 {
+				status = "okay";
+			};
+
+			usb-phy@47401300 {
+				status = "okay";
+			};
+
+			usb-phy@47401b00 {
+				status = "okay";
+			};
+
+			usb@47401000 {
+				status = "okay";
+			};
+
+			usb@47401800 {
+				status = "okay";
+				dr_mode = "host";
+			};
+
+			dma-controller@07402000  {
+				status = "okay";
+			};
+		};
+	};
+};
+
+&timer3 {
+	status = "disabled";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins>;
+
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <8>;
+		ti,nand-ecc-opt = "bch8";
+		gpmc,device-nand = "true";
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		elm_id = <&elm>;
+	};
+};
+
+/* disable the RTC node as its not accessible on the draco/dxr2 board */
+&rtc {
+	status = "disabled";
+	ti,hwmods = "disabled";
+};
-- 
1.8.5.3

