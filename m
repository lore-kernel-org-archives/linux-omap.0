From: Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] am335x-evm: add bluetooth support
Date: Sun,  3 May 2015 15:19:29 +0300
Message-ID: <1430655569-27849-2-git-send-email-eyalr@ti.com>
References: <1430655569-27849-1-git-send-email-eyalr@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430655569-27849-1-git-send-email-eyalr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>

uart1 is used for shared transport (used for multiplexing
bluetooth and nfc data). add the needed muxes and definitions.

Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evm.dts |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0f398fa..5968cde 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -135,6 +135,18 @@
 		};
 	};
 
+	kim {
+		compatible = "kim";
+		nshutdown_gpio = <117>; /* Bank3, pin21 */
+		dev_name = "/dev/ttyS1";
+		flow_cntrl = <1>;
+		baud_rate = <3000000>;
+	};
+
+	btwilink {
+		compatible = "btwilink";
+	};
+
 	sound {
 		compatible = "ti,da830-evm-audio";
 		ti,model = "AM335x-EVM";
@@ -191,6 +203,15 @@
 		>;
 	};
 
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+		>;
+	};
+
 	clkout2_pin: pinmux_clkout2_pin {
 		pinctrl-single,pins = <
 			0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
@@ -357,6 +378,13 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
