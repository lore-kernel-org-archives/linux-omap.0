From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 9/9] ARM: DTS: am335x-evmsk: Correct audio clock frequency
Date: Fri, 24 Jan 2014 10:19:07 +0200
Message-ID: <1390551547-12406-10-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbaAXITx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 03:19:53 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, stable@vger.kernel.org

The clock for audio is sourced from virt_24000000_ck, so the correct
frequency is 24000000.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <stable@vger.kernel.org> # 3.13.x
---
 arch/arm/boot/dts/am335x-evmsk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4718ec4a4dbf..50abe53f6887 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -121,7 +121,7 @@
 		ti,model = "AM335x-EVMSK";
 		ti,audio-codec = <&tlv320aic3106>;
 		ti,mcasp-controller = <&mcasp1>;
-		ti,codec-clock-rate = <24576000>;
+		ti,codec-clock-rate = <24000000>;
 		ti,audio-routing =
 			"Headphone Jack",       "HPLOUT",
 			"Headphone Jack",       "HPROUT";
-- 
1.8.5.3

