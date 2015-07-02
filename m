From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 02/20] ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
Date: Thu, 2 Jul 2015 17:06:17 +0300
Message-ID: <1435845995-19085-3-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

When McASP is not in use the pins can be put to sleep mode to conserve
power.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index c17097d2c167..b5de6b0d622c 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -364,6 +364,15 @@
 		>;
 	};
 
+	mcasp1_pins_sleep: mcasp1_pins_sleep {
+		pinctrl-single,pins = <
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
 			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
@@ -640,8 +649,9 @@
 };
 
 &mcasp1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-1 = <&mcasp1_pins_sleep>;
 
 	status = "okay";
 
-- 
2.4.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
