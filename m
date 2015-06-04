From: Arun Bharadwaj <arun@gumstix.com>
Subject: [PATCH 1/3] ARM: dts: Correct audio input route & set mic bias
Date: Thu,  4 Jun 2015 11:08:17 -0700
Message-ID: <1433441299-18887-2-git-send-email-arun@gumstix.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35160 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbbFDSIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 14:08:23 -0400
Received: by padjw17 with SMTP id jw17so34261160pad.2
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2015 11:08:22 -0700 (PDT)
In-Reply-To: <1433441299-18887-1-git-send-email-arun@gumstix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Adam YH Lee <adam.yh.lee@gmail.com>, Ash Charles <ashcharles@gmail.com>

From: Adam YH Lee <adam.yh.lee@gmail.com>

Audio-in was incorrectly routed to Line In. It should be Mic3L as per
schematic.

Using mic-bias voltage at 2.0v (<0x1>) does not work for some reason. There
is no voltage seen on micbias (R127). Mic-bias voltage of 2.5v (<0x2>) works.
I see voltage of 2.475v across GND and micbias.

With these changes, I can record audio with a pair of proliferate TRRS earbuds.

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 0d35ab6..473d8ee 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -74,6 +74,7 @@
 	audio_codec: tlv320aic3106@1b {
 		compatible = "ti,tlv320aic3106";
 		reg = <0x1b>;
+		ai3x-micbias-vg = <0x2>;
 	};
 
 	accel: lis331dlh@1d {
@@ -153,7 +154,7 @@
 	ti,audio-routing =
 		"Headphone Jack",	"HPLOUT",
 		"Headphone Jack",	"HPROUT",
-		"LINE1L",		"Line In";
+		"MIC3L",		"Mic3L Switch";
 };
 
 &mcasp0 {
-- 
2.1.4

