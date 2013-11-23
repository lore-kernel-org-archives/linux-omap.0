From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 3/5] DTS: ARM: OMAP3-N900: Add reset gpio to lcd node
Date: Sat, 23 Nov 2013 21:57:22 +0100
Message-ID: <1385240244-28629-4-git-send-email-sre@debian.org>
References: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56834 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859Ab3KWU6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:06 -0500
In-Reply-To: <1385240244-28629-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds reset-gpio property to the Nokia N900's
lcd node.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6ad5ae9..ac725e0 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -585,6 +585,9 @@
 		spi-max-frequency = <6000000>;
 		reg = <2>;
 
+		label = "lcd";
+		reset-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&display_pins>;
 	};
-- 
1.8.4.3

