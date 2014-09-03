From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: dts: dra7-evm: Fix i2c3 pinmux and frequency
Date: Wed, 3 Sep 2014 14:17:31 +0300
Message-ID: <1409743052-632-2-git-send-email-rogerq@ti.com>
References: <1409743052-632-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50922 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbaICLSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 07:18:10 -0400
In-Reply-To: <1409743052-632-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

The I2C3 pins are taken from pads E21 (GPIO6_14) and
F20 (GPIO6_15). Use the right pinmux register and mode.

Also set the I2C3 bus frequency to a safer 400KHz than
3.4Mhz.

CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 50f8022..42f5bc9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -43,8 +43,8 @@
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0x410 (PIN_INPUT | MUX_MODE0) /* i2c3_sda */
-			0x414 (PIN_INPUT | MUX_MODE0) /* i2c3_scl */
+			0x288 (PIN_INPUT | MUX_MODE9) /* gpio6_14.i2c3_sda */
+			0x28c (PIN_INPUT | MUX_MODE9) /* gpio6_15.i2c3_scl */
 		>;
 	};
 
@@ -284,7 +284,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
-	clock-frequency = <3400000>;
+	clock-frequency = <400000>;
 };
 
 &mcspi1 {
-- 
1.8.3.2

