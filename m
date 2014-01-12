From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 05/12] ARM: dts: cm-t3x: add gpio-led pinmux
Date: Sun, 12 Jan 2014 15:22:48 +0200
Message-ID: <1389532975-28281-6-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59830 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

GPIO186 is used for the heartbeat led.
Setup the pinmux for the GPIO186.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 842201c..abda493 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -11,6 +11,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&green_led_pins>;
 		ledb {
 			label = "cm-t3x:green";
 			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;  /* gpio186 */
@@ -38,6 +40,12 @@
 			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
 		>;
 	};
+
+	green_led_pins: pinmux_green_led_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21e2, PIN_OUTPUT | MUX_MODE4)	/* sys_clkout2.gpio_186 */
+		>;
+	};
 };
 
 &uart3 {
-- 
1.7.5.4

