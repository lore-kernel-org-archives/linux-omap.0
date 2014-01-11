From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 4/6] DTS: ARM: OMAP3-N900: Add tpa6130a2 support
Date: Sat, 11 Jan 2014 22:17:01 +0100
Message-ID: <1389475023-11616-5-git-send-email-sre@debian.org>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51012 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaAKVRm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:42 -0500
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds support for the N900's headphone
amplifier to the N900 DTS file.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 79c1881..0ceacad 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -418,6 +418,15 @@
 		compatible = "ti,bq27200";
 		reg = <0x55>;
 	};
+
+	tpa6130a2: tpa6130a2@60 {
+		compatible = "ti,tpa6130a2";
+		reg = <0x60>;
+
+		Vdd-supply = <&vmmc2>;
+
+		power-gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>; /* 98 */
+	};
 };
 
 &i2c3 {
-- 
1.8.5.2

