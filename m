From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 05/11] ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
Date: Sat, 16 Nov 2013 14:23:38 +0100
Message-ID: <1384608224-9452-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60353 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3KPNY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:24:58 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 has a TFP410 DPI-to-DVI encoder attached to OMAP's
Display SubSystem (DSS).

Add mux setup for DSS pins and also for the GPIO 170 pin that
is used to ensure that the DVI-D is powered down on power up.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 33ce123..b9a9e17 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -67,6 +67,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <
 		&hsusbb1_pins
+		&tfp410_pins
+		&dss_pins
 	>;
 
 	hsusbb1_pins: pinmux_hsusbb1_pins {
@@ -85,6 +87,45 @@
 			0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
 		>;
 	};
+
+	tfp410_pins: tfp410_dvi_pins {
+		pinctrl-single,pins = <
+			0x196 (PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
+		>;
+	};
+
+	dss_pins: pinmux_dss_dvi_pins {
+		pinctrl-single,pins = <
+			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+			0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
+			0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
+			0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
+			0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
+			0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
+			0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
+			0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+			0x0d0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
+			0x0d2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
+			0x0d4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
+			0x0d6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
+			0x0d8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
+			0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
+		>;
+	};
 };
 
 &leds_pins {
-- 
1.8.4.2

