From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/6] ARM: dts: am437x-gp-evm: add LCD data
Date: Wed, 21 May 2014 15:50:21 +0300
Message-ID: <1400676625-30078-3-git-send-email-tomi.valkeinen@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40155 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbaEUMu7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:50:59 -0400
In-Reply-To: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sathya Prakash M R <sathyap@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Sathya Prakash M R <sathyap@ti.com>

Add DT data for am437x-gp-evm's LCD panel.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 97 +++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index df8798e8bd25..350e896a0d89 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -53,6 +53,48 @@
 				0x02000069      /* LEFT */
 				0x0201006c>;      /* DOWN */
 		};
+
+	aliases {
+		display0 = &lcd0;
+	};
+
+	lcd0: display {
+		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		/*
+		 * SelLCDorHDMI, LOW to select HDMI. This is not really the
+		 * panel's enable GPIO, but we don't have HDMI driver support nor
+		 * support to switch between two displays, so using this gpio as
+		 * panel's enable should be safe.
+		 */
+		enable-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <210>;
+			hback-porch = <16>;
+			hsync-len = <30>;
+			vback-porch = <10>;
+			vfront-porch = <22>;
+			vsync-len = <13>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -81,6 +123,47 @@
 			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 		>;
 	};
+
+	dss_pins: dss_pins {
+		pinctrl-single,pins = <
+			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x02c (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+			0x03c (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+			0x0a0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			0x0a4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0a8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0ac (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0b0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0b4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0b8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0bc (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0c0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0c4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0c8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0cc (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0d0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0d4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0d8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+			0x0dc (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+			0x0e0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+			0x0e4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+			0x0e8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+			0x0ec (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+
+		>;
+	};
+
+	lcd_pins: lcd_pins {
+		pinctrl-single,pins = <
+			/* GPIO 5_8 to select LCD / HDMI */
+			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+		>;
+	};
 };
 
 &i2c0 {
@@ -125,3 +208,17 @@
 	pinctrl-0 = <&mmc1_pins>;
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
+
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pins>;
+
+	port {
+		dpi_out: endpoint@0 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1

