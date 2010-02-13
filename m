From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Fri, 12 Feb 2010 19:40:41 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34491 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652Ab0BMBkr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:40:47 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From 60e21e76773de379deb41ff166f9679b7078276f Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 10 Feb 2010 17:08:20 -0600
Subject: [PATCH] Mailbox: change mailbox version print to pr_debug

it is not useful printing the version every time mailbox is used
instead change it to pr_debug in case someone needs to see the
version can enable the print.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 2c9fd1c..1078767 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -113,7 +113,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	}
 
 	l = mbox_read_reg(MAILBOX_REVISION);
-	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
+	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
 	l = SMARTIDLE | AUTOIDLE;
 	mbox_write_reg(l, MAILBOX_SYSCONFIG);
-- 
1.6.0.4

