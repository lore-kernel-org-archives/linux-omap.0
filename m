From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for mmc1
Date: Fri, 29 Sep 2017 11:44:25 -0500
Message-ID: <20170929164429.780-8-afd@ti.com>
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
index 9c4ac6f715ec..4d5487b853c3 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -295,12 +295,18 @@
 			>;
 		};
 
-		mmc1_pins: pinmux_mmc1_pins {
+		mmc1_pins_default: pinmux_mmc1_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 			>;
 		};
 
+		mmc1_pins_sleep: pinmux_mmc1_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x960, DS0_PIN_OUTPUT_PULLUP | PIN_INPUT | MUX_MODE7)
+			>;
+		};
+
 		qspi1_pins_default: qspi1_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x87c, PIN_INPUT_PULLUP | MUX_MODE3)
@@ -440,8 +446,9 @@
 	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_sleep>;
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 };
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
