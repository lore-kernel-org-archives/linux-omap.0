From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 03/11] MUSB: OMAP: remove omap_vbus_power()
Date: Wed, 24 Mar 2010 14:55:10 +0200
Message-ID: <1269435318-29153-4-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51977 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab0CXM4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:56:22 -0400
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

This function does nothing...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index f8cc636..218df2c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -146,10 +146,6 @@ void musb_platform_enable(struct musb *musb)
 void musb_platform_disable(struct musb *musb)
 {
 }
-static void omap_vbus_power(struct musb *musb, int is_on, int sleeping)
-{
-}
-
 static void omap_set_vbus(struct musb *musb, int is_on)
 {
 	u8		devctl;
@@ -256,8 +252,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 			musb_readl(musb->mregs, OTG_INTERFSEL),
 			musb_readl(musb->mregs, OTG_SIMENABLE));
 
-	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
-
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = omap_set_vbus;
 
@@ -337,8 +331,6 @@ static int musb_platform_resume(struct musb *musb)
 int musb_platform_exit(struct musb *musb)
 {
 
-	omap_vbus_power(musb, 0 /*off*/, 1);
-
 	musb_platform_suspend(musb);
 
 	return 0;
-- 
1.7.0.rc0.33.g7c3932

