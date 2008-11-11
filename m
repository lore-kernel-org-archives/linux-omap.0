From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 16/59] omap: namespace cleanup to arch/arm/mach-omap1/timer32k.c
Date: Wed, 12 Nov 2008 00:56:35 +0200
Message-ID: <1226444238-14614-17-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39947 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYKKXAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:00:48 -0500
In-Reply-To: <1226444238-14614-16-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/timer32k.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 705367e..40d9865 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -93,12 +93,12 @@ struct sys_timer omap_timer;
 
 static inline void omap_32k_timer_write(int val, int reg)
 {
-	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
+	__raw_writew(val, OMAP1_32K_TIMER_BASE + reg);
 }
 
 static inline unsigned long omap_32k_timer_read(int reg)
 {
-	return omap_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
+	return __raw_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
 }
 
 static inline void omap_32k_timer_start(unsigned long load_val)
@@ -156,7 +156,7 @@ static struct clock_event_device clockevent_32k_timer = {
  */
 static inline unsigned long omap_32k_sync_timer_read(void)
 {
-	return omap_readl(TIMER_32K_SYNCHRONIZED);
+	return __raw_readl(TIMER_32K_SYNCHRONIZED);
 }
 
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
-- 
1.6.0.2.307.gc427

