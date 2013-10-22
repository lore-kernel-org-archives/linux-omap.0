From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 07/14] DTS: ARM: OMAP3-N900: Add LP5523 support
Date: Wed, 23 Oct 2013 00:49:36 +0200
Message-ID: <1382482183-14426-8-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38637 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335Ab3JVWuO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Oct 2013 18:50:14 -0400
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add support for LP5523 device.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index a02f64f..c7e0d2d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -159,6 +159,11 @@
 	pinctrl-0 = <&i2c2_pins>;
 
 	clock-frequency = <100000>;
+
+	bq27200: bq27200@55 {
+		compatible = "ti,bq27200";
+		reg = <0x55>;
+	};
 };
 
 &i2c3 {
-- 
1.8.4.rc3

