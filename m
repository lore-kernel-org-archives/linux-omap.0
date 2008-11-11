From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 03/59] omap: namespace cleanup to arch/arm/mach-omap1/board-nokia770.c
Date: Wed, 12 Nov 2008 00:56:22 +0200
Message-ID: <1226444238-14614-4-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56881 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYKKW6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:03 -0500
In-Reply-To: <1226444238-14614-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7b28f4d..c94179c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -47,9 +47,9 @@ static void __init omap_nokia770_init_irq(void)
 	 * to become functional */
 
 	/* SleepX mask direction */
-	omap_writew((omap_readw(0xfffb5008) & ~2), 0xfffb5008);
+	__raw_writew((__raw_readw(0xfffb5008) & ~2), 0xfffb5008);
 	/* Unmask SleepX signal */
-	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
+	__raw_writew((__raw_readw(0xfffb5004) & ~2), 0xfffb5004);
 
 	omap1_init_common_hw();
 	omap_init_irq();
-- 
1.6.0.2.307.gc427

