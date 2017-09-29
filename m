From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for pixcir_ts
Date: Fri, 29 Sep 2017 11:44:24 -0500
Message-ID: <20170929164429.780-7-afd@ti.com>
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
 arch/arm/boot/dts/am43x-epos-evm.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 822e54cffd29..9c4ac6f715ec 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -323,12 +323,18 @@
 			>;
 		};
 
-		pixcir_ts_pins: pixcir_ts_pins {
+		pixcir_ts_pins_default: pixcir_ts_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
 			>;
 		};
 
+		pixcir_ts_pins_sleep: pixcir_ts_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x844, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
+			>;
+		};
+
 		hdq_pins: pinmux_hdq_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0xa34, PIN_INPUT_PULLUP | MUX_MODE1)    /* cam1_wen.hdq_gpio */
@@ -538,8 +544,10 @@
 
 	pixcir_ts@5c {
 		compatible = "pixcir,pixcir_tangoc";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pixcir_ts_pins>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pixcir_ts_pins_default>;
+		pinctrl-1 = <&pixcir_ts_pins_sleep>;
+
 		reg = <0x5c>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
