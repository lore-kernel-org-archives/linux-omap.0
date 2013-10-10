From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH] ARM: DRA: DTS: Remove clock-frequency field for cpu timers
Date: Thu, 10 Oct 2013 13:20:13 +0530
Message-ID: <1381391413-4361-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab3JJHum (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 03:50:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, Sricharan R <r.sricharan@ti.com>

The arm arch timers frequency are now programmed in the CNTFREQ
per-cpu register by the timer code using the secure API [1].
So remove the redundant entry from the dts.

[1] http://marc.info/?l=linux-omap&m=138139106312786&w=2

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 37f606b..f25adc5 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -52,7 +52,6 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <6144000>;
 	};
 
 	gic: interrupt-controller@48211000 {
-- 
1.7.9.5

