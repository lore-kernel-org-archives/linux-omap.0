From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/17] omap2/3/4: mailbox: kill compile warning in mailbox.c
Date: Wed, 10 Feb 2010 19:36:05 -0800
Message-ID: <20100211033605.1624.56725.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58455 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0BKDfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:35:24 -0500
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

Change %d to %ld to avoid the compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

