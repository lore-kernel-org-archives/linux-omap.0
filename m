From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 4/9] arm: dts: am43x-epos-evm: Add I2C2 data.
Date: Thu, 19 Dec 2013 18:03:36 +0530
Message-ID: <1387456421-21379-5-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51993 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757010Ab3LSMeL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 07:34:11 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add I2C2 dts data.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 0899c5f..d781a69 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -86,6 +86,13 @@
 				0x164 MUX_MODE0         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 			>;
 		};
+
+		i2c2_pins: pinmux_i2c2_pins {
+			pinctrl-single,pins = <
+				0x1c0 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_sda.i2c2_sda */
+				0x1c4 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_scl.i2c2_scl */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -183,6 +190,12 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
 &gpio0 {
 	status = "okay";
 };
-- 
1.7.9.5

