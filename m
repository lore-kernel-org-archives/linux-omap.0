From: tom.leiming@gmail.com
Subject: [PATCH 1/2] USB: musb-gadget: fix bulk IN infinite hangs in double buffer case
Date: Fri, 27 Aug 2010 19:37:20 +0800
Message-ID: <1282909040-2936-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:60423 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab0H0Lht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 07:37:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: Ming Lei <tom.leiming@gmail.com>

This patch fixes one infinite hang of bulk IN transfer in double buffer
case, the hang can be observed easily by test #6 of usbtest if musb is
configured as g_zero and fifo mode 3 is taken to enable double fifo.

In fact, the patch only removes the check for non-empty fifo before
loading data from new request into fifo since the check is not correct:

	-in double buffer case, fifo may accommodate more than one packet,
	even though it has contained one packet already and is non-empty

	-since last DMA is completed before calling musb_g_tx, it is sure
	that fifo may accommodate at least one packet

Without applying the patch, new requst enqueued from .complte may not
have a chance to be loaded into fifo, then will never be completed and
cause infinite hangs.

With the patch, on my beagle B5, test#6(queued bulk in) can be passed and
test result may go beyond 33Mbyte/s if musb is configured as g_zero and
fifo mode 3 is taken, follows the test command:

	#testusb -D DEV_NAME -c 1024 -t 6 -s 32768 -g 8   [1]

[1],
    -source of testusb : tools/usb/testusb.c under linux kernel;

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/usb/musb/musb_gadget.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 550b397..e0bd1c1 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -506,18 +506,6 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			/* ... or if not, then complete it. */
 			musb_g_giveback(musb_ep, request, 0);
 
-			/*
-			 * Kickstart next transfer if appropriate;
-			 * the packet that just completed might not
-			 * be transmitted for hours or days.
-			 * REVISIT for double buffering...
-			 * FIXME revisit for stalls too...
-			 */
-			musb_ep_select(mbase, epnum);
-			csr = musb_readw(epio, MUSB_TXCSR);
-			if (csr & MUSB_TXCSR_FIFONOTEMPTY)
-				return;
-
 			request = musb_ep->desc ? next_request(musb_ep) : NULL;
 			if (!request) {
 				DBG(4, "%s idle now\n",
-- 
1.6.2.5

