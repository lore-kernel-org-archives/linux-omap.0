From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Sun,  5 Mar 2017 01:43:09 +0100
Message-ID: <20170305004309.28259-10-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add basic panel support for the Nokia N950. It must be tweaked a
little bit later, since the panel was built into the device
upside-down. Also the first 5 and the last 5 pixels are covered
by plastic.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950.dts | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 646601a3ebd8..1aa4251b39d7 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -51,6 +51,26 @@
 	};
 };
 
+&omap3_pmx_core {
+	dsi_pins: pinmux_dsi_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE1) /* dsi_dx0 - data0+ */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE1) /* dsi_dy0 - data0- */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE1) /* dsi_dx1 - clk+   */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE1) /* dsi_dy1 - clk-   */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE1) /* dsi_dx2 - data1+ */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE1) /* dsi_dy2 - data1- */
+		>;
+	};
+
+	display_pins: pinmux_display_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20ca, PIN_INPUT | MUX_MODE4) /* gpio 62 - display te */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE4) /* gpio 87 - display reset */
+		>;
+	};
+};
+
 &i2c2 {
 	smia_1: camera@10 {
 		compatible = "nokia,smia";
@@ -185,3 +205,72 @@
 	st,max-limit-y = <32>;
 	st,max-limit-z = <32>;
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&vdac>;
+};
+
+&dsi {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dsi_pins>;
+
+	vdd-supply = <&vpll2>;
+
+	port {
+		dsi_out_ep: endpoint {
+			remote-endpoint = <&lcd0_in>;
+			lanes = <2 3 0 1 4 5>;
+		};
+	};
+
+	lcd0: display {
+		compatible = "nokia,himalaya", "panel-dsi-cm";
+		label = "lcd0";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pins>;
+
+		vpnl-supply = <&vmmc2>;
+		vddi-supply = <&vio>;
+
+		reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;	/* 87 */
+		te-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;	/* 62 */
+
+		has-dsi-backlight;
+
+		/* panel is upside-down, 480x464 pixels */
+		/* top and bottom 5 lines are not visible */
+		/* physical dimensions: 48960µm x 88128µm */
+		panel-timing {
+			clock-frequency = <0>;          /* Calculated by dsi */
+
+			hback-porch = <2>;
+			hactive = <480>;
+			hfront-porch = <0>;
+			hsync-len = <2>;
+
+			vback-porch = <1>;
+			vactive = <864>;
+			vfront-porch = <0>;
+			vsync-len = <1>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+
+			/* TODO: rotate panel by 180° */
+			/* TODO: add 5 pixel y-offset and limit vactive to 854 */
+		};
+
+		port {
+			lcd0_in: endpoint {
+				remote-endpoint = <&dsi_out_ep>;
+			};
+		};
+	};
+};
-- 
2.11.0
