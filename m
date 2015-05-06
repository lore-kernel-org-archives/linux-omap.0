From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 07/10] arm/dts: dra72-evm.dts: add HDMI
Date: Wed, 6 May 2015 13:08:55 +0300
Message-ID: <1430906938-26128-8-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

DRA72 EVM has a HDMI output. This patch adds the device tree nodes
required for HDMI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/dra72-evm.dts | 110 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ce0390f081d9..4e1b60581782 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -19,6 +19,10 @@
 		reg = <0x80000000 0x40000000>; /* 1024 MB */
 	};
 
+	aliases {
+		display0 = &hdmi0;
+	};
+
 	evm_3v3: fixedregulator-evm_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
@@ -35,6 +39,51 @@
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
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
+		gpios = <&pcf_hdmi 4 GPIO_ACTIVE_HIGH>,	/* P4, CT CP HPD */
+			<&pcf_hdmi 5 GPIO_ACTIVE_HIGH>,	/* P5, LS OE */
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
@@ -45,6 +94,13 @@
 		>;
 	};
 
+	i2c5_pins: pinmux_i2c5_pins {
+		pinctrl-single,pins = <
+			0x2b4 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
+			0x2b8 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
+		>;
+	};
+
 	nand_default: nand_default {
 		pinctrl-single,pins = <
 			0x0	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
@@ -142,6 +198,19 @@
 			0xb8 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
 		>;
 	};
+
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			0x408 (PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
+			0x40c (PIN_INPUT | MUX_MODE1) /* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpio7_12 HPD */
+		>;
+	};
 };
 
 &i2c1 {
@@ -277,6 +346,27 @@
 	};
 };
 
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+
+	pcf_hdmi: pcf8575@26 {
+		compatible = "nxp,pcf8575";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/*
+		 * initial state is used here to keep the mdio interface
+		 * selected on RU89 through SEL_VIN4_MUX_S0, VIN2_S1 and
+		 * VIN2_S0 driven high otherwise Ethernet stops working
+		 * VIN6_SEL_S0 is low, thus selecting McASP3 over VIN6
+		 */
+		lines-initial-states = <0x0f2b>;
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
@@ -566,3 +656,23 @@
 		};
 	};
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldo5_reg>;
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
