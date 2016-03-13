From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/7] ARM: dts: OMAP3-N950: Add Keypad Matrix
Date: Sun, 13 Mar 2016 01:06:15 +0100
Message-ID: <1457827580-16919-3-git-send-email-sre@kernel.org>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457827580-16919-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add keypad matrix information based on data from
Nokia N950 Kernel.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950.dts | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 0885b34d5d7d..80bed4eb6b08 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "omap3-n950-n9.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Nokia N950";
@@ -53,3 +54,58 @@
 		};
 	};
 };
+
+&twl_keypad {
+	linux,keymap = < MATRIX_KEY(0x00, 0x00, KEY_BACKSLASH)
+			 MATRIX_KEY(0x01, 0x00, KEY_LEFTSHIFT)
+			 MATRIX_KEY(0x02, 0x00, KEY_COMPOSE)
+			 MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)
+			 MATRIX_KEY(0x04, 0x00, KEY_RIGHTCTRL)
+			 MATRIX_KEY(0x05, 0x00, KEY_BACKSPACE)
+			 MATRIX_KEY(0x06, 0x00, KEY_VOLUMEDOWN)
+			 MATRIX_KEY(0x07, 0x00, KEY_VOLUMEUP)
+
+			 MATRIX_KEY(0x03, 0x01, KEY_Z)
+			 MATRIX_KEY(0x04, 0x01, KEY_A)
+			 MATRIX_KEY(0x05, 0x01, KEY_Q)
+			 MATRIX_KEY(0x06, 0x01, KEY_W)
+			 MATRIX_KEY(0x07, 0x01, KEY_E)
+
+			 MATRIX_KEY(0x03, 0x02, KEY_X)
+			 MATRIX_KEY(0x04, 0x02, KEY_S)
+			 MATRIX_KEY(0x05, 0x02, KEY_D)
+			 MATRIX_KEY(0x06, 0x02, KEY_C)
+			 MATRIX_KEY(0x07, 0x02, KEY_V)
+
+			 MATRIX_KEY(0x03, 0x03, KEY_O)
+			 MATRIX_KEY(0x04, 0x03, KEY_I)
+			 MATRIX_KEY(0x05, 0x03, KEY_U)
+			 MATRIX_KEY(0x06, 0x03, KEY_L)
+			 MATRIX_KEY(0x07, 0x03, KEY_APOSTROPHE)
+
+			 MATRIX_KEY(0x03, 0x04, KEY_Y)
+			 MATRIX_KEY(0x04, 0x04, KEY_K)
+			 MATRIX_KEY(0x05, 0x04, KEY_J)
+			 MATRIX_KEY(0x06, 0x04, KEY_H)
+			 MATRIX_KEY(0x07, 0x04, KEY_G)
+
+			 MATRIX_KEY(0x03, 0x05, KEY_B)
+			 MATRIX_KEY(0x04, 0x05, KEY_COMMA)
+			 MATRIX_KEY(0x05, 0x05, KEY_M)
+			 MATRIX_KEY(0x06, 0x05, KEY_N)
+			 MATRIX_KEY(0x07, 0x05, KEY_DOT)
+
+			 MATRIX_KEY(0x00, 0x06, KEY_SPACE)
+			 MATRIX_KEY(0x03, 0x06, KEY_T)
+			 MATRIX_KEY(0x04, 0x06, KEY_UP)
+			 MATRIX_KEY(0x05, 0x06, KEY_LEFT)
+			 MATRIX_KEY(0x06, 0x06, KEY_RIGHT)
+			 MATRIX_KEY(0x07, 0x06, KEY_DOWN)
+
+			 MATRIX_KEY(0x03, 0x07, KEY_P)
+			 MATRIX_KEY(0x04, 0x07, KEY_ENTER)
+			 MATRIX_KEY(0x05, 0x07, KEY_SLASH)
+			 MATRIX_KEY(0x06, 0x07, KEY_F)
+			 MATRIX_KEY(0x07, 0x07, KEY_R)
+			 >;
+};
-- 
2.7.0
