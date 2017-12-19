From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: am335x-boneblue: enable usarts
Date: Tue, 19 Dec 2017 16:32:41 -0600
Message-ID: <20171219223242.21386-2-robertcnelson@gmail.com>
References: <20171219223242.21386-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219223242.21386-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

BeagleBone Blue: usarts: enable all the dedicated usart connectors.

DSM2/uart4: on the Blue, this is a recieve only interface.

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
CC: Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index c5820919e709..ad988e8b8427 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -159,6 +159,7 @@
 		>;
 	};
 
+	/* UT0 */
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* (E15) uart0_rxd.uart0_rxd */
@@ -166,6 +167,37 @@
 		>;
 	};
 
+	/* UT1 */
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* (D16) uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* (D15) uart1_txd.uart1_txd */
+		>;
+	};
+
+	/* GPS */
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
+		>;
+	};
+
+	/* DSM2 */
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
+		>;
+	};
+
+	/* UT5 */
+	uart5_pins: pinmux_uart5_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8C4, PIN_INPUT_PULLUP | MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
+			AM33XX_IOPAD(0x8C0, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
@@ -229,6 +261,34 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_pins>;
+
+	status = "okay";
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
