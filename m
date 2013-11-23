From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/5] DTS: ARM: OMAP3-N900: Add vendor prefixes to SPI devices
Date: Sat, 23 Nov 2013 21:57:21 +0100
Message-ID: <1385240244-28629-3-git-send-email-sre@debian.org>
References: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56837 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab3KWU6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:06 -0500
In-Reply-To: <1385240244-28629-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

SPI attached devices are currently missing vendor
prefixes. This patch adds them.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 3900f84..6ad5ae9 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -576,12 +576,12 @@
 	 * Also... order in the device tree actually matters here.
 	 */
 	tsc2005@0 {
-		compatible = "tsc2005";
+		compatible = "ti,tsc2005";
 		spi-max-frequency = <6000000>;
 		reg = <0>;
 	};
 	mipid@2 {
-		compatible = "acx565akm";
+		compatible = "sony,acx565akm";
 		spi-max-frequency = <6000000>;
 		reg = <2>;
 
-- 
1.8.4.3

