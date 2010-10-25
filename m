From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] omap: mailbox: remove unreachable return
Date: Mon, 25 Oct 2010 13:38:41 -0500
Message-ID: <1288031921-14736-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39343 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab0JYSsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 14:48:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unreachable return statement.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index a0af532..7dc9fa6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -437,8 +437,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 	return 0;
-
-	return ret;
 }
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
-- 
1.7.1

