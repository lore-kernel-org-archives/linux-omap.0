From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] usb: musb: log VBUS error
Date: Sun, 10 Mar 2013 02:49:28 +0200
Message-ID: <1362876568-7082-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:48325 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3CJAte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 19:49:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

VBUS_ERROR is a serious error that the driver often doesn't recover from
in my tests, so we should at least inform the user about it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f95404e..df6a54e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -602,7 +602,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			break;
 		}
 
-		dev_dbg(musb->controller, "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
+		dev_printk(ignore ? KERN_DEBUG : KERN_ERR, musb->controller,
+			   "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
 				otg_state_string(musb->xceiv->state),
 				devctl,
 				({ char *s;
-- 
1.7.9.5

