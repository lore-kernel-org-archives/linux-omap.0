From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 02/23] ARM: dts: n950: add display support
Date: Tue,  8 Mar 2016 17:39:34 +0100
Message-ID: <1457455195-1938-3-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950.dts | 71 ++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3=
-n950.dts
index 0885b34d5d7d..41b8fb585272 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -17,6 +17,26 @@
 	compatible =3D "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
 };
=20
+&omap3_pmx_core {
+	dsi_pins: pinmux_dsi_pins {
+		pinctrl-single,pins =3D <
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE1) /* dsi_dx0 - data=
0+ */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE1) /* dsi_dy0 - data=
0- */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE1) /* dsi_dx1 - clk+=
   */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE1) /* dsi_dy1 - clk-=
   */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE1) /* dsi_dx2 - data=
1+ */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE1) /* dsi_dy2 - data=
1- */
+		>;
+	};
+
+	display_pins: pinmux_display_pins {
+		pinctrl-single,pins =3D <
+			OMAP3_CORE1_IOPAD(0x20ca, PIN_INPUT | MUX_MODE4) /* gpio 62 - displ=
ay te */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE4) /* gpio 87 - disp=
lay reset */
+		>;
+	};
+};
+
 &i2c2 {
 	smia_1: camera@10 {
 		compatible =3D "nokia,smia";
@@ -53,3 +73,54 @@
 		};
 	};
 };
+
+&dss {
+	status =3D "ok";
+
+	vdda_video-supply =3D <&vdac>;
+};
+
+&dsi {
+	status =3D "ok";
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&dsi_pins>;
+
+	vdd-supply =3D <&vpll2>;
+
+	port {
+		dsi_out_ep: endpoint {
+			remote-endpoint =3D <&lcd0_in>;
+			lanes =3D <2 3 0 1 4 5>;
+		};
+	};
+
+	lcd0: display {
+		compatible =3D "nokia,himalaya", "panel-dsi-cm";
+		label =3D "lcd0";
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&display_pins>;
+
+		vpnl-supply =3D <&vmmc2>;
+		vddi-supply =3D <&vio>;
+
+		reset-gpios =3D <&gpio3 23 GPIO_ACTIVE_HIGH>;	/* 87 */
+		te-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;	/* 62 */
+
+		has-dsi-backlight;
+
+		/* panel is 480x464 with top and bottom 5 lines not visible */
+		/* physical dimensions: 48960=C2=B5m x 88128=C2=B5m */
+		resolution-x =3D <480>;
+		resolution-y =3D <854>;
+		offset-x =3D <0>;
+		offset-y =3D <5>;
+
+		port {
+			lcd0_in: endpoint {
+				remote-endpoint =3D <&dsi_out_ep>;
+			};
+		};
+	};
+};
--=20
2.7.0
