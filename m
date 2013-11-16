From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 06/11] ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
Date: Sat, 16 Nov 2013 14:23:39 +0100
Message-ID: <1384608224-9452-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60361 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3KPNZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:25:00 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@gmail.com>

Enable the hdmi output and the LCD Controller on IGEP AQUILA. Also
configure the correct pinmux for output of video data from the SoC
to the HDMI encoder.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/am335x-base0033.dts | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index b4f95c2..3a97613 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -13,4 +13,51 @@
 / {
 	model = "IGEP COM AM335x on AQUILA Expansion";
 	compatible = "isee,am335x-base0033", "isee,am335x-igep0033", "ti,am33xx";
+
+	hdmi {
+		compatible = "ti,tilcdc,slave";
+		i2c = <&i2c0>;
+		pinctrl-names = "default", "off";
+		pinctrl-0 = <&nxp_hdmi_pins>;
+		pinctrl-1 = <&nxp_hdmi_off_pins>;
+		status = "okay";
+	};
+};
+
+&am33xx_pinmux {
+	nxp_hdmi_pins: pinmux_nxp_hdmi_pins {
+		pinctrl-single,pins = <
+			0x1b0 (PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0 */
+			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1 */
+			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2 */
+			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3 */
+			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4 */
+			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5 */
+			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6 */
+			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7 */
+			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8 */
+			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9 */
+			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10 */
+			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11 */
+			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12 */
+			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13 */
+			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14 */
+			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15 */
+			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync */
+			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync */
+			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk */
+			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en */
+		>;
+	};
+	nxp_hdmi_off_pins: pinmux_nxp_hdmi_off_pins {
+		pinctrl-single,pins = <
+			0x1b0 (PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
+		>;
+	};
 };
+
+&lcdc {
+	status = "okay";
+};
+
-- 
1.8.4.2

