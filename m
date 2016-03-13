From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/7] ARM: dts: OMAP3-N950: Add Vibrator
Date: Sun, 13 Mar 2016 01:06:16 +0100
Message-ID: <1457827580-16919-4-git-send-email-sre@kernel.org>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457827580-16919-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 80bed4eb6b08..3dbf9d66bcc1 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -55,6 +55,13 @@
 	};
 };
 
+&twl {
+	twl_audio: audio {
+		compatible = "ti,twl4030-audio";
+		ti,enable-vibra = <1>;
+	};
+};
+
 &twl_keypad {
 	linux,keymap = < MATRIX_KEY(0x00, 0x00, KEY_BACKSLASH)
 			 MATRIX_KEY(0x01, 0x00, KEY_LEFTSHIFT)
-- 
2.7.0
