From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
Date: Thu, 2 Jul 2015 14:58:05 +0300
Message-ID: <1435838286-30491-2-git-send-email-peter.ujfalusi@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

When McASP is not in use the pins can be put to sleep mode to conserve
power.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
