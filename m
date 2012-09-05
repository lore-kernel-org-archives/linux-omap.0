From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
Date: Wed, 5 Sep 2012 23:34:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52968 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2IEXeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 19:34:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
AUXCOREBOOT1 register contents twice.  This seems like a waste of
time, so, remove the duplicates.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---

Santosh, care to review/ack this one?

 arch/arm/mach-omap2/omap-wakeupgen.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 05fdebf..b55432d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -233,12 +233,6 @@ static inline void omap4_irq_save_context(void)
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
 
 	/* Save SyncReq generation logic */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
-
-	/* Save SyncReq generation logic */
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
 	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
-- 
1.7.10.4

