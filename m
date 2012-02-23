From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] OMAP4: dma: Correct CPU version check for dma_common_ch_end
Date: Thu, 23 Feb 2012 09:44:41 +0200
Message-ID: <1329983081-9494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:41945 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751765Ab2BWHoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 02:44:46 -0500
Received: by lahi5 with SMTP id i5so1197154lah.4
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 23:44:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

CCDN is the last common channel register in all OMAP4 versions. Use
cpu_is_omap44xx() instead of the cpu_is_omap4430().
cpu_is_omap4430() returns 0 unconditionally. This causes that the
dma_common_ch_end register variable is not configured correctly on OMAP4, not
even for OMAP4430.
Because of this, registers between CCFN - CCDN will be not cleard in the
omap2_clear_dma function in OMAP4.

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

