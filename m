From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 3/4] ARM: dts: omap5-uevm: Add LED support for uEVM blue LED
Date: Wed, 5 Jun 2013 12:16:09 +0530
Message-ID: <1370414770-1485-4-git-send-email-r.sricharan@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab3FEGqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 02:46:47 -0400
In-Reply-To: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: r.sricharan@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Dan Murphy <dmurphy@ti.com>

From: Dan Murphy <dmurphy@ti.com>

Add support for blue LED 1 off of GPIO 153.
Make the LED a heartbeat LED
Configure the MUX for GPIO output.

Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
[Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index cf862df..a2aed5b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -66,6 +66,16 @@
 		device = <&hsusb2_phy>;
 		clock-frequency = <19200000>; /* 19.2 MHz */
 	};
+
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
@@ -77,6 +87,7 @@
 			&mcbsp1_pins
 			&mcbsp2_pins
 			&usbhost_pins
+			&led_gpio_pins
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -175,6 +186,12 @@
 			0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 OUTPUT | MODE 6 ETH_NRESET */
 		>;
 	};
+
+	led_gpio_pins: pinmux_led_gpio_pins {
+		pinctrl-single,pins = <
+			0x196 (PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 OUTPUT | MODE6 */
+		>;
+	};
 };
 
 &omap5_pmx_wkup {
-- 
1.7.9.5

