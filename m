From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 06/11] MUSB: Blackfin: remove musb_platform_{suspend|resume}()
Date: Thu, 25 Mar 2010 13:25:23 +0200
Message-ID: <1269516328-28267-7-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38522 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0CYL0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:36 -0400
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

These functions do nothing and also are both unnecessarily 'extern'; actually,
musb_platform_resume() in not even called...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/blackfin.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 7372ef9..95db366 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -393,22 +393,10 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 	return 0;
 }
 
-int musb_platform_suspend(struct musb *musb)
-{
-	return 0;
-}
-
-int musb_platform_resume(struct musb *musb)
-{
-	return 0;
-}
-
-
 int musb_platform_exit(struct musb *musb)
 {
 
 	gpio_free(musb->config->gpio_vrsel);
-	musb_platform_suspend(musb);
 
 	return 0;
 }
-- 
1.7.0.rc0.33.g7c3932

