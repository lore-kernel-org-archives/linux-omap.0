From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] DTS: ARM: OMAP3-N900: Fix i2c bus speed
Date: Tue, 22 Oct 2013 13:02:54 +0200
Message-ID: <1382439774-16265-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Fix the bus speed of i2c bus 2 and 3.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 57f5a2a..2374b9a 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -78,14 +78,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
 
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 };
 
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
 
-	clock-frequency = <100000>;
+	clock-frequency = <400000>;
 };
 
 &mmc1 {
-- 
1.8.4.rc3
