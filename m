From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: dts: am43x-epos-evm: Correct Touch controller info
Date: Wed, 30 Apr 2014 15:43:24 +0300
Message-ID: <1398861805-9229-2-git-send-email-rogerq@ti.com>
References: <1398861805-9229-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52763 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933692AbaD3Mnd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 08:43:33 -0400
In-Reply-To: <1398861805-9229-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Fixup Y resolution and add default pin state. Also update
the compatible id.

CC: Benoit Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 167dbc8..3a067e6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -138,6 +138,12 @@
 				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 			>;
 		};
+
+		pixcir_ts_pins: pixcir_ts_pins {
+			pinctrl-single,pins = <
+				0x44 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -226,7 +232,9 @@
 	};
 
 	pixcir_ts@5c {
-		compatible = "pixcir,pixcir_ts";
+		compatible = "pixcir,pixcir_tangoc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pixcir_ts_pins>;
 		reg = <0x5c>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <17 0>;
@@ -234,7 +242,7 @@
 		attb-gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 
 		x-size = <1024>;
-		y-size = <768>;
+		y-size = <600>;
 	};
 };
 
-- 
1.8.3.2

