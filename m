From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Sat,  4 Mar 2017 21:43:59 -0800
Message-ID: <20170305054359.8293-7-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The LCD panel on droid 4 is a command mode LCD. The binding follows
the standard omapdrm binding and the changes needed for omapdrm command
mode panels are posted separately.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -17,6 +17,11 @@
 		stdout-path = &uart3;
 	};
 
+	aliases {
+		display0 = &lcd0;
+		display1 = &hdmi0;
+	};
+
 	/*
 	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
 	 * then 1023 - 1024 seems to contain mbm. For SRAM, see the notes
@@ -66,6 +71,17 @@
 		regulator-always-on;
 	};
 
+	/* LCD regulator from sw5 source */
+	lcd_regulator: regulator-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd";
+		regulator-min-microvolt = <5050000>;
+		regulator-max-microvolt = <5050000>;
+		gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;	/* gpio96 */
+		enable-active-high;
+		vin-supply = <&sw5>;
+	};
+
 	/* This is probably coming straight from the battery.. */
 	wl12xx_vmmc: regulator-wl12xx {
 		compatible = "regulator-fixed";
@@ -111,6 +127,50 @@
 	};
 };
 
+&dsi1 {
+	status = "okay";
+	vdd-supply = <&vcsi>;
+
+	port {
+		dsi1_out_ep: endpoint {
+			remote-endpoint = <&lcd0_in>;
+			lanes = <0 1 2 3 4 5>;
+		};
+	};
+
+	lcd0: display {
+		compatible = "panel-dsi-cm";
+		label = "lcd0";
+		vddi-supply = <&lcd_regulator>;
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;	/* gpio101 */
+
+		panel-timing {
+			clock-frequency = <0>;		/* Calculated by dsi */
+
+			hback-porch = <2>;
+			hactive = <540>;
+			hfront-porch = <0>;
+			hsync-len = <2>;
+
+			vback-porch = <1>;
+			vactive = <960>;
+			vfront-porch = <0>;
+			vsync-len = <1>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd0_in: endpoint {
+				remote-endpoint = <&dsi1_out_ep>;
+			};
+		};
+	};
+};
+
 /* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
 &gpmc {
 	status = "disabled";
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
