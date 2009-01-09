From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v2] usb: musb: fix bug in musbhsdma programming
Date: Fri,  9 Jan 2009 10:09:06 +0530
Message-ID: <1231475946-6810-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37944 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbZAIEjk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2009 23:39:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Mode bit should be set based on function parameter "mode" of
configure_channel() function.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Original version of this patch is at,
http://marc.info/?l=linux-usb&m=123141793611158&w=2

 drivers/usb/musb/musbhsdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 75b15ce..8e44355 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -136,7 +136,7 @@ static void configure_channel(struct dma_channel *channel,
 		csr |= MUSB_HSDMA_BURSTMODE_INCR4;
 
 	csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
-		| MUSB_HSDMA_MODE1
+		| mode ? MUSB_HSDMA_MODE1 : 0
 		| MUSB_HSDMA_ENABLE
 		| MUSB_HSDMA_IRQENABLE
 		| (musb_channel->transmit
-- 
1.5.6

