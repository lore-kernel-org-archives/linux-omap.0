From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 3/3] ARM: dts: omap3-pandora: add DM3730 1 GHz version
Date: Tue, 17 Feb 2015 20:52:23 +0100
Message-ID: <1424202743-26387-4-git-send-email-marek@goldelico.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424202743-26387-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, marek@goldelico.com
List-Id: linux-omap@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Added Pandora 1 GHz model which is based on Classic/Rebirth
with following changes:
- upgraded cpu to dm3730 runs on 1GHz
- 512 MiB DDR-333 SDRAM @ 200 MHz

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/omap3-pandora-1ghz.dts | 70 ++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eddbeee..69f3106 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-overo-summit.dtb \
 	omap3-overo-tobi.dtb \
 	omap3-pandora-600mhz.dtb \
+	omap3-pandora-1ghz.dtb \
 	omap3-sbc-t3517.dtb \
 	omap3-sbc-t3530.dtb \
 	omap3-sbc-t3730.dtb \
diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
new file mode 100644
index 0000000..9619a28
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
@@ -0,0 +1,70 @@
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
+			OMAP3630_CORE2_IOPAD(0x25ea, PIN_INPUT | MUX_MODE4)		/* etk_d7.gpio_21 =  WIFI IRQ */
+			OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)		/* etk_d8.gpio_22 =  MSECURE */
+			OMAP3630_CORE2_IOPAD(0x25ee, PIN_OUTPUT | MUX_MODE4)		/* etk_d9.gpio_23 =  WIFI_POWER */
+			OMAP3_WKUP_IOPAD(0x2a54, PIN_INPUT | MUX_MODE4)   		/* reserved.gpio_127 = MMC2_WP */
+			OMAP3_WKUP_IOPAD(0x2a56, PIN_INPUT | MUX_MODE4)   		/* reserved.gpio_126 = MMC1_WP */
+			OMAP3_WKUP_IOPAD(0x2a58, PIN_OUTPUT | MUX_MODE4)   		/* reserved.gpio_128 = LED_MMC1 */
+			OMAP3_WKUP_IOPAD(0x2a5a, PIN_OUTPUT | MUX_MODE4)   		/* reserved.gpio_129 = LED_MMC2 */
+
+		>;
+	};
+};
-- 
1.9.1
