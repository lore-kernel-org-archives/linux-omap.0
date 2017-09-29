From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for gpmc
Date: Fri, 29 Sep 2017 11:44:23 -0500
Message-ID: <20170929164429.780-6-afd@ti.com>
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
 arch/arm/boot/dts/am43x-epos-evm.dts | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 8f9c901b0ccd..822e54cffd29 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -198,7 +198,7 @@
 			>;
 		};
 
-		nand_flash_x8: nand_flash_x8 {
+		nand_flash_x8_default: nand_flash_x8_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.SELQSPIorNAND/GPIO */
 				AM4372_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
@@ -219,6 +219,27 @@
 			>;
 		};
 
+		nand_flash_x8_sleep: nand_flash_x8_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x840, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x800, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x804, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x808, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x80c, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x810, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x814, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x818, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x81c, DS0_PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x870, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x874, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x87c, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x890, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x894, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x898, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x89c, DS0_PIN_OUTPUT_PULLUP | MUX_MODE7)
+			>;
+		};
+
 		ecap0_pins_default: backlight_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x964, MUX_MODE0)         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
@@ -589,8 +610,9 @@
 
 &gpmc {
 	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_flash_x8>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&nand_flash_x8_default>;
+	pinctrl-1 = <&nand_flash_x8_sleep>;
 	ranges = <0 0 0x08000000 0x01000000>;	/* CS0 space. Min partition = 16MB */
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
