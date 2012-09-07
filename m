From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] ARM: dts: omap3-beagle: Add heartbeat and mmc LEDs support
Date: Fri, 7 Sep 2012 10:55:18 +0200
Message-ID: <5049B676.1080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46308 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760190Ab2IGIzg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Sep 2012 04:55:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: florian Vaussard <florian.vaussard@epfl.ch>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Add the support for D6 and D7 LEDs on Beagle board.
- D6 will be used for heartbeat
- D7 will be used for mmc0

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

It is based on top of the LEDB support added by Florian.

Regards,
Benoit

 arch/arm/boot/dts/omap3-beagle.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3fe35c2..ca46fb2 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -24,6 +24,18 @@
 			label = "beagleboard::pmu_stat";
 			gpios = <&twl_gpio 19 0>; /* LEDB */
 		};
+
+		heartbeat {
+			label = "beagleboard::usr0";
+			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
+			linux,default-trigger = "heartbeat";
+		};
+
+		mmc {
+			label = "beagleboard::usr1";
+			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
+			linux,default-trigger = "mmc0";
+		};
 	};
 };
 
-- 
1.7.0.4
