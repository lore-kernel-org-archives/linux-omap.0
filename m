From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: DTS: am335x-evmsk: Enable the McASP FIFO for audio
Date: Thu, 3 Jul 2014 12:51:23 +0300
Message-ID: <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
References: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59434 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965008AbaGCJv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 05:51:56 -0400
In-Reply-To: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

The use of FIFO in McASP can reduce the risk of audio under/overrun and
lowers the load on the memories since the DMA will operate in bursts.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index ab9a34ce524c..80a3b215e7d6 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -560,8 +560,8 @@
 		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 			0 0 1 2
 		>;
-		tx-num-evt = <1>;
-		rx-num-evt = <1>;
+		tx-num-evt = <32>;
+		rx-num-evt = <32>;
 };
 
 &tscadc {
-- 
2.0.0

