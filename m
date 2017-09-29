From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for ecap0
Date: Fri, 29 Sep 2017 11:44:22 -0500
Message-ID: <20170929164429.780-5-afd@ti.com>
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
 arch/arm/boot/dts/am43x-epos-evm.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 2b9ea3810fcc..8f9c901b0ccd 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -219,12 +219,18 @@
 			>;
 		};
 
-		ecap0_pins: backlight_pins {
+		ecap0_pins_default: backlight_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x964, MUX_MODE0)         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 			>;
 		};
 
+		ecap0_pins_sleep: backlight_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x964, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+			>;
+		};
+
 		i2c2_pins: pinmux_i2c2_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x9c0, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_sda.i2c2_sda */
@@ -680,8 +686,9 @@
 
 &ecap0 {
 		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&ecap0_pins>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ecap0_pins_default>;
+		pinctrl-1 = <&ecap0_pins_sleep>;
 };
 
 &spi0 {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
