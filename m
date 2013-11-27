From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ARM: dts: omap3-beagle: Add omap-twl4030 audio support
Date: Wed, 27 Nov 2013 20:46:48 +0200
Message-ID: <1385578008-6623-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47083 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757426Ab3K0SrK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Nov 2013 13:47:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

This adds typical McBSP2-TWL4030 audio description to the legacy
Beagle Board.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fa532aaacc68..1912c421e246 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -61,6 +61,14 @@
 		vcc-supply = <&hsusb2_power>;
 	};
 
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "omap3beagle";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 
@@ -120,6 +128,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
-- 
1.8.4.3

