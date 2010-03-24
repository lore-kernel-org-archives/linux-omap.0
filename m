From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 04/11] MUSB: Blackfin: remove bfin_vbus_power()
Date: Wed, 24 Mar 2010 14:55:11 +0200
Message-ID: <1269435318-29153-5-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56429 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab0CXM4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:56:10 -0400
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

This function does nothing...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

--
The patch is against the recent Linus' tree plus the series of 6 fixes posted
yesterday...

 drivers/usb/musb/blackfin.c |    7 -------
 1 file changed, 7 deletions(-)
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/blackfin.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 78f33b9..7372ef9 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -290,10 +290,6 @@ void musb_platform_disable(struct musb *musb)
 {
 }
 
-static void bfin_vbus_power(struct musb *musb, int is_on, int sleeping)
-{
-}
-
 static void bfin_set_vbus(struct musb *musb, int is_on)
 {
 	int value = musb->config->gpio_vrsel_active;
@@ -411,7 +407,6 @@ int musb_platform_resume(struct musb *musb)
 int musb_platform_exit(struct musb *musb)
 {
 
-	bfin_vbus_power(musb, 0 /*off*/, 1);
 	gpio_free(musb->config->gpio_vrsel);
 	musb_platform_suspend(musb);
 
-- 
1.7.0.rc0.33.g7c3932

