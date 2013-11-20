From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 20/31] arm: boot: dts: am33xx/omap3: fix intc compatible flag
Date: Wed, 20 Nov 2013 12:09:07 -0600
Message-ID: <1384970958-4118-21-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48476 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3KTSKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:38 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

that way, our intc driver can figure out how
many IRQ lines INTC has.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 arch/arm/boot/dts/omap3.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6d8ffe..93dd479 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -103,7 +103,7 @@
 		ti,hwmods = "l3_main";
 
 		intc: interrupt-controller@48200000 {
-			compatible = "ti,omap2-intc";
+			compatible = "ti,am33xx-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			ti,intc-size = <128>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f3a0c26..e42d17d 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -89,7 +89,7 @@
 		};
 
 		intc: interrupt-controller@48200000 {
-			compatible = "ti,omap2-intc";
+			compatible = "ti,omap3-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			ti,intc-size = <96>;
-- 
1.8.4.GIT

