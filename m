From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v4 3/5] ARM: dts: omap3-sniper: TWL4030 keypad support
Date: Sun, 28 Feb 2016 13:39:43 +0100
Message-ID: <1456663185-14170-4-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456663185-14170-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This adds support for the volume and gesture keys, using TWL4030 keypad.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap3-sniper.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index 6e31daf..78a1184 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "omap36xx.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "LG Optimus Black";
@@ -226,6 +227,14 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl_keypad {
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x00, KEY_VOLUMEUP)
+		MATRIX_KEY(0x01, 0x00, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x02, 0x00, KEY_SELECT)
+	>;
+};
+
 /*
  * The TWL4030 VAUX2 and VDAC regulators power sensors that are slaves on I2C3.
  * When not powered, these sensors cause the I2C3 clock to stay low at all times,
-- 
2.6.4
