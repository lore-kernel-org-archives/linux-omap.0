From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.33-rc2+ 11/12] arm: omap: mailbox: kill compile warning in mailbox.c
Date: Wed, 30 Dec 2009 00:51:31 +0200
Message-ID: <1262127092-14878-12-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50636 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZL2XCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:02:09 -0500
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

Change %d to %ld to avoid the compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 281ab63..2c9fd1c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
 	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
+		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
 			PTR_ERR(mbox_ick_handle));
 		return PTR_ERR(mbox_ick_handle);
 	}
-- 
1.6.6.35.g1d85d

