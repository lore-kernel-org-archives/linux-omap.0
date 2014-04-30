From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: AM437x: Add touchscreen support for GP EVM
Date: Wed, 30 Apr 2014 15:43:25 +0300
Message-ID: <1398861805-9229-3-git-send-email-rogerq@ti.com>
References: <1398861805-9229-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52767 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933706AbaD3Mnf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 08:43:35 -0400
In-Reply-To: <1398861805-9229-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Add touchscreen support for AM437x GP EVM using pixcir
touchscreen controller.

CC: Benoit Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index df8798e..bc9889f 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -81,6 +81,12 @@
 			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 		>;
 	};
+
+	pixcir_ts_pins: pixcir_ts_pins {
+		pinctrl-single,pins = <
+			0x264 (PIN_INPUT_PULLUP | MUX_MODE7)  /* spi2_d0.gpio3_22 */
+		>;
+	};
 };
 
 &i2c0 {
@@ -93,6 +99,20 @@
         status = "okay";
         pinctrl-names = "default";
         pinctrl-0 = <&i2c1_pins>;
+
+	pixcir_ts@5c {
+		compatible = "pixcir,pixcir_tangoc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pixcir_ts_pins>;
+		reg = <0x5c>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+
+		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+
+		x-size = <1024>;
+		y-size = <600>;
+	};
 };
 
 &epwmss0 {
-- 
1.8.3.2

