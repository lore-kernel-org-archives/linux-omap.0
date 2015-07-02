From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 19/20] ARM: DTS: am335x-evm: Add sleep pin settings for mcasp1
Date: Thu, 2 Jul 2015 17:06:34 +0300
Message-ID: <1435845995-19085-20-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

When McASP is not in use the pins can be put to sleep mode to conserve
power.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 4db03859105a..d4783e0a96f2 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -351,6 +351,15 @@
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
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
 			0x168 (PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
@@ -575,8 +584,9 @@
 #include "tps65910.dtsi"
 
 &mcasp1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-1 = <&mcasp1_pins_sleep>;
 
 	status = "okay";
 
-- 
2.4.5
