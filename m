From: yegorslists@googlemail.com
Subject: [PATCH] ARM: dts: am335x-evmsk: enable DMA controller for USB
Date: Mon, 10 Mar 2014 16:26:57 +0100
Message-ID: <1394465217-24171-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:48745 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbaCJP1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 11:27:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index fa19271..ec08f6f 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -384,6 +384,10 @@
 		status = "okay";
 		dr_mode = "host";
 	};
+
+	dma-controller@07402000  {
+		status = "okay";
+	};
 };
 
 &epwmss2 {
-- 
1.7.7

