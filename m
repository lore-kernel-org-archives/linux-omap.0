From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 3/3] ARM: dts: omap3-igep0030: add mux conf for GPIO LED
Date: Thu, 20 Jun 2013 16:42:32 +0200
Message-ID: <1371739352-19670-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:32840 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896Ab3FTOmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 10:42:43 -0400
In-Reply-To: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEP COM MOdule has a GPIO LED connected to OMAP
pins. Configure this pin as output GPIO.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0030.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 644d053..eee3c63 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -16,7 +16,10 @@
 	compatible = "isee,omap3-igep0030", "ti,omap3";
 
 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins>;
 		compatible = "gpio-leds";
+
 		boot {
 			 label = "omap3:green:boot";
 			 gpios = <&twl_gpio 13 GPIO_ACTIVE_LOW>;
@@ -43,6 +46,12 @@
 	};
 };
 
+&leds_pins {
+	pinctrl-single,pins = <
+		0x5b0 (PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
+	>;
+};
+
 &gpmc {
 	ranges = <0 0 0x00000000 0x20000000>;
 
-- 
1.7.7.6

