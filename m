From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: DMA: Don't mark channel active in omap_enable_channel_irq
Date: Tue, 13 May 2008 13:26:03 +0300
Message-ID: <1210674363-23309-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21362 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYEMKZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 06:25:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DAPdlI022966
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 13:25:42 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Channel should be marked active only when DMA is really started. Otherwise
just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will cause
incorrect dump_stack().

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/dma.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c00eda5..39c637b 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -501,8 +501,6 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Enable some nice interrupts. */
 	OMAP_DMA_CICR_REG(lch) = dma_chan[lch].enabled_irqs;
-
-	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
 
 static void omap_disable_channel_irq(int lch)
-- 
1.5.5.1

