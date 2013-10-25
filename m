From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] ARM: dts: omap4-sdp: add LCD pinmuxing
Date: Fri, 25 Oct 2013 13:07:37 +0300
Message-ID: <1382695658-18757-2-git-send-email-tomi.valkeinen@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40333 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab3JYKIQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 06:08:16 -0400
In-Reply-To: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add pinmuxing for the LCD panels.

Both panels have a reset GPIO, but the second one has some extra
complexity: some boards have a PicoDLP projector, which shares resources
with the LCD2. We don't currently support switching between the PicoDL
and the LCD2, so we use pin pull-ups and pull-downs to select the LCD2.

GPIO40 is pulled down, which disables the PicoDLP power. GPIO59 is
pulled up, which selects the LCD2.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..ed14a7a 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -166,6 +166,8 @@
 			&mcbsp2_pins
 			&dss_hdmi_pins
 			&tpd12s015_pins
+			&lcd1_pins
+			&lcd2_pins
 	>;
 
 	uart2_pins: pinmux_uart2_pins {
@@ -268,6 +270,25 @@
 		>;
 	};
 
+	lcd1_pins: pinmux_lcd1_pins {
+		pinctrl-single,pins = <
+			0x52 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_102 */
+		>;
+	};
+
+	/*
+	 * GPIO 59 is used to switch between LCD2 and PicoDLP. We don't support
+	 * the switching, so set the pin to PULLUP which enables the LCD2.
+	 * GPIO 40 enables power to PicoDLP. Use PULLDOWN to disable power.
+	 */
+	lcd2_pins: pinmux_lcd2_pins {
+		pinctrl-single,pins = <
+			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
+			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
+			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
+		>;
+	};
+
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
-- 
1.8.1.2

