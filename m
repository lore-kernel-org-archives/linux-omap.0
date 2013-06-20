From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/3] ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
Date: Thu, 20 Jun 2013 16:42:31 +0200
Message-ID: <1371739352-19670-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:32836 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab3FTOmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 10:42:42 -0400
In-Reply-To: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 has a number of GPIO LED connected to OMAP
pins. Configure these pins as output GPIO.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e8c4828..51c084e 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -16,7 +16,10 @@
 	compatible = "isee,omap3-igep0020", "ti,omap3";
 
 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins>;
 		compatible = "gpio-leds";
+
 		boot {
 			 label = "omap3:green:boot";
 			 gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
@@ -54,6 +57,14 @@
 	};
 };
 
+&leds_pins {
+	pinctrl-single,pins = <
+		0x5c4 (PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
+		0x5c6 (PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
+		0x5c8 (PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
+	>;
+};
+
 &i2c3 {
 	clock-frequency = <100000>;
 
-- 
1.7.7.6

