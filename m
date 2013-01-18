From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
Date: Fri, 18 Jan 2013 15:36:32 +0100
Message-ID: <1358519794-13214-4-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37654 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab3AROgq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:36:46 -0500
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

We have proper driver stack to handle the pmu_stat LED which is connected
PWMB of twl4030.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 3705a81..1c85e0f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -20,10 +20,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pmu_stat {
-			label = "beagleboard::pmu_stat";
-			gpios = <&twl_gpio 19 0>; /* LEDB */
-		};
 
 		heartbeat {
 			label = "beagleboard::usr0";
@@ -38,6 +34,16 @@
 		};
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+
+		pmu_stat {
+			label = "beagleboard::pmu_stat";
+			pwms = <&twl_pwmled 1 7812500>;
+			max-brightness = <127>;
+		};
+	};
+
 	sound {
 		compatible = "ti,omap-twl4030";
 		ti,model = "omap3beagle";
-- 
1.8.1

