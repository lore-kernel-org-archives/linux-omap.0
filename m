From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] MUSB: fix memory corruption when using more than max endpoints
Date: Wed, 10 Sep 2008 08:53:56 +0300
Message-ID: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34195 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYIJFyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 01:54:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

There is no check if platform code passes in more endpoints (num_eps)
than the maximum number of enpoints (MUSB_C_NUM_EPS.)  The result is
that allocate_instance() happily writes past the end of 'struct musb'
corrupting memory.

The fix below increases the max to 32 (used on omap3) and also adds a
BUG() if the platform code requests more than the max.

This memory corruption was triggering various forms of crashes/panics
with kmem_cache_alloc() in the backtrace.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/usb/musb/musb_core.c |    1 +
 drivers/usb/musb/musb_core.h |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c939f81..a132d9f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1806,6 +1806,7 @@ allocate_instance(struct device *dev,
 	musb->ctrl_base = mbase;
 	musb->nIrq = -ENODEV;
 	musb->config = config;
+	BUG_ON(musb->config->num_eps > MUSB_C_NUM_EPS);
 	for (epnum = 0, ep = musb->endpoints;
 			epnum < musb->config->num_eps;
 			epnum++, ep++) {
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 8222725..5040ceb 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -153,7 +153,7 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
 /****************************** CONSTANTS ********************************/
 
 #ifndef MUSB_C_NUM_EPS
-#define MUSB_C_NUM_EPS ((u8)16)
+#define MUSB_C_NUM_EPS ((u8)32)
 #endif
 
 #ifndef MUSB_MAX_END0_PACKET
-- 
1.6.0

