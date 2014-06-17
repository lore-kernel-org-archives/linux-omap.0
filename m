From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] arm: dts: dra7-evm: remove interrupt binding.
Date: Tue, 17 Jun 2014 12:29:21 +0530
Message-ID: <1402988361-10295-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58167 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbaFQG7a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 02:59:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, r.sricharan@ti.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, Sourav Poddar <sourav.poddar@ti.com>

The qspi node defines crossbar number as its interrupt number. But,
the crossbar dts patches are not yet there, this causes a warning during
boot.  So interrupts = < > property should be removed from DT and added
later by crossbar series.

Reported-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..eda7e84 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -773,7 +773,6 @@
 			clocks = <&qspi_gfclk_div>;
 			clock-names = "fck";
 			num-cs = <4>;
-			interrupts = <0 343 0x4>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5

