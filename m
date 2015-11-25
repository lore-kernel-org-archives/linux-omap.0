From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 18/18] ARM: am57xx: sbc-am57x: dts: add HDMI support
Date: Wed, 25 Nov 2015 08:39:50 +0200
Message-ID: <1448433590-1399-19-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add HDMI video output support.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 13555aa..4b29223 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		display0 = &lcd0;
+		display1 = &hdmi;
 	};
 };
 
@@ -61,6 +62,19 @@
 			DRA7XX_CORE_IOPAD(0x3564, PIN_OUTPUT | MUX_MODE14)      /* vin2a_vsync0.gpio4_0 */
 		>;
 	};
+
+	hdmi_pins: pinmux_hdmi_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1)	/* i2c2_sda.hdmi1_ddc_scl */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1)	/* i2c2_scl.hdmi1_ddc_sda */
+		>;
+	};
+
+	hdmi_conn_pins: pinmux_hdmi_conn_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT | MUX_MODE14)	/* spi1_cs2.gpio7_12 */
+		>;
+	};
 };
 
 &uart3 {
@@ -136,3 +150,30 @@
 		};
 	};
 };
+
+&hdmi {
+	status = "ok";
+	vdda-supply = <&ldo4_reg>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+		};
+	};
+};
+
+&hdmi_conn {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_conn_pins>;
+
+	hpd-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+
+	port {
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&hdmi_out>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
