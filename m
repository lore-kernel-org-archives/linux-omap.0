From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] usb: musb: Update FIFO mode_5_cfg to accomodate 4K
Date: Tue,  4 May 2010 14:32:02 +0530
Message-ID: <1272963722-8659-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756936Ab0EDJCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 05:02:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

FIFO table fifo_5_cfg was added so that it can be used as a
workaround for OMAP34x/35x errata which limits the FIFO space
uses to be within first 8K or next 8K.

Updating this table to accomodate an endpoint of 4K so that
the same table can be used for high bandwidth transfers as
used by some USB cameras.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 705cc4a..4e327f5 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1089,10 +1089,10 @@ static struct fifo_cfg __initdata mode_5_cfg[] = {
 { .hw_ep_num =  2, .style = FIFO_RX,   .maxpacket = 512, },
 { .hw_ep_num =  3, .style = FIFO_TX,   .maxpacket = 512, },
 { .hw_ep_num =  3, .style = FIFO_RX,   .maxpacket = 512, },
-{ .hw_ep_num =  4, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num =  4, .style = FIFO_RX,   .maxpacket = 512, },
-{ .hw_ep_num =  5, .style = FIFO_TX,   .maxpacket = 512, },
-{ .hw_ep_num =  5, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  4, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  4, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num =  5, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  5, .style = FIFO_RX,   .maxpacket = 32, },
 { .hw_ep_num =  6, .style = FIFO_TX,   .maxpacket = 32, },
 { .hw_ep_num =  6, .style = FIFO_RX,   .maxpacket = 32, },
 { .hw_ep_num =  7, .style = FIFO_TX,   .maxpacket = 32, },
@@ -1107,9 +1107,9 @@ static struct fifo_cfg __initdata mode_5_cfg[] = {
 { .hw_ep_num = 11, .style = FIFO_RX,   .maxpacket = 32, },
 { .hw_ep_num = 12, .style = FIFO_TX,   .maxpacket = 32, },
 { .hw_ep_num = 12, .style = FIFO_RX,   .maxpacket = 32, },
-{ .hw_ep_num = 13, .style = FIFO_RXTX, .maxpacket = 512, },
-{ .hw_ep_num = 14, .style = FIFO_RXTX, .maxpacket = 1024, },
-{ .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
+{ .hw_ep_num = 13, .style = FIFO_RXTX, .maxpacket = 128, },
+{ .hw_ep_num = 14, .style = FIFO_RXTX, .maxpacket = 256, },
+{ .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 4096, },
 };
 
 /*
-- 
1.6.2.4

