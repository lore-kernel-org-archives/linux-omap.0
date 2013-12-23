From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: dts: OMAP2: fix interrupt number for rng
Date: Mon, 23 Dec 2013 16:59:39 -0600
Message-ID: <1387839579-58292-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46178 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309Ab3LWW7w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 17:59:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Suman Anna <s-anna@ti.com>

The irq data for rng module defined in hwmod data previously
missed the OMAP_INTC_START relative offset, so the interrupt
number is probably misconfigured during the DT node addition
adjusting for this OMAP_INTC_START. Interrupt #36 is associated
with a watchdog timer, so fix the rng module's interrupt to the
appropriate interrupt #52.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index d0c5b37..5377ddf 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -145,7 +145,7 @@
 			compatible = "ti,omap2-rng";
 			ti,hwmods = "rng";
 			reg = <0x480a0000 0x50>;
-			interrupts = <36>;
+			interrupts = <52>;
 		};
 
 		sham: sham@480a4000 {
-- 
1.8.4.3

