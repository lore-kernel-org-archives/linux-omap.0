From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 08/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Wed, 6 May 2015 13:08:56 +0300
Message-ID: <1430906938-26128-9-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
nodes required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 15f198e4864d..f1e430507e4f 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -18,6 +18,7 @@
 	aliases {
 		rtc0 = &mcp_rtc;
 		rtc1 = &tps659038_rtc;
+		display0 = &hdmi0;
 	};
 
 	memory {
@@ -102,6 +103,51 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&extcon_usb2_pins>;
 	};
+
+	hdmi0: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tpd12s015_out>;
+			};
+		};
+	};
+
+	tpd12s015: encoder {
+		compatible = "ti,tpd12s015";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpd12s015_pins>;
+
+		gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
+			<&gpio6 28 GPIO_ACTIVE_HIGH>,	/* gpio6_28, LS OE */
+			<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tpd12s015_in: endpoint {
+					remote-endpoint = <&hdmi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tpd12s015_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &dra7_pmx_core {
@@ -121,6 +167,13 @@
 		>;
 	};
 
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			0x408 (PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
+			0x40c (PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
 	i2c3_pins_default: i2c3_pins_default {
 		pinctrl-single,pins = <
 			0x2a4 (PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
@@ -277,6 +330,14 @@
 			0x3e8 (PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_ctsn.gpio7_24 */
 		>;
 	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x3b0 (PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
+			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14)	/* gpio7_12 HPD */
+			0x370 (PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
+		>;
+	};
 };
 
 &i2c1 {
@@ -607,3 +668,23 @@
 		};
        };
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldoln_reg>;
+};
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&ldo3_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&tpd12s015_in>;
+		};
+	};
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
