From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 18/18] ARM: dts: overo: Add support for DVI output
Date: Thu,  9 Jan 2014 17:48:12 +0100
Message-ID: <1389286092-27087-19-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:41109 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755914AbaAIQs6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 11:48:58 -0500
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Summit and Tobi expansion boards have a HDMI connector with a TFP410
encoder. Add a common include file for this configuration, and then
use it for Summit and Tobi.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi | 108 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-summit.dts      |   3 +
 arch/arm/boot/dts/omap3-overo-tobi.dts        |   2 +
 3 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi

diff --git a/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi b/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
new file mode 100644
index 0000000..e4a0fa0
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2014 Florian Vaussard, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * DVI output for some Gumstix Overo boards (Tobi and Summit)
+ */
+
+&omap3_pmx_core {
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
+		>;
+	};
+
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)	/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)	/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)	/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)	/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)	/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)	/* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)	/* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)	/* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)	/* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)	/* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)	/* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)	/* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)	/* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)	/* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)	/* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)	/* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)	/* dss_data17.dss_data17 */
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)	/* dss_data18.dss_data18 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)	/* dss_data19.dss_data19 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)	/* dss_data20.dss_data20 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)	/* dss_data21.dss_data21 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)	/* dss_data22.dss_data22 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)	/* dss_data23.dss_data23 */
+		>;
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	vdds_dsi-supply = <&vpll2>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@0 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		i2c-bus = <&i2c3>;
+
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-summit.dts b/arch/arm/boot/dts/omap3-overo-summit.dts
index fd8b47c..1b8774e 100644
--- a/arch/arm/boot/dts/omap3-overo-summit.dts
+++ b/arch/arm/boot/dts/omap3-overo-summit.dts
@@ -25,3 +25,6 @@
 		};
 	};
 };
+
+#include "omap3-overo-common-dvi.dtsi"
+
diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
index 5072da2..17a85ad 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
@@ -50,3 +50,5 @@
 	};
 };
 
+#include "omap3-overo-common-dvi.dtsi"
+
-- 
1.8.1.2

