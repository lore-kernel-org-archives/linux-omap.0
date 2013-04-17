From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ARM: dts: omap4-panda: Add LED support into the panda DTS files
Date: Wed, 17 Apr 2013 14:09:38 -0500
Message-ID: <1366225778-6083-2-git-send-email-dmurphy@ti.com>
References: <1366225778-6083-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366225778-6083-1-git-send-email-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
are different.

Abstract away the pinmux and the LED definitions for the two boards.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/omap4-panda-es.dts |   33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts    |   22 +++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 73bc1a6..42fdd86 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -31,3 +31,36 @@
 		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
 		>;
 };
+
+&leds {
+	compatible = "gpio-leds";
+	heartbeat {
+		label = "pandaboard::status1";
+		gpios = <&gpio4 14 0>;
+		linux,default-trigger = "heartbeat";
+	};
+	mmc {
+		label = "pandaboard::status2";
+		gpios = <&gpio1 8 0>;
+		linux,default-trigger = "gpio";
+	};
+};
+
+&led_gpio_pins {
+	pinctrl-single,pins = <
+		0xb6 0x3	/* gpio_110 OUTPUT | MODE 3 */
+	>;
+};
+
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&led_wkgpio_pins
+	>;
+
+	led_wkgpio_pins: pinmux_leds_wkpins {
+		pinctrl-single,pins = <
+			0x1c 0x3	/* gpio_wk8 OUTPUT | MODE 3 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 4122efe..465c4b0b8 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -19,7 +19,7 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
-	leds {
+	leds: leds{
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "pandaboard::status1";
@@ -67,6 +67,7 @@
 			&mcbsp1_pins
 			&dss_hdmi_pins
 			&tpd12s015_pins
+			&led_gpio_pins
 	>;
 
 	twl6040_pins: pinmux_twl6040_pins {
@@ -110,6 +111,25 @@
 			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
 		>;
 	};
+
+	led_gpio_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+		>;
+	};
+};
+
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&led_wkgpio_pins
+	>;
+
+	led_wkgpio_pins: pinmux_leds_wkpins {
+		pinctrl-single,pins = <
+			0x1a 0x3	/* gpio_wk7 OUTPUT | MODE 3 */
+			0x1c 0x3	/* gpio_wk8 OUTPUT | MODE 3 */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.7.9.5
