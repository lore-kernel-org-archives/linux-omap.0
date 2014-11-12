From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: DRA7: wdt: Fix compatible property for watchdog node
Date: Wed, 12 Nov 2014 10:54:15 +0530
Message-ID: <1415769855-32565-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47734 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbaKLFZ4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 00:25:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>

OMAP wdt driver supports only ti,omap3-wdt compatible. In DRA7 dt
wdt compatible property is defined as ti,omap4-wdt by mistake instead of
ti,omap3-wdt. Correcting the typo.

Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board")
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..666e796 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -653,7 +653,7 @@
 		};
 
 		wdt2: wdt@4ae14000 {
-			compatible = "ti,omap4-wdt";
+			compatible = "ti,omap3-wdt";
 			reg = <0x4ae14000 0x80>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
-- 
1.9.1

