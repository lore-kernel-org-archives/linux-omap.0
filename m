From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 5/7] ARM: dts: OMAP3-N950: Add Keypad Slide Switch
Date: Sun, 13 Mar 2016 01:06:18 +0100
Message-ID: <1457827580-16919-6-git-send-email-sre@kernel.org>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457827580-16919-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 3dbf9d66bcc1..daa17d20ccf5 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -16,6 +16,28 @@
 / {
 	model = "Nokia N950";
 	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
+
+	keys {
+		compatible = "gpio-keys";
+
+		keypad_slide {
+			label = "Keypad Slide";
+			gpios = <&gpio4 13 GPIO_ACTIVE_LOW>; /* 109 */
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_KEYPAD_SLIDE>;
+			wakeup-source;
+			pinctrl-names = "default";
+			pinctrl-0 = <&keypad_slide_pins>;
+		};
+	};
+};
+
+&omap3_pmx_core {
+	keypad_slide_pins: pinmux_debug_led_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT | MUX_MODE4)       /* cam_d10.gpio_109 */
+		>;
+	};
 };
 
 &i2c2 {
-- 
2.7.0
