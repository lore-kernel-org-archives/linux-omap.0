From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 08/16] usb: musb: workaround toggle bug when doing bulk transfer after isoc
Date: Tue, 19 Jan 2010 15:14:07 +0200
Message-ID: <1263906855-28341-9-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27327 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0ASNO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:59 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Swaminathan S <swami.iyer@ti.com>

This patch implements the work around for a Mentor controller related
bug where it's observed a BULK Tx toggle error on the bus when a
BULK IO gets scheduled on an endpoint that was earlier used for
handling ISOC transaction and needed to start on 1 toggle.  When such
a situation arises even if the TXCSR toggle bits are programmed
correctly by the musb driver the data gets transmitted with 0 toggle
which leads to toggle error on the bus and the BULK transaction fails.
In case of MSC write, the device gets reset by the Host.

This Mentor bug is observed on almost all Mentor versions (1.3, 1.5,
1.8).  Confirmed on DM644x, DM355, DM365, OMAPL13x platforms.

Signed-off-by: Swaminathan S <swami.iyer@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_host.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 74c4c36..c3fdd6d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1771,6 +1771,9 @@ static int musb_schedule(
 	int			best_end, epnum;
 	struct musb_hw_ep	*hw_ep = NULL;
 	struct list_head	*head = NULL;
+	u8			toggle;
+	u8			txtype;
+	struct urb		*urb = next_urb(qh);
 
 	/* use fixed hardware for control and bulk */
 	if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
@@ -1809,6 +1812,27 @@ static int musb_schedule(
 		diff -= (qh->maxpacket * qh->hb_mult);
 
 		if (diff >= 0 && best_diff > diff) {
+
+			/*
+			 * Mentor controller has a bug in that if we schedule
+			 * a BULK Tx transfer on an endpoint that had earlier
+			 * handled ISOC then the BULK transfer has to start on
+			 * a zero toggle.  If the BULK transfer starts on a 1
+			 * toggle then this transfer will fail as the mentor
+			 * controller starts the Bulk transfer on a 0 toggle
+			 * irrespective of the programming of the toggle bits
+			 * in the TXCSR register.  Check for this condition
+			 * while allocating the EP for a Tx Bulk transfer.  If
+			 * so skip this EP.
+			 */
+			hw_ep = musb->endpoints + epnum;
+			toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
+			txtype = (musb_readb(hw_ep->regs, MUSB_TXTYPE)
+					>> 4) & 0x3;
+			if (!is_in && (qh->type == USB_ENDPOINT_XFER_BULK) &&
+				toggle && (txtype == USB_ENDPOINT_XFER_ISOC))
+				continue;
+
 			best_diff = diff;
 			best_end = epnum;
 		}
-- 
1.6.6.rc0

