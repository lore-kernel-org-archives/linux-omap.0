From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 21/59] omap: namespace cleanup to arch/arm/plat-omap/dmtimer.c
Date: Wed, 12 Nov 2008 00:56:40 +0200
Message-ID: <1226444238-14614-22-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39983 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYKKXA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:00:57 -0500
In-Reply-To: <1226444238-14614-21-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 844043a..62d1d19 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -443,7 +443,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 		l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
-			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
+			if (((__raw_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
 				inputmask &= ~(1 << 1);
 			else
 				inputmask &= ~(1 << 2);
@@ -503,9 +503,9 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	int n = (timer - dm_timers) << 1;
 	u32 l;
 
-	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
+	l = __raw_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
 	l |= source << n;
-	omap_writel(l, MOD_CONF_CTRL_1);
+	__raw_writel(l, MOD_CONF_CTRL_1);
 }
 
 #else
-- 
1.6.0.2.307.gc427

