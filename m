From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 3/4] ARM: dts: omap3-pandora: add DM3730 1 GHz version
Date: Thu, 12 Feb 2015 14:03:45 +0100
Message-ID: <1423746226-700-4-git-send-email-marek@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:63873 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbbBLNER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2015 08:04:17 -0500
In-Reply-To: <1423746226-700-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, marek@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-1ghz.dts | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts

diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
new file mode 100644
index 0000000..6286f41
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2015
+ *   Nikolaus Schaller <hns@goldelico.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * device tree for OpenPandora 1GHz with DM3730
+ */
+
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+#include "omap3-pandora-common.dtsi"
+
+/ {
+	model = "Pandora Handheld Console 1GHz";
+
+	compatible = "ti,omap36xx", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusb2_2_pins
+		&control_pins
+	>;
+
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+		>;
+	};
+
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
+			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_ctl.sdmmc3_cmd */
+			OMAP3630_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
+			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
+			OMAP3630_CORE2_IOPAD(0x25e6, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d5.sdmmc3_dat1 */
+			OMAP3630_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
+		>;
+	};
+
+	control_pins: pinmux_control_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25dc, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* etk_d0.gpio_14 =  HP_SHUTDOWN */
+			OMAP3630_CORE2_IOPAD(0x25de, PIN_OUTPUT | MUX_MODE4)		/* etk_d1.gpio_15 =  BT_SHUTDOWN */
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 =  RESET_USB_HOST */
+			OMAP3630_CORE2_IOPAD(0x25ea, PIN_INPUT_PULLUP | MUX_MODE4)	/* etk_d7.gpio_21 =  WIFI IRQ */
+			OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)		/* etk_d8.gpio_22 =  MSECURE */
+			OMAP3630_CORE2_IOPAD(0x25ee, PIN_OUTPUT | MUX_MODE4)		/* etk_d9.gpio_23 =  WIFI_POWER */
+		>;
+	};
+};
-- 
1.9.1

