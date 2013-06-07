From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V3 3/4] ARM: dts: omap5-uevm: Add LED support for uEVM blue LED
Date: Fri, 7 Jun 2013 18:52:49 +0530
Message-ID: <1370611370-14715-4-git-send-email-r.sricharan@ti.com>
References: <1370611370-14715-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33850 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab3FGNXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 09:23:32 -0400
In-Reply-To: <1370611370-14715-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, r.sricharan@ti.com, tony@atomide.com, b-cousson@ti.com, Dan Murphy <dmurphy@ti.com>

From: Dan Murphy <dmurphy@ti.com>

Add support for blue LED 1 off of GPIO 153.
Make the LED a heartbeat LED
Configure the MUX for GPIO output.

Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
[Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index a31e42f..6e8bb86 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -59,6 +59,15 @@
 		reset-supply = <&hsusb3_reset>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		led@1 {
+			label = "omap5:blue:usr1";
+			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>; /* gpio5_153 D1 LED */
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
 };
 
 &omap5_pmx_core {
@@ -70,6 +79,7 @@
 			&mcbsp1_pins
 			&mcbsp2_pins
 			&usbhost_pins
+			&led_gpio_pins
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -168,6 +178,12 @@
 			0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 ETH_NRESET */
 		>;
 	};
+
+	led_gpio_pins: pinmux_led_gpio_pins {
+		pinctrl-single,pins = <
+			0x196 (PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 */
+		>;
+	};
 };
 
 &omap5_pmx_wkup {
-- 
1.7.9.5

