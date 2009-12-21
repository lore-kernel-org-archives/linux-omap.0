From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: Add new fifo table for a OMAP3 errata
Date: Mon, 21 Dec 2009 14:59:29 +0530
Message-ID: <1261387769-20247-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZLUJ3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 04:29:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

We have observed MSC data read corruption when USB LAN device is
also connected and it's interface is up.

Silicon team has confirmed an errata where in all the active
transfers should use FIFO space either in first 8K or next 8K.
So far we have observed the issue in above use case scenario.

As a workaround to it, adding a new FIFO config (5) fitting well
within first 8K which can be used for such use cases.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index bfe08f4..0c8f5ec 100644
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
1.6.2.4

