From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arm: omap2: mailbox: fix compile warning
Date: Tue, 22 Dec 2009 22:21:53 +0200
Message-ID: <1261513313-14109-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55847 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZLVU0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 15:26:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

fix the format in the printk() and avoid a compile
warning.

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
1.6.6.rc0

