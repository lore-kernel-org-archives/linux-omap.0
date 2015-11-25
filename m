From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 16/18] ARM: am57xx: sbc-am57x: dts: add LCD support
Date: Wed, 25 Nov 2015 08:39:48 +0200
Message-ID: <1448433590-1399-17-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Startek-kd050c 800x480 LCD panel timings are described in
compulab-sb-som.dtsi.

Add appropriate DT endpoints to connect DPI output and LCD.

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 8b7c0b5..13555aa 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -15,6 +15,10 @@
 / {
 	model = "CompuLab CL-SOM-AM57x on SB-SOM-AM57x";
 	compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
+
+	aliases {
+		display0 = &lcd0;
+	};
 };
 
 &dra7_pmx_core {
@@ -51,6 +55,12 @@
 			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT| MUX_MODE10)	/* mcasp1_axr1.i2c5_scl */
 		>;
 	};
+
+	lcd_pins_default: lcd_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3564, PIN_OUTPUT | MUX_MODE14)      /* vin2a_vsync0.gpio4_0 */
+		>;
+	};
 };
 
 &uart3 {
@@ -98,3 +108,31 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&dss {
+	status = "ok";
+
+	vdda_video-supply = <&ldoln_reg>;
+
+	port {
+		dpi_lcd_out: endpoint@0 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&lcd0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_pins_default>;
+
+	enable-gpios = <&pca9555 14 GPIO_ACTIVE_HIGH
+			&gpio4 0 GPIO_ACTIVE_HIGH>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_lcd_out>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
