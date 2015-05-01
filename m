From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] usb: musb: Get rid of the DMA ifdefs for musb_core.c
Date: Fri,  1 May 2015 12:29:29 -0700
Message-ID: <1430508578-5208-4-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i373.relay.mailchannels.net ([174.136.5.175]:11989 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbbEATaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:30:05 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

For musb_core.c we can now just drop the DMA related
ifdef and use the already existing runtime test for
!is_cppi_enabled(musb) instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5f35ecdc..237f7c8 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1667,7 +1667,6 @@ void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit)
 	/* called with controller lock already held */
 
 	if (!epnum) {
-#ifndef CONFIG_USB_TUSB_OMAP_DMA
 		if (!is_cppi_enabled(musb)) {
 			/* endpoint 0 */
 			if (is_host_active(musb))
@@ -1675,7 +1674,6 @@ void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit)
 			else
 				musb_g_ep0_irq(musb);
 		}
-#endif
 	} else {
 		/* endpoints 1..15 */
 		if (transmit) {
-- 
2.1.4

