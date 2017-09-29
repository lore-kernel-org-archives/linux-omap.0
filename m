From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for qspi1
Date: Fri, 29 Sep 2017 11:44:21 -0500
Message-ID: <20170929164429.780-4-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f73c22ce4003..2b9ea3810fcc 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -274,7 +274,7 @@
 			>;
 		};
 
-		qspi1_default: qspi1_default {
+		qspi1_pins_default: qspi1_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x87c, PIN_INPUT_PULLUP | MUX_MODE3)
 				AM4372_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE2)
@@ -285,6 +285,17 @@
 			>;
 		};
 
+		qspi1_pins_sleep: qspi1_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x87c, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x888, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x890, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x894, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x898, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x89c, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+			>;
+		};
+
 		pixcir_ts_pins: pixcir_ts_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
@@ -707,8 +718,9 @@
 
 &qspi {
 	status = "disabled";	/* Disable GPMC (NAND) when enabling QSPI */
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi1_default>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qspi1_pins_default>;
+	pinctrl-1 = <&qspi1_pins_sleep>;
 
 	spi-max-frequency = <48000000>;
 	m25p80@0 {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
