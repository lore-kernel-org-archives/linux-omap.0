From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: am43x-epos-evm: Correct Touch controller
 info
Date: Mon, 19 May 2014 11:48:34 +0300
Message-ID: <5379C562.1030106@ti.com>
References: <1398861805-9229-1-git-send-email-rogerq@ti.com> <1398861805-9229-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56753 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbaESIsj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 04:48:39 -0400
In-Reply-To: <1398861805-9229-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

From: Roger Quadros <rogerq@ti.com>

Fixup Y resolution and add default pin state. Also update
the compatible id and bindings for touchscreen size.

CC: Benoit Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 167dbc8..b789e2d 100644
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
@@ -226,15 +232,17 @@
 	};
 
 	pixcir_ts@5c {
-		compatible = "pixcir,pixcir_ts";
+		compatible = "pixcir,pixcir_tangoc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pixcir_ts_pins>;
 		reg = <0x5c>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <17 0>;
 
 		attb-gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 
-		x-size = <1024>;
-		y-size = <768>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
 	};
 };
 
-- 
1.8.3.2


