From: tom.leiming@gmail.com
Subject: [PATCH 2/2] USB: musb-gadget: fix DMA length for OUT transfer
Date: Fri, 27 Aug 2010 22:52:32 +0800
Message-ID: <1282920752-12490-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56187 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab0H0OxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:53:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: Ming Lei <tom.leiming@gmail.com>

DMA length should not go beyond the availabe space of request buffer,
so fix it.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/usb/musb/musb_gadget.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index c0dfec4..e898228 100644
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

