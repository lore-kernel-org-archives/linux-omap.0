From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: DTS: am335x-evmsk: Correct audio clock frequency
Date: Mon, 23 Dec 2013 11:28:34 +0200
Message-ID: <1387790915-7217-2-git-send-email-peter.ujfalusi@ti.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37890 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab3LWJ3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Dec 2013 04:29:06 -0500
In-Reply-To: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rogerq@ti.com, balbi@ti.com

The clock for audio is sourced from virt_24000000_ck, so the correct
frequency is 24000000.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
1.8.5.2

