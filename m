From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 26/41] ARM: omap4-sdp.dts: add display information
Date: Tue, 21 Jan 2014 12:56:58 +0200
Message-ID: <1390301833-24944-27-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add DT data for OMAP4 SDP board. The board has the following displays:

lcd0: a command mode DSI panel connected to OMAP DSI1 encoder
lcd1: a command mode DSI panel connected to OMAP DSI2 encoder
hdmi: OMAP HDMI output with TPD12S015 ESD/level shifter

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-sdp.dts | 107 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dbc81fb6ef03..cf9f6cbbd349 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -19,6 +19,12 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
+	aliases {
+		display0 = &lcd0;
+		display1 = &lcd1;
+		display2 = &hdmi0;
+	};
+
 	vdd_eth: fixedregulator-vdd-eth {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_ETH";
@@ -153,6 +159,47 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+			<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+			<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint@0 {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint@0 {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&tpd12s015_out>;
+		};
+	};
 };
 
 &omap4_pmx_core {
@@ -163,8 +210,6 @@
 			&dmic_pins
 			&mcbsp1_pins
 			&mcbsp2_pins
-			&dss_hdmi_pins
-			&tpd12s015_pins
 	>;
 
 	uart2_pins: pinmux_uart2_pins {
@@ -550,3 +595,61 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&dss {
+	status = "ok";
+};
+
+&dsi1 {
+	status = "ok";
+	vdd-supply = <&vcxio>;
+
+	dsi1_out_ep: endpoint {
+		remote-endpoint = <&lcd0_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd0: display {
+		compatible = "tpo,taal", "panel-dsi-cm";
+		label = "lcd0";
+
+		gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
+
+		lcd0_in: endpoint {
+			remote-endpoint = <&dsi1_out_ep>;
+		};
+	};
+};
+
+&dsi2 {
+	status = "ok";
+	vdd-supply = <&vcxio>;
+
+	dsi2_out_ep: endpoint {
+		remote-endpoint = <&lcd1_in>;
+		lanes = <0 1 2 3 4 5>;
+	};
+
+	lcd1: display {
+		compatible = "tpo,taal", "panel-dsi-cm";
+		label = "lcd1";
+
+		gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;	/* 104, reset */
+
+		lcd1_in: endpoint {
+			remote-endpoint = <&dsi2_out_ep>;
+		};
+	};
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&vdac>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+
+	hdmi_out: endpoint {
+		remote-endpoint = <&tpd12s015_in>;
+	};
+};
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
