From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v3 3/4] ARM: dts: Add VAR-SOM-OM44 WLAN nodes
Date: Mon, 12 May 2014 20:32:02 +0200
Message-ID: <1399919523-20330-4-git-send-email-manabian@gmail.com>
References: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:40348 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaELScu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 14:32:50 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so7887533lbj.10
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 11:32:49 -0700 (PDT)
In-Reply-To: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Both the VAR-STK-OM44 and VAR-DVK-OM44 boards comes with the
WLAN/BT version of the system on module VAR-SOM-OM44.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/omap4-var-dvk-om44.dts       |  1 +
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi | 68 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-var-stk-om44.dts       |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi

diff --git a/arch/arm/boot/dts/omap4-var-dvk-om44.dts b/arch/arm/boot/dts/omap4-var-dvk-om44.dts
index 6138d7eb8efa..458d79fa378b 100644
--- a/arch/arm/boot/dts/omap4-var-dvk-om44.dts
+++ b/arch/arm/boot/dts/omap4-var-dvk-om44.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "omap4-var-som-om44.dtsi"
+#include "omap4-var-som-om44-wlan.dtsi"
 #include "omap4-var-om44customboard.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
new file mode 100644
index 000000000000..cc66af419236
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	/* regulator for wl12xx on sdio4 */
+	wl12xx_vmmc: wl12xx_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_ctrl_pins>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio2 11 0>;	/* gpio 43 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&omap4_pmx_core {
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx.uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+		>;
+	};
+
+	wl12xx_ctrl_pins: pinmux_wl12xx_ctrl_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x062, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a17.gpio_41 (WLAN_IRQ) */
+			OMAP4_IOPAD(0x064, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a18.gpio_42 (BT_EN) */
+			OMAP4_IOPAD(0x066, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 (WLAN_EN) */
+		>;
+	};
+
+	mmc4_pins: pinmux_mmc4_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x154, PIN_INPUT_PULLUP | MUX_MODE1)	/* mcspi4_clk.sdmmc4_clk */
+			OMAP4_IOPAD(0x156, PIN_INPUT_PULLUP | MUX_MODE1)	/* mcspi4_simo.sdmmc4_cmd */
+			OMAP4_IOPAD(0x158, PIN_INPUT_PULLUP | MUX_MODE1)	/* mcspi4_somi.sdmmc4_dat0 */
+			OMAP4_IOPAD(0x15e, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart4_tx.sdmmc4_dat1 */
+			OMAP4_IOPAD(0x15c, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart4_rx.sdmmc4_dat2 */
+			OMAP4_IOPAD(0x15a, PIN_INPUT_PULLUP | MUX_MODE1)	/* mcspi4_cs0.sdmmc4_dat3 */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&mmc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc4_pins>;
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/omap4-var-stk-om44.dts b/arch/arm/boot/dts/omap4-var-stk-om44.dts
index bc5dbc950964..56b64e618608 100644
--- a/arch/arm/boot/dts/omap4-var-stk-om44.dts
+++ b/arch/arm/boot/dts/omap4-var-stk-om44.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "omap4-var-som-om44.dtsi"
+#include "omap4-var-som-om44-wlan.dtsi"
 #include "omap4-var-om44customboard.dtsi"
 
 / {
-- 
1.8.0

