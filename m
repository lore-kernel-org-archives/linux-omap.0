From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] ARM: OMAP1: Move define of OMAP_LCD_DMA to dma.h
Date: Thu, 30 Aug 2012 17:52:21 -0700
Message-ID: <20120831005221.28732.16339.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17165 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2HaAwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:23 -0400
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is needed to start removing hardcoded IRQs on omap2+.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/dma.h  |    2 ++
 arch/arm/plat-omap/include/plat/irqs.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index c5811d4..0a87b05 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -31,6 +31,8 @@
 /* Move omap4 specific defines to dma-44xx.h */
 #include "dma-44xx.h"
 
+#define INT_DMA_LCD			25
+
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
 #define OMAP_DMA_MCSI1_TX		1
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 37bbbbb..15f497c 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -53,7 +53,6 @@
 #define INT_DMA_CH3		22
 #define INT_DMA_CH4		23
 #define INT_DMA_CH5		24
-#define INT_DMA_LCD		25
 #define INT_TIMER1		26
 #define INT_WD_TIMER		27
 #define INT_BRIDGE_PUB		28

