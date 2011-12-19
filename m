From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH v2 3/4] usb: musb: remove a bit of indentation
Date: Mon, 19 Dec 2011 22:17:50 +0200
Message-ID: <1324325871-15137-4-git-send-email-felipe.contreras@nokia.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51372 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1LSUUq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 15:20:46 -0500
In-Reply-To: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

And use dev instead of musb->controller.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/usb/musb/omap2430.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 6f574ec..521d806 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -344,20 +344,19 @@ static void omap2430_musb_enable(struct musb *musb)
 
 	case USB_EVENT_ID:
 		otg_init(musb->xceiv);
-		if (data->interface_type == MUSB_INTERFACE_UTMI) {
-			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-			/* start the session */
-			devctl |= MUSB_DEVCTL_SESSION;
-			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
-			while (musb_readb(musb->mregs, MUSB_DEVCTL) &
-						MUSB_DEVCTL_BDEVICE) {
-				cpu_relax();
-
-				if (time_after(jiffies, timeout)) {
-					dev_err(musb->controller,
-					"configured as A device timeout");
-					break;
-				}
+		if (data->interface_type != MUSB_INTERFACE_UTMI)
+			break;
+		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+		/* start the session */
+		devctl |= MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+		while (musb_readb(musb->mregs, MUSB_DEVCTL) &
+				MUSB_DEVCTL_BDEVICE) {
+			cpu_relax();
+
+			if (time_after(jiffies, timeout)) {
+				dev_err(dev, "configured as A device timeout");
+				break;
 			}
 		}
 		break;
-- 
1.7.8

