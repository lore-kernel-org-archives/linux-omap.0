From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 28/59] omap: namespace cleanup to drivers/dsp/dspgateway/mmu.h
Date: Wed, 12 Nov 2008 00:56:47 +0200
Message-ID: <1226444238-14614-29-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56681 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbYKKXFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:43 -0500
In-Reply-To: <1226444238-14614-28-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/dspgateway/mmu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/dspgateway/mmu.h b/drivers/dsp/dspgateway/mmu.h
index 9d60e9e..b8e17c7 100644
--- a/drivers/dsp/dspgateway/mmu.h
+++ b/drivers/dsp/dspgateway/mmu.h
@@ -64,7 +64,7 @@ static int omapfb_ready;
 #define EMIF_PRIO_MPU_SHIFT	0
 #define set_emiff_dma_prio(prio) \
 	do { \
-		omap_writel((omap_readl(OMAP_TC_OCPT1_PRIOR) & \
+		__raw_writel((__raw_readl(OMAP_TC_OCPT1_PRIOR) & \
 			     ~EMIF_PRIO_DMA_MASK) | \
 			    ((prio) << EMIF_PRIO_DMA_SHIFT), \
 			    OMAP_TC_OCPT1_PRIOR); \
-- 
1.6.0.2.307.gc427

