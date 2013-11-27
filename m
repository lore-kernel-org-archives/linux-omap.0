From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 4/5] arm: dts: am43x-epos-evm: Add I2C2 data.
Date: Wed, 27 Nov 2013 13:00:46 +0530
Message-ID: <1385537447-6922-5-git-send-email-sourav.poddar@ti.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab3K0HbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 02:31:12 -0500
In-Reply-To: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add I2C2 dts data.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 5521999..7a504d1 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -97,6 +97,13 @@
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
@@ -194,6 +201,12 @@
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
1.7.1

