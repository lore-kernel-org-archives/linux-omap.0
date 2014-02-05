From: Stefan Roese <sr@denx.de>
Subject: [PATCH 1/3] arm: dts: am33xx.dtsi: Add node name to rtc device node
Date: Wed,  5 Feb 2014 13:12:39 +0100
Message-ID: <1391602361-2666-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:51997 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaBEMMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Feb 2014 07:12:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lukas Stockmann <lukas.stockmann@siemens.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>

Making it possible to reference and therefor change (disable) this
device node from other dts file which import this dtsi file.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..b8daf8c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -399,7 +399,7 @@
 			ti,timer-pwm;
 		};
 
-		rtc@44e3e000 {
+		rtc: rtc@44e3e000 {
 			compatible = "ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <75
-- 
1.8.5.3

