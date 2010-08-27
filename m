From: tom.leiming@gmail.com
Subject: [PATCH 2/2] USB: musb-gadget: fix OUT transfer in double buffer case
Date: Fri, 27 Aug 2010 19:37:48 +0800
Message-ID: <1282909068-2968-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60351 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0H0LiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 07:38:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: Ming Lei <tom.leiming@gmail.com>

This patch fixes two bugs of OUT transfer in double buffer case:

	-USE_MODE1 should be enabled except for ANOMALY_05000456 case, or
	else may cause infinite hang and data error bug in double buffer

	-DMA length should not go beyond the availabe space of request buffer

Without this patch, test #5 of usbtest can't be passed if we configure musb as
g_zero and use fifo mode 3 to enable double buffer mode.

With this patch, on my beagle B5, test#5(queued bulk out) may go beyond 14Mbyte/s
if musb is configured as g_zero and fifo mode 3 is taken, follows the test command:

	#./testusb -D DEV_NAME -c 1024 -t 5 -s 32768 -g 8   [1]

[1],
    -source of testusb : tools/usb/testusb.c under linux kernel;

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/usb/musb/musb_dma.h    |    2 ++
 drivers/usb/musb/musb_gadget.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 916065b..dff91ce 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -89,6 +89,8 @@ struct musb_hw_ep;
 # if !ANOMALY_05000456
 #  define USE_MODE1
 # endif
+#else
+#  define USE_MODE1
 #endif
 
 /*
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index e0bd1c1..f1c44b9 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -662,10 +662,11 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				if (request->actual < request->length) {
 					int transfer_size = 0;
 #ifdef USE_MODE1
-					transfer_size = min(request->length,
+					transfer_size = min(request->length - request->actual,
 							channel->max_len);
 #else
-					transfer_size = len;
+					transfer_size = min(request->length - request->actual,
+							len);
 #endif
 					if (transfer_size <= musb_ep->packet_sz)
 						musb_ep->dma->desired_mode = 0;
-- 
1.6.2.5

