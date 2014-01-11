From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 6/6] DTS: ARM: OMAP3-N900: Add bq24150a support
Date: Sat, 11 Jan 2014 22:17:03 +0100
Message-ID: <1389475023-11616-7-git-send-email-sre@debian.org>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51020 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbaAKVRq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:46 -0500
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds support for the bq24150a chip to the
Nokia N900 DTS file.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 86cceaf..64aa416 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -432,6 +432,20 @@
 
 		power-gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>; /* 98 */
 	};
+
+	bq24150a: bq24150a@6b {
+		compatible = "ti,bq24150a";
+		reg = <0x6b>;
+
+		ti,current-limit = <100>;
+		ti,weak-battery-voltage = <3400>;
+		ti,battery-regulation-voltage = <4200>;
+		ti,charge-current = <650>;
+		ti,termination-current = <100>;
+		ti,resistor-sense = <68>;
+
+		ti,usb-charger-detection = <&isp1704>;
+	};
 };
 
 &i2c3 {
-- 
1.8.5.2

