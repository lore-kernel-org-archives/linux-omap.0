From: tom.leiming@gmail.com
Subject: [PATCH 1/2] USB: musb-gadget: enable autoclear for OUT transfer in both DMA 0 and DMA 1
Date: Fri, 27 Aug 2010 22:52:03 +0800
Message-ID: <1282920723-12459-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59413 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0H0Owg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:52:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: Ming Lei <tom.leiming@gmail.com>

This patch fixes one bugs of OUT transfer in double buffer case:

-the current code only enable autoclear for dma mode 1, and not
for dma mode 0

Without this patch, test #5 of usbtest can't be passed if we
configure musb as g_zero and use fifo mode 3 to enable double
buffer mode.

With this patch and the following patch(fix dma length),
on my beagle B5, test#5(queued bulk out) may go beyond
18Mbyte/s(seems dma mode 0 is quicker in double buffer case)
if musb is configured as g_zero and fifo mode 3 is taken, follows
the test command:

    #./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8   [1]

Also I have tested this patch can't make g_ether broken.

[1],
    -source of testusb : tools/usb/testusb.c under linux kernel;

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/usb/musb/musb_gadget.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index e0bd1c1..c0dfec4 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -645,9 +645,9 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 */
 
 				csr |= MUSB_RXCSR_DMAENAB;
-#ifdef USE_MODE1
 				if (!musb_ep->hb_mult)
 					csr |= MUSB_RXCSR_AUTOCLEAR;
+#ifdef USE_MODE1
 				/* csr |= MUSB_RXCSR_DMAMODE; */
 
 				/* this special sequence (enabling and then
-- 
1.6.2.5

