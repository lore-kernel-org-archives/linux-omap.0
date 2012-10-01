From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 1/7] ARM: OMAP: DMA: Removing plat/dma-44xx.h
Date: Tue, 2 Oct 2012 00:17:00 +0530
Message-ID: <1349117226-4980-2-git-send-email-lokeshvutla@ti.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35926 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab2JASr1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 14:47:27 -0400
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

None of the DMA channel definitions defined in
plat/dma-44xx.h are used. So removing it.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/plat-omap/include/plat/dma-44xx.h |  147 ----------------------------
 arch/arm/plat-omap/include/plat/dma.h      |    3 -
 2 files changed, 150 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h

diff --git a/arch/arm/plat-omap/include/plat/dma-44xx.h b/arch/arm/plat-omap/include/plat/dma-44xx.h
deleted file mode 100644
index 1f767cb..0000000
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 0a87b05..e413bd8 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -28,9 +28,6 @@
  * the omap drivers hwmod adapted.
  */
 
-/* Move omap4 specific defines to dma-44xx.h */
-#include "dma-44xx.h"
-
 #define INT_DMA_LCD			25
 
 /* DMA channels for omap1 */
-- 
1.7.10.4

