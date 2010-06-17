From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/8] usb: musb: Enable the maximum supported burst mode for DMA
Date: Thu, 17 Jun 2010 16:10:39 +0530
Message-ID: <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759754Ab0FQKk5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jun 2010 06:40:57 -0400
In-Reply-To: <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Hema HK <hemahk@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Hema HK <hemahk@ti.com>

Setting MUSB Burst Mode 3 automatically enables support for
lower burst modes (BURST4, BURST8, BURST16 or bursts of unspecified
length). There is no need to set these burst modes based on the
packet size. Also enable the burst mode for both mode1 and mode0.

This is a fix for buggy hardware - having the lower burst modes
enabled can potentially cause lockups of the DMA engine used in
OMAP2/3/4 chips.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musbhsdma.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 1008044..dc66e43 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -132,18 +132,9 @@ static void configure_channel(struct dma_channel *channel,
 	if (mode) {
 		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
 		BUG_ON(len < packet_sz);
-
-		if (packet_sz >= 64) {
-			csr |= MUSB_HSDMA_BURSTMODE_INCR16
-					<< MUSB_HSDMA_BURSTMODE_SHIFT;
-		} else if (packet_sz >= 32) {
-			csr |= MUSB_HSDMA_BURSTMODE_INCR8
-					<< MUSB_HSDMA_BURSTMODE_SHIFT;
-		} else if (packet_sz >= 16) {
-			csr |= MUSB_HSDMA_BURSTMODE_INCR4
-					<< MUSB_HSDMA_BURSTMODE_SHIFT;
-		}
 	}
+	csr |= MUSB_HSDMA_BURSTMODE_INCR16
+				<< MUSB_HSDMA_BURSTMODE_SHIFT;
 
 	csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
 		| (1 << MUSB_HSDMA_ENABLE_SHIFT)
-- 
1.6.2.4

