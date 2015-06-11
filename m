From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] Revert "ARM: dts: am335x-boneblack: disable RTC-only sleep"
Date: Thu, 11 Jun 2015 16:18:38 +0200
Message-ID: <1434032318-3557-1-git-send-email-johan@kernel.org>
References: <20150601200137.GC30984@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34850 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbFKOSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2015 10:18:47 -0400
In-Reply-To: <20150601200137.GC30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, robertcnelson@gmail.com, Felipe Balbi <balbi@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Johan Hovold <johan@kernel.org>

This reverts commit 3d76be5b933e2a66d85a2f7444e68e99e8a48ad4.

The latest revision of Beaglebone Black does not support RTC-only mode.

To avoid potential hardware damage, RTC-only mode was disabled by
default by commit 7a6cb0abe1aa ("ARM: dts: am335x-boneblack: disable
RTC-only sleep to avoid hardware damage").

Unfortunately, an incorrect fix had already been applied, which instead
of just disabling RTC-only mode, prevents the Beaglebone from powering
down at all.

Revert this patch to fix the power-off regression.

Signed-off-by: Johan Hovold <johan@kernel.org>
---

The offending patch was incorrectly applied after Matthijs initial fix
was posted and before the final fix (which only added some comments) was
applied.

Note that the final version of the fix 7a6cb0abe1aa ("ARM: dts:
am335x-boneblack: disable RTC-only sleep to avoid hardware damage")
indicates that it should be backported to 3.12 even though RTC-only mode
was first enabled in 3.19.

Johan


 arch/arm/boot/dts/am335x-boneblack.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 901739fcb85a..5c42d259fa68 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -80,3 +80,7 @@
 		status = "okay";
 	};
 };
+
+&rtc {
+	system-power-controller;
+};
-- 
2.3.6

