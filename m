From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Thu,  8 Jan 2009 18:01:36 +0530
Message-ID: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607AbZAHMcI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2009 07:32:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Mode bit should be set based on function parameter "mode" of
configure_channel() function.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musbhsdma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a23d005..d87c6c7 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -225,13 +225,14 @@ static void configure_channel(struct dma_channel *channel,
 			csr |= MUSB_HSDMA_BURSTMODE_INCR4;
 
 		csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
-			| MUSB_HSDMA_MODE1
 			| MUSB_HSDMA_ENABLE
 			| MUSB_HSDMA_IRQENABLE
 			| (musb_channel->transmit
 					? MUSB_HSDMA_TRANSMIT
 					: 0);
 
+		if (mode)
+			csr |= MUSB_HSDMA_MODE1;
 		/* address/count */
 		musb_write_hsdma_addr(mbase, bchannel, dma_addr);
 		musb_write_hsdma_count(mbase, bchannel, len);
-- 
1.5.6

