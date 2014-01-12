From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 08/12] ARM: dts: sbc-t3730: add pinmux for usb hub reset
Date: Sun, 12 Jan 2014 15:22:51 +0200
Message-ID: <1389532975-28281-9-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:48587 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

GPIO167 is used as SB-T35 baseboard USB Hub reset.
Add GPIO167 pinmux.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-sbc-t3730.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 565099c..08e4a70 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -10,6 +10,17 @@
 	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap36xx", "ti,omap3";
 };
 
+&omap3_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sb_t35_usb_hub_pins>;
+
+	sb_t35_usb_hub_pins: pinmux_sb_t35_usb_hub_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2130, PIN_OUTPUT | MUX_MODE4) /* ccdc_wen.gpio_167 - SB-T35 USB HUB RST */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x01000000>,
 		 <4 0 0x2d000000 0x01000000>;
-- 
1.7.5.4

