From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/12] omap: mailbox: Fix wrong condition check in while
	loop
Date: Mon, 28 Sep 2009 09:26:57 -0700
Message-ID: <20090928162657.GC18957@atomide.com>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZI1Q06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 12:26:58 -0400
Content-Disposition: inline
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's one more fix for this series.

Regards,

Tony

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=out

>From 540b5c02fb265349fd41bb9030ec350f24f4c2b9 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 28 Sep 2009 09:21:26 -0700
Subject: [PATCH] omap: mailbox: Fix wrong condition check in while loop

It's worked fine so far since reset is done for the first time.

Reported-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Juha Leppanen <juha_motorsportcom@luukku.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f3fefca..c035ad3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 		l = mbox_read_reg(MAILBOX_SYSSTATUS);
 		if (l & RESETDONE)
 			break;
-	} while (time_after(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	if (!(l & RESETDONE)) {
 		pr_err("Can't take mmu out of reset\n");

--6c2NcOVqGQ03X4Wi--
