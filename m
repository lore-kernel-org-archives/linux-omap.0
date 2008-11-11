From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 08/59] omap: namespace cleanup to arch/arm/mach-omap1/board-voiceblue.c
Date: Wed, 12 Nov 2008 00:56:27 +0200
Message-ID: <1226444238-14614-9-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56960 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYKKW6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:32 -0500
In-Reply-To: <1226444238-14614-8-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-voiceblue.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 3ab5bbf..e3db8f4 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -192,8 +192,8 @@ static void __init voiceblue_init(void)
 
 	/* There is a good chance board is going up, so enable power LED
 	 * (it is connected through invertor) */
-	omap_writeb(0x00, OMAP_LPG1_LCR);
-	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
+	__raw_writeb(0x00, OMAP_LPG1_LCR);
+	__raw_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
 }
 
 static void __init voiceblue_map_io(void)
@@ -213,8 +213,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 
 	/* Flash power LED */
-	omap_writeb(0x78, OMAP_LPG1_LCR);
-	omap_writeb(0x01, OMAP_LPG1_PMR);	/* Enable clock */
+	__raw_writeb(0x78, OMAP_LPG1_LCR);
+	__raw_writeb(0x01, OMAP_LPG1_PMR);	/* Enable clock */
 
 	return NOTIFY_DONE;
 }
-- 
1.6.0.2.307.gc427

