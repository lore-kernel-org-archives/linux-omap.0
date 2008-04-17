From: Felipe Balbi <felipebalbi@nokia.com>
Subject: [PATCH] USB: MUSB: Don't ignore disconnect on suspend
Date: Thu, 17 Apr 2008 17:38:35 +0300
Message-ID: <1208443115-26371-1-git-send-email-felipebalbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52030 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbYDQOjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:39:43 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3HEclfU008893
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 17:39:40 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

As soon as a usb device is disconnect we should
fall into a_wait_bcon state, ignoring disconnect
irq will prevent this behaviour.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c5816a2..019898a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -659,7 +659,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			switch (musb->xceiv.state) {
 #ifdef CONFIG_USB_OTG
 			case OTG_STATE_A_SUSPEND:
-				musb->ignore_disconnect = 1;
+				musb->ignore_disconnect = 0;
 				musb_g_reset(musb);
 				/* FALLTHROUGH */
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
-- 
1.5.5.49.gf43e2

