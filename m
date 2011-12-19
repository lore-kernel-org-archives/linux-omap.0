From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH v2 1/4] usb: musb: fix pm_runtime mismatches
Date: Mon, 19 Dec 2011 22:17:48 +0200
Message-ID: <1324325871-15137-2-git-send-email-felipe.contreras@nokia.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51282 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163Ab1LSUUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 15:20:34 -0500
In-Reply-To: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

Properly call pm_runtime_put() afer pm_runttime_get() on errors.
Comments from Alan Stern.

Untested.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/usb/musb/musb_gadget.c |    1 +
 drivers/usb/musb/omap2430.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 922148f..4d6a37a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1960,6 +1960,7 @@ static int musb_gadget_start(struct usb_gadget *g,
 err2:
 	if (!is_otg_enabled(musb))
 		musb_stop(musb);
+	pm_runtime_put_sync(musb->controller);
 err0:
 	return retval;
 }
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ba85f27..1a5d45e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -389,6 +389,7 @@ static int omap2430_musb_exit(struct musb *musb)
 
 	omap2430_low_level_exit(musb);
 	otg_put_transceiver(musb->xceiv);
+	pm_runtime_put_sync(musb->controller);
 
 	return 0;
 }
-- 
1.7.8

