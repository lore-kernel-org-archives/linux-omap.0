From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 05/16] USB: musb: Add new fifo table for a OMAP3 errata
Date: Tue, 19 Jan 2010 15:14:04 +0200
Message-ID: <1263906855-28341-6-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27297 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0ASNOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:52 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

We have observed MSC data read corruption when USB LAN device is
also connected and it's interface is up.

Silicon team has confirmed an errata where in all the active
transfers should use FIFO space either in first 8K or next 8K.
So far we have observed the issue in above use case scenario.

As a workaround to it, adding a new FIFO config (5) fitting well
within first 8K which can be used for such use cases.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b7e2d1b..c489326 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1095,6 +1095,36 @@ static struct fifo_cfg __initdata mode_4_cfg[] = {
 { .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
 };
 
+/* mode 5 - fits in 8KB */
+static struct fifo_cfg __initdata mode_5_cfg[] = {
+{ .hw_ep_num =  1, .style = FIFO_TX,   .maxpacket = 512, },
+{ .hw_ep_num =  1, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  2, .style = FIFO_TX,   .maxpacket = 512, },
+{ .hw_ep_num =  2, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  3, .style = FIFO_TX,   .maxpacket = 512, },
+{ .hw_ep_num =  3, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  4, .style = FIFO_TX,   .maxpacket = 512, },
+{ .hw_ep_num =  4, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  5, .style = FIFO_TX,   .maxpacket = 512, },
+{ .hw_ep_num =  5, .style = FIFO_RX,   .maxpacket = 512, },
+{ .hw_ep_num =  6, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  6, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num =  7, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  7, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num =  8, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  8, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num =  9, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num =  9, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num = 10, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num = 10, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num = 11, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num = 11, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num = 12, .style = FIFO_TX,   .maxpacket = 32, },
+{ .hw_ep_num = 12, .style = FIFO_RX,   .maxpacket = 32, },
+{ .hw_ep_num = 13, .style = FIFO_RXTX, .maxpacket = 512, },
+{ .hw_ep_num = 14, .style = FIFO_RXTX, .maxpacket = 1024, },
+{ .hw_ep_num = 15, .style = FIFO_RXTX, .maxpacket = 1024, },
+};
 
 /*
  * configure a fifo; for non-shared endpoints, this may be called
@@ -1210,6 +1240,10 @@ static int __init ep_config_from_table(struct musb *musb)
 		cfg = mode_4_cfg;
 		n = ARRAY_SIZE(mode_4_cfg);
 		break;
+	case 5:
+		cfg = mode_5_cfg;
+		n = ARRAY_SIZE(mode_5_cfg);
+		break;
 	}
 
 	printk(KERN_DEBUG "%s: setup fifo_mode %d\n",
-- 
1.6.6.rc0

