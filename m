From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/11] ARM: dts: am43xx-epos-evm: Add default pinmux for unused pins
Date: Fri, 29 Sep 2017 11:44:29 -0500
Message-ID: <20170929164429.780-12-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Give unused pins a power-friendly default pinmux setting.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index e745a038c222..4146dd66ad88 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -148,6 +148,43 @@
 };
 
 &am43xx_pinmux {
+		pinctrl-names = "default";
+		pinctrl-0 = <&unused_pins>;
+
+		unused_pins: unused_pins {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x848, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x850, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x858, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x860, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x864, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x868, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x86c, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x878, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x908, DS0_PIN_INPUT_PULLDOWN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x91c, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x920, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x9e0, DS0_PIN_INPUT_PULLDOWN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA0c, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA38, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA3c, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA40, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA44, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA48, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA4c, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA50, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA54, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA58, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA5c, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA60, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA64, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0xA68, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA6C, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA74, DS0_PIN_INPUT_PULLDOWN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0xA78, DS0_PIN_INPUT | PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
 				/* Slave 1 */
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
