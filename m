From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 06/14] DTS: ARM: OMAP3-N900: Add vibrator device
Date: Wed, 23 Oct 2013 00:49:35 +0200
Message-ID: <1382482183-14426-7-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add support for Nokia N900's vibrator.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5082cb6..a02f64f 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -142,6 +142,13 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl {
+	twl_audio: audio {
+		compatible = "ti,twl4030-audio";
+		ti,enable-vibra = <1>;
+	};
+};
+
 &twl_gpio {
 	ti,pullups	= <0x0>;
 	ti,pulldowns	= <0x03ff3f>; /* BIT(0..5) | BIT(8..17) */
-- 
1.8.4.rc3
