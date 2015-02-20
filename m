From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] ARM: DTS: omap2: Correct the dma controller's property names
Date: Fri, 20 Feb 2015 15:42:02 +0200
Message-ID: <1424439726-31994-2-git-send-email-peter.ujfalusi@ti.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52370 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbBTNmi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2015 08:42:38 -0500
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vinod.koul@intel.com

According to the Documentation/devicetree/bindings/dma/dma.txt the
dma-channels and dma-requests property should not have '#'.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 59d1c297bb30..578fa2a54dce 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -87,8 +87,8 @@
 				     <14>,
 				     <15>;
 			#dma-cells = <1>;
-			#dma-channels = <32>;
-			#dma-requests = <64>;
+			dma-channels = <32>;
+			dma-requests = <64>;
 		};
 
 		i2c1: i2c@48070000 {
-- 
2.3.0

