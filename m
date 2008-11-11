From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 26/59] omap: namespace cleanup to drivers/dsp/dspgateway/dsp.h
Date: Wed, 12 Nov 2008 00:56:45 +0200
Message-ID: <1226444238-14614-27-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39930 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYKKXAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:00:40 -0500
In-Reply-To: <1226444238-14614-26-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/dspgateway/dsp.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/dspgateway/dsp.h b/drivers/dsp/dspgateway/dsp.h
index 84e7cea..f27c344 100644
--- a/drivers/dsp/dspgateway/dsp.h
+++ b/drivers/dsp/dspgateway/dsp.h
@@ -259,15 +259,15 @@ extern struct omap_mmu dsp_mmu;
 #define DSPSPACE_SIZE	0x1000000
 
 #define omap_set_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) | (b), (r)); } while(0)
+	do { __raw_writew(__raw_readw(r) | (b), (r)); } while(0)
 #define omap_clr_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) & ~(b), (r)); } while(0)
+	do { __raw_writew(__raw_readw(r) & ~(b), (r)); } while(0)
 #define omap_set_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) | (b), (r)); } while(0)
+	do { __raw_writel(__raw_readl(r) | (b), (r)); } while(0)
 #define omap_clr_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) & ~(b), (r)); } while(0)
+	do { __raw_writel(__raw_readl(r) & ~(b), (r)); } while(0)
 #define omap_set_bits_regl(val,mask,r) \
-	do { omap_writel((omap_readl(r) & ~(mask)) | (val), (r)); } while(0)
+	do { __raw_writel((__raw_readl(r) & ~(mask)) | (val), (r)); } while(0)
 
 #define dspword_to_virt(dw)	((void *)(dspmem_base + ((dw) << 1)))
 #define dspbyte_to_virt(db)	((void *)(dspmem_base + (db)))
@@ -307,7 +307,7 @@ extern struct omap_mmu dsp_mmu;
  */
 #define tc_wordswap() \
 	do { \
-		omap_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
+		__raw_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
 			    TC_ENDIANISM); \
 	} while(0)
 
-- 
1.6.0.2.307.gc427

