From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] OMAP4: dma: Correct CPU version check for dma_common_ch_end
Date: Fri, 17 Feb 2012 11:25:06 +0200
Message-ID: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48768 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751925Ab2BQJZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 04:25:18 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id p5so4999607lag.30
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 01:25:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

CCDN is the last common channel register in all OMAP4 versions. Use
cpu_is_omap44xx() instead of the cpu_is_omap4430() - which is anyway not
doing what it supposed to do.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index a59a45a..b19d849 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	dma_stride		= OMAP2_DMA_STRIDE;
 	dma_common_ch_start	= CSDP;
-	if (cpu_is_omap3630() || cpu_is_omap4430())
+	if (cpu_is_omap3630() || cpu_is_omap44xx())
 		dma_common_ch_end = CCDN;
 	else
 		dma_common_ch_end = CCFN;
-- 
1.7.8.4

