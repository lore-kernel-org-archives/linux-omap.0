From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/2] usb: musb: ignore disconnect on suspend
Date: Wed, 11 Jun 2008 14:07:12 +0300
Message-ID: <1213182432-23952-3-git-send-email-felipe.balbi@nokia.com>
References: <1213182432-23952-1-git-send-email-felipe.balbi@nokia.com>
 <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21626 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbYFKLI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 07:08:28 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5BB8Aca022327
	for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 14:08:25 +0300
In-Reply-To: <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

This still needed, otherwise tusb2.0 won't connect after
a power cycle.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 019898a..5b92f21 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -659,7 +659,11 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			switch (musb->xceiv.state) {
 #ifdef CONFIG_USB_OTG
 			case OTG_STATE_A_SUSPEND:
-				musb->ignore_disconnect = 0;
+				/* We need to ignore disconnect on suspend
+				 * otherwise tusb 2.0 won't reconnect after a
+				 * power cycle, which breaks otg compliance.
+				 */
+				musb->ignore_disconnect = 1;
 				musb_g_reset(musb);
 				/* FALLTHROUGH */
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
-- 
1.5.6.rc1

