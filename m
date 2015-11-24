From: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 04/14] ARM: am437x: cm-t43: dts: add spi-flash support
Date: Tue, 24 Nov 2015 15:19:05 +0200
Message-ID: <1448371155-17307-5-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448371155-17307-1-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CM-T43 has an on-board 2MB SPI-flash which stores U-Boot and the U-Boot
environment. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 7ef3971..0761383 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -44,6 +44,16 @@
 			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
 		>;
 	};
+
+	spi0_pins: pinmux_spi0_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM4372_IOPAD(0x954, PIN_INPUT | MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM4372_IOPAD(0x958, PIN_OUTPUT | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM4372_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+		>;
+	};
+
 };
 
 &i2c0 {
@@ -146,6 +156,37 @@
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	dmas = <&edma 16
+		&edma 17>;
+	dma-names = "tx0", "rx0";
+
+	flash: w25q64cvzpig@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition@c0000 {
+			label = "uboot environment";
+			reg = <0xc0000 0x40000>;
+		};
+
+		partition@100000 {
+			label = "reserved";
+			reg = <0x100000 0x100000>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
