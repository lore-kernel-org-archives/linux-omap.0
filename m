From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 14/14] ARM: am437x: cm-t43: dts: add lcd support
Date: Tue, 24 Nov 2015 15:19:15 +0200
Message-ID: <1448371155-17307-15-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448371155-17307-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the necessary dss configuration to drive the startek lcd on CompuLab
sbc-t43 single board computer.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
 arch/arm/boot/dts/am437x-sbc-t43.dts | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index b2c42d9..0758094 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -12,6 +12,10 @@
 / {
 	model = "CompuLab CM-T43 on SB-SOM-T43";
 	compatible = "compulab,am437x-sbc-t43","compulab,am437x-cm-t43","ti,am4372","ti,am43";
+
+	aliases {
+		display0 = &lcd0;
+	};
 };
 
 &am43xx_pinmux {
@@ -28,6 +32,41 @@
 		>;
 	};
 
+	dss_pinctrl_default: dss_pinctrl_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE2) /* cam0 hd -> DSS DATA 23 */
+			AM4372_IOPAD(0x9b4, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9b8, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9bc, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9c0, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9c4, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9c8, PIN_OUTPUT_PULLUP | MUX_MODE2)
+			AM4372_IOPAD(0x9cc, PIN_OUTPUT_PULLUP | MUX_MODE2) /* cam1 data 9 -> DSS DATA 16 */
+
+			AM4372_IOPAD(0x8a0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			AM4372_IOPAD(0x8a4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8a8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8ac, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8b8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8bc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8c8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8cc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8d8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM4372_IOPAD(0x8dc, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+			AM4372_IOPAD(0x8e0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+			AM4372_IOPAD(0x8e4, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+			AM4372_IOPAD(0x8e8, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+			AM4372_IOPAD(0x8ec, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			AM4372_IOPAD(0xa20, PIN_OUTPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+
 	uart0_pins_default: uart0_pins_default {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)
@@ -99,6 +138,20 @@
 	wp-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 };
 
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pinctrl_default>;
+
+	port {
+		dpi_lcd_out: endpoint@0 {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_default>;
@@ -114,3 +167,15 @@
 	pinctrl-0 = <&usb2_phy2_default>;
 };
 
+&lcd0 {
+	enable-gpios = <&pca9555 14 GPIO_ACTIVE_HIGH
+			&gpio4 28 GPIO_ACTIVE_HIGH>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_lcd_out>;
+			data-lines = <24>;
+		};
+	};
+};
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
