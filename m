From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 4/4] ARM: dts: omap3-n900: Add display support
Date: Fri, 13 Dec 2013 19:17:30 +0100
Message-ID: <1386958650-2404-5-git-send-email-sre@debian.org>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:59933 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab3LMSSS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 13:18:18 -0500
In-Reply-To: <1386958650-2404-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add support for the Nokia N900's display.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c2c306d..cf776f3 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -472,12 +472,28 @@
 		reg = <0>;
 	};
 	mipid@2 {
-		compatible = "acx565akm";
+		compatible = "sony,acx565akm";
 		spi-max-frequency = <6000000>;
 		reg = <2>;
 
+		label = "lcd";
+		reset-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&display_pins>;
+
+		lcd_in: endpoint {
+			remote-endpoint = <&sdi_out>;
+		};
+	};
+};
+
+&sdi {
+	vdds_sdi-supply = <&vaux1>;
+
+	sdi_out: endpoint {
+		remote-endpoint = <&lcd_in>;
+		data-lines = <2>;
 	};
 };
 
-- 
1.8.5.1

