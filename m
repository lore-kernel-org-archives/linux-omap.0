From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/6] ARM: dts: omap4-droid4: Add HDMI support
Date: Sat,  4 Mar 2017 21:43:58 -0800
Message-ID: <20170305054359.8293-6-tony@atomide.com>
References: <20170305054359.8293-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We can get HDMI working as long as the 5V regulator is on. There is
probably an encoder chip there too, but so far no idea what it might be.
Let's keep the 5V HDMI regulator always enabled for now as otherwise we
cannot detect the monitor properly.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -35,6 +35,37 @@
 		gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;	/* gpio50 */
 	};
 
+	hdmi0: connector {
+		compatible = "hdmi-connector";
+		pinctrl-0 = <&hdmi_hpd_gpio>;
+		pinctrl-names = "default";
+		label = "hdmi";
+		type = "d";
+
+		hpd-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;	/* gpio63 */
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
+	/*
+	 * HDMI 5V regulator probably sourced from battery. Let's keep
+	 * keep this as always enabled for HDMI to work until we've
+	 * figured what the encoder chip is.
+	 */
+	hdmi_regulator: regulator-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio2 27 GPIO_ACTIVE_HIGH>;	/* gpio59 */
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	/* This is probably coming straight from the battery.. */
 	wl12xx_vmmc: regulator-wl12xx {
 		compatible = "regulator-fixed";
@@ -67,6 +98,10 @@
 	};
 };
 
+&dss {
+	status = "okay";
+};
+
 &gpio6 {
 	touchscreen_reset {
 		gpio-hog;
@@ -81,6 +116,20 @@
 	status = "disabled";
 };
 
+&hdmi {
+	status = "okay";
+	pinctrl-0 = <&dss_hdmi_pins>;
+	pinctrl-names = "default";
+	vdda-supply = <&vdac>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+			lanes = <1 0 3 2 5 4 7 6>;
+		};
+	};
+};
+
 &i2c1 {
 	tmp105@48 {
 		compatible = "ti,tmp105";
@@ -249,6 +298,22 @@
 
 &omap4_pmx_core {
 
+	/* hdmi_hpd.gpio_63 */
+	hdmi_hpd_gpio: pinmux_hdmi_hpd_pins {
+		pinctrl-single,pins = <
+                OMAP4_IOPAD(0x098, PIN_INPUT | MUX_MODE3)
+		>;
+	};
+
+	/* hdmi_cec.hdmi_cec, hdmi_scl.hdmi_scl, hdmi_sda.hdmi_sda */
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)
+		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)
+		>;
+	};
+
 	/* gpmc_ncs0.gpio_50 */
 	poweroff_gpio: pinmux_poweroff_pins {
 		pinctrl-single,pins = <
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
