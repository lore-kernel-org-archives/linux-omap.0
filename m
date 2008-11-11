From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 06/59] omap: namespace cleanup to arch/arm/mach-omap1/board-palmz71.c
Date: Wed, 12 Nov 2008 00:56:25 +0200
Message-ID: <1226444238-14614-7-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56931 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYKKW6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:20 -0500
In-Reply-To: <1226444238-14614-6-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-palmz71.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e8116c5..599ee07 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -300,10 +300,10 @@ static void __init
 omap_mpu_wdt_mode(int mode)
 {
 	if (mode)
-		omap_writew(0x8000, OMAP_WDT_TIMER_MODE);
+		__raw_writew(0x8000, OMAP_WDT_TIMER_MODE);
 	else {
-		omap_writew(0x00f5, OMAP_WDT_TIMER_MODE);
-		omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);
+		__raw_writew(0x00f5, OMAP_WDT_TIMER_MODE);
+		__raw_writew(0x00a0, OMAP_WDT_TIMER_MODE);
 	}
 }
 
-- 
1.6.0.2.307.gc427

