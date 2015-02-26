From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/21] drm/omap: do not use BUG_ON(!spin_is_locked(x))
Date: Thu, 26 Feb 2015 15:20:26 +0200
Message-ID: <1424956829-22892-19-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38346 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbbBZNV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:28 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

spin_is_locked(x) returns always 0 on uniprocessor, triggering BUG() in
omapdrm.

Change it to use assert_spin_locked() to fix the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index f035d2bceae7..3eb097efc488 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -34,7 +34,7 @@ static void omap_irq_update(struct drm_device *dev)
 	struct omap_drm_irq *irq;
 	uint32_t irqmask = priv->vblank_mask;
 
-	BUG_ON(!spin_is_locked(&list_lock));
+	assert_spin_locked(&list_lock);
 
 	list_for_each_entry(irq, &priv->irq_list, node)
 		irqmask |= irq->irqmask;
-- 
2.3.0

