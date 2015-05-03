From: Eyal Reizer <eyalreizer@gmail.com>
Subject: [PATCH 1/2] am335x-evm: add mmc3 and wlan definitions to dts
Date: Sun,  3 May 2015 15:19:28 +0300
Message-ID: <1430655569-27849-1-git-send-email-eyalr@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37883 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbECMTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 May 2015 08:19:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Eyal Reizer <eyalr@ti.com>, Arik Nemtsov <arik@wizery.com>, Eliad Peller <eliad@wizery.com>

This includes the wlan regulator, pinmux, DMA
and wlcore bindings.

Signed-off-by: Arik Nemtsov <arik@wizery.com>
Signed-off-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 6634251..0f398fa 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "TI AM335x EVM";
@@ -38,6 +39,20 @@
 		regulator-boot-on;
 	};
 
+	wlan_en_reg: fixedregulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		/* WLAN_EN GPIO for this board - Bank1, pin16 */
+		gpio = <&gpio1 16 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	matrix_keypad: matrix_keypad@0 {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
@@ -266,6 +281,25 @@
 		>;
 	};
 
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			0x44 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0, INPUT_PULLUP | MODE3 */
+			0x48 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1, INPUT_PULLUP | MODE3 */
+			0x4C (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2, INPUT_PULLUP | MODE3 */
+			0x78 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3, INPUT_PULLUP | MODE3 */
+			0x88 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd, INPUT_PULLUP | MODE3 */
+			0x8C (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk, INPUT_PULLUP | MODE3 */
+		>;
+	};
+
+	wlan_pins: pinmux_wlan_pins {
+		pinctrl-single,pins = <
+			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			0x19C (PIN_INPUT | MUX_MODE7)		/* mcasp0_ahclkr.gpio3_17 */
+			0x1AC (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahclkx.gpio3_21 */
+		>;
+	};
+
 	lcd_pins_s0: lcd_pins_s0 {
 		pinctrl-single,pins = <
 			0x20 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
@@ -665,6 +699,37 @@
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
 
+&mmc3 {
+	/* these are on the crossbar and are outlined in the
+	   xbar-event-map element */
+	dmas = <&edma 12
+		&edma 13>;
+	dma-names = "tx", "rx";
+	status = "okay";
+	vmmc-supply = <&wlan_en_reg>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins &wlan_pins>;
+	ti,non-removable;
+	ti,needs-special-hs-handling;
+	cap-power-off-card;
+	keep-power-in-suspend;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@0 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&edma {
+	ti,edma-xbar-event-map = /bits/ 16 <1 12
+					    2 13>;
+};
+
 &sham {
 	status = "okay";
 };
-- 
1.7.9.5

