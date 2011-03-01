From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 08/19] usb: musb: tusb: Fix possible null pointer dereference in tusb6010_omap.c
Date: Tue,  1 Mar 2011 17:15:29 +0200
Message-ID: <1298992540-5984-9-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55510 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756612Ab1CAPQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:26 -0500
In-Reply-To: <1298992540-5984-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Huzaifa Sidhpurwala <huzaifas@redhat.com>, Felipe Balbi <balbi@ti.com>

From: Huzaifa Sidhpurwala <huzaifas@redhat.com>

tusb_dma was being dereferenced when it was nul

Signed-off-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/tusb6010_omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index c061a88..99cb541 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -680,7 +680,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 
 	tusb_dma = kzalloc(sizeof(struct tusb_omap_dma), GFP_KERNEL);
 	if (!tusb_dma)
-		goto cleanup;
+		goto out;
 
 	tusb_dma->musb = musb;
 	tusb_dma->tbase = musb->ctrl_base;
@@ -721,6 +721,6 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 
 cleanup:
 	dma_controller_destroy(&tusb_dma->controller);
-
+out:
 	return NULL;
 }
-- 
1.7.4.rc2

