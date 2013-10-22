From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 11/14] DTS: ARM: OMAP3-N900: Mux RX51_LCD_RESET_GPIO in DTS
Date: Wed, 23 Oct 2013 00:49:40 +0200
Message-ID: <1382482183-14426-12-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add RX51_LCD_RESET_GPIO pin mux information to
display.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 999a80c..5afbd28 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -124,6 +124,12 @@
 			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
 		>;
 	};
+
+	display_pins: pinmux_display_pins {
+		pinctrl-single,pins = <
+			0x0d4 (PIN_OUTPUT | MUX_MODE4)		/* RX51_LCD_RESET_GPIO */
+		>;
+	};
 };
 
 &i2c1 {
@@ -361,6 +367,9 @@
 		compatible = "acx565akm";
 		spi-max-frequency = <6000000>;
 		reg = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pins>;
 	};
 };
 
-- 
1.8.4.rc3
