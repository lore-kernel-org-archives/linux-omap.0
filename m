From: btucker@mpcdata.com
Subject: [PATCH] OMAP2,3: DSS2: Report -EBUSY when to many registered isr
Date: Wed, 19 Jan 2011 14:42:34 +0000 (UTC)
Message-ID: <1295585610-24179-1-git-send-email-btucker@mpcdata.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35191 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab1ASOm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 09:42:28 -0500
Received: by wyb28 with SMTP id 28so1005348wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 06:42:27 -0800 (PST)
Date: Fri, 21 Jan 2011 04:53:30 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ben Tucker <btucker@mpc-data.co.uk>

From: Ben Tucker <btucker@mpc-data.co.uk>

This patch fixes a problem with map_dispc_register_isr() where it
fails to return -EBUSY if it has no more space for registrations.
---
 drivers/video/omap2/dss/dispc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e0e8275..f566177 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2579,6 +2579,10 @@ int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 		break;
 	}
 
+    if (ret) {
+        goto err;
+    }
+
 	_omap_dispc_set_irqs();
 
 	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-- 
1.7.3.2

