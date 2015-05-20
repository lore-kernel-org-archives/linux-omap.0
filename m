From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Wed, 20 May 2015 10:38:42 -0500
Message-ID: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36445 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbETPir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 11:38:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

Fixes: http://bugs.elinux.org/issues/143

Entering RTC-only sleep is only properly supported on early prototypes series
(pre-A6) of the BeagleBone Black.  Since rev (A6A), which include all production
versions, it is not support at due to.

(rev A6) enable of the 3v3b regulator moved from LDO2 to LDO4 (3v3a)
side-effect: 3v3b rail remains on in sleep-mode (also in off-mode when battery-powered)

(rev A6A) am335x vdds supply moved from LDO3 to LDO1
side-effect: vdds remains supplied in sleep-mode

Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 5c42d25..901739f 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -80,7 +80,3 @@
 		status = "okay";
 	};
 };
-
-&rtc {
-	system-power-controller;
-};
-- 
2.1.4

