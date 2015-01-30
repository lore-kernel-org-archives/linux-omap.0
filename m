From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ARM: dst: OMAP3-N900: Add microphone bias voltages
Date: Fri, 30 Jan 2015 21:23:20 +0200
Message-ID: <1422645800-21287-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:51931 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbbA3TXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2015 14:23:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>

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
Pavel: I hope you don't mind I took your diff from
http://marc.info/?l=linux-kernel&m=142249383224678&w=2
and added your Signed-off-by?
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b550c41b46f1..f7858f5974e3 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -478,6 +478,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <1>;
 	};
 
 	tlv320aic3x_aux: tlv320aic3x@19 {
@@ -489,6 +491,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <2>;
 	};
 
 	tsl2563: tsl2563@29 {
-- 
2.1.4

