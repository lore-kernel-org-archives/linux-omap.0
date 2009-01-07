From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/3] usb: musb: fix bug in musb_free() w.r.t free_irq()
Date: Wed,  7 Jan 2009 16:43:49 +0530
Message-ID: <1231326829-22638-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35914 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbZAGLOG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 06:14:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes insert module failure as free_irq() was not
done in previous rmmod.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f71fab6..2447e3a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1824,8 +1824,9 @@ static void musb_free(struct musb *musb)
 	musb_gadget_cleanup(musb);
 #endif
 
-	if (musb->nIrq >= 0 && musb->irq_wake) {
-		disable_irq_wake(musb->nIrq);
+	if (musb->nIrq >= 0) {
+		if (musb->irq_wake)
+			disable_irq_wake(musb->nIrq);
 		free_irq(musb->nIrq, musb);
 	}
 	if (is_dma_capable() && musb->dma_controller) {
-- 
1.5.6

