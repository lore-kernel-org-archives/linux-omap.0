From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] usb: musb: honour initial transceiver state
Date: Sun, 10 Mar 2013 02:48:55 +0200
Message-ID: <1362876535-6970-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:62374 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3CJAtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 19:49:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

As the OTG transceiver driver usually starts first, it should already
have default_a variable set according to ID pin state, so don't
override it. In case default_a was not changed by trasceiver, it will
default to 0 and this code will work as before.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/musb_core.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 60b41cc..f95404e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1955,9 +1955,13 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb_write_ulpi_buscontrol(musb->mregs, busctl);
 	}
 
-	MUSB_DEV_MODE(musb);
-	musb->xceiv->otg->default_a = 0;
-	musb->xceiv->state = OTG_STATE_B_IDLE;
+	if (musb->xceiv->otg->default_a) {
+		MUSB_HST_MODE(musb);
+		musb->xceiv->state = OTG_STATE_A_IDLE;
+	} else {
+		MUSB_DEV_MODE(musb);
+		musb->xceiv->state = OTG_STATE_B_IDLE;
+	}
 
 	status = musb_gadget_setup(musb);
 
-- 
1.7.9.5

