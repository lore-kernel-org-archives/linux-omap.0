From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/21] drm/omap: tiler: fix race condition with engine->async
Date: Thu, 26 Feb 2015 15:20:20 +0200
Message-ID: <1424956829-22892-13-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076AbbBZNVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:18 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The tiler irq handler uses engine->async value, but the code that sets
engine->async and enables the interrupt does not have a barrier. This
may cause the irq handler to see the old value of engine->async, causing
memory corruption.

Reported-by: Harinarayan Bhatta <harinarayan@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index ef3d14d9cfa1..c4563af55a82 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -273,6 +273,8 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
 
 	/* mark whether it is async to denote list management in IRQ handler */
 	engine->async = wait ? false : true;
+	/* verify that the irq handler sees the 'async' value */
+	smp_mb();
 
 	/* kick reload */
 	writel(engine->refill_pa,
-- 
2.3.0

