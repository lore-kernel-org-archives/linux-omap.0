From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/3] ARM: dts: am43x-epos-evm: add SD card hotplug support
Date: Fri, 27 Dec 2013 21:59:06 +0530
Message-ID: <1388161746-24179-4-git-send-email-balajitk@ti.com>
References: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3L0Q3S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Dec 2013 11:29:18 -0500
In-Reply-To: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Balaji T K <balajitk@ti.com>

Add card detect gpio for SD card slot and include dt gpio header.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |    1 +
 arch/arm/boot/dts/am43x-epos-evm.dts |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c6bd4d9..b75dd40 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..bad4457 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -79,6 +79,12 @@
 				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
+
+		mmc1_pins: pinmux_mmc1_pins {
+			pinctrl-single,pins = <
+				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -119,6 +125,9 @@
 	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
 
 &mac {
-- 
1.7.5.4

