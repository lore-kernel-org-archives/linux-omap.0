From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: correct GPMC IRQ
Date: Thu, 17 Mar 2011 21:30:04 +0530
Message-ID: <1300377606-16616-2-git-send-email-balajitk@ti.com>
References: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50574 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab1CQP4q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:56:46 -0400
In-Reply-To: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Balaji T K <balajitk@ti.com>

GPMC: number of chip select is 8, CS0 to CS7
One less IRQ allocated throws below warning at boot

[    0.429290] Trying to install type control for IRQ409
[    0.429290] Trying to set irq flags for IRQ409

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index d779283..5a25098 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -416,7 +416,7 @@
 
 /* GPMC related */
 #define OMAP_GPMC_IRQ_BASE	(TWL_IRQ_END)
-#define OMAP_GPMC_NR_IRQS	7
+#define OMAP_GPMC_NR_IRQS	8
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
 
-- 
1.7.0.4

