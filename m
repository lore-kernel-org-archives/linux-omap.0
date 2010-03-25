From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 09/11] MUSB: OMAP: don't call clk_put()
Date: Thu, 25 Mar 2010 13:14:31 +0200
Message-ID: <1269515673-27980-10-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45918 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab0CYLPs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:15:48 -0400
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Remove duplicate/unbalanced call to clk_put() from musb_platform_exit() --
clk_put() gets called from musb_core.c anyway...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3fe1686..6e1eccb 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -332,8 +332,5 @@ int musb_platform_exit(struct musb *musb)
 
 	musb_platform_suspend(musb);
 
-	clk_put(musb->clock);
-	musb->clock = NULL;
-
 	return 0;
 }
-- 
1.7.0.rc0.33.g7c3932

