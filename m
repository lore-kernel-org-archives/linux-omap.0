From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] arm/dts: am33xx wdt node
Date: Wed, 4 Jul 2012 18:00:37 +0530
Message-ID: <1341405037-16391-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab2GDMpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 08:45:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Add am33xx wdt node.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Hi,

This was tested on AM335X EVM. This depends on,
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69424.html

Regards
Afzal


 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f46e353..08b2a5b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -185,5 +185,10 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 		};
+
+		wdt2: wdt@44e35000 {
+			compatible = "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
-- 
1.7.11.1

