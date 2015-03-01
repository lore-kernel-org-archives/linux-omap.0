From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Sun,  1 Mar 2015 21:07:08 +0200
Message-ID: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:52272 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbCATHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Mar 2015 14:07:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>

From: Pavel Machek <pavel@ucw.cz>

N900 audio recording needs that codec provides bias voltage for integrated
digital microphone and headset microphone depending which one is used.
Digital microphone uses 2 V bias and it comes from the codec A part. Codec
B part drives the headset microphone bias and that is set to 2.5 V.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
[Jarkko: Headset mic bias changed to 2 (2.5 V) as it was before commit
e2e8bfdf6157 ("ASoC: tlv320aic3x: Convert mic bias to a supply widget")]
Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index db80f9d376fa..9c8bdf2c93a1 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -484,6 +484,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <1>;
 	};
 
 	tlv320aic3x_aux: tlv320aic3x@19 {
@@ -495,6 +497,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <2>;
 	};
 
 	tsl2563: tsl2563@29 {
-- 
2.1.4

