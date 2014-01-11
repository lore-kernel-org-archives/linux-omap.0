From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 3/6] DTS: ARM: OMAP3-N900: Add support for tsl2563
Date: Sat, 11 Jan 2014 22:17:00 +0100
Message-ID: <1389475023-11616-4-git-send-email-sre@debian.org>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51005 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaAKVRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:40 -0500
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add support for tsl2563 light sensor to the Nokia N900.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 40473cb..79c1881 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -346,6 +346,13 @@
 		DVDD-supply = <&vio>;
 	};
 
+	tsl2563: tsl2563@29 {
+		compatible = "amstaos,tsl2563";
+		reg = <0x29>;
+
+		amstaos,cover-comp-gain = <16>;
+	};
+
 	lp5523: lp5523@32 {
 		compatible = "national,lp5523";
 		reg = <0x32>;
-- 
1.8.5.2

