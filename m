From: ajay.gupta@ti.com
Subject: [PATCH] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 12:00:56 +0530
Message-ID: <1219386656-31072-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYHVGbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Aug 2008 02:31:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, felipe.balbi@nokia.com, ajaykuee@gmail.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes kernel panic while ISO IN transfer is aborted.Replaced usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback() to make sure urb is unlinked before giveback when __musb_giveback() is called from musb_urb_dequeue().

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_host.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 93b0678..a889ac4 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -292,6 +292,7 @@ __acquires(musb->lock)
 			);
 
 	spin_unlock(&musb->lock);
+	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
 	usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
 	spin_lock(&musb->lock);
 }
@@ -353,8 +354,6 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 		break;
 	}
 
-	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
-
 	qh->is_ready = 0;
 	__musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
-- 
1.5.6

