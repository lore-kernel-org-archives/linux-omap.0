From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/2] MUSB: Real fix bug 4 usb bugs found on Blackfin
Date: Sat, 17 May 2008 19:01:21 +0800
Message-ID: <1211022081-27298-3-git-send-email-cooloney@kernel.org>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:51477 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbYEQLBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 May 2008 07:01:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so529089wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 17 May 2008 04:01:38 -0700 (PDT)
In-Reply-To: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, david-b@pacbell.net, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>, Sonic Zhang <sonic.zhang@analog.com>

 - USB-IDE
   http://blackfin.uclinux.org/gf/project/linux-kernel/tracker/?action=TrackerItemEdit&tracker_item_id=3789
 - 30G iPod
   http://blackfin.uclinux.org/gf/project/linux-kernel/tracker/?action=TrackerItemEdit&tracker_item_id=3806
 - USB to CF/SD card reader
   http://blackfin.uclinux.org/gf/project/linux-kernel/tracker/?action=TrackerItemEdit&tracker_item_id=3790
   http://blackfin.uclinux.org/gf/project/linux-kernel/tracker/?action=TrackerItemEdit&tracker_item_id=3807

Sonic found, when we got STALL, we should clear the toggle.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/usb/musb/musb_host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 535922d..806c479 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1473,7 +1473,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
 		}
-		musb_h_flush_rxfifo(hw_ep, 0);
+		musb_h_flush_rxfifo(hw_ep, MUSB_RXCSR_CLRDATATOG);
 		musb_writeb(epio, MUSB_RXINTERVAL, 0);
 		done = true;
 		goto finish;
-- 
1.5.5

