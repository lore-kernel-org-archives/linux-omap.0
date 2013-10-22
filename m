From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 04/14] DTS: ARM: OMAP3-N900: Add support for SD cards
Date: Wed, 23 Oct 2013 00:49:33 +0200
Message-ID: <1382482183-14426-5-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add support for external SD card slot.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 9226268..01a437e 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -65,6 +65,17 @@
 			0x194 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
+			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
+			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0 */
+			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
+			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
+			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -103,7 +114,11 @@
 };
 
 &mmc1 {
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
 };
 
 &mmc2 {
-- 
1.8.4.rc3
