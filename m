From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/21] drm/omap: fix race condition with dev->obj_list
Date: Thu, 26 Feb 2015 15:20:27 +0200
Message-ID: <1424956829-22892-20-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbbBZNVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:30 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_gem_objects are added to dev->obj_list in omap_gem_new, and removed
in omap_gem_free_object. Unfortunately there's no locking for
dev->obj_list, which eventually leads to a crash:

WARNING: CPU: 1 PID: 1123 at lib/list_debug.c:59 __list_del_entry+0xa4/0xe0()
list_del corruption. prev->next should be e9281344, but was ea722b84

Add a spinlock to protect dev->obj_list.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 1 +
 drivers/gpu/drm/omapdrm/omap_drv.h | 3 +++
 drivers/gpu/drm/omapdrm/omap_gem.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index d0b1aece8cc5..2a85221e0604 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -479,6 +479,7 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 
 	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
 
+	spin_lock_init(&priv->list_lock);
 	INIT_LIST_HEAD(&priv->obj_list);
 
 	omap_gem_init(dev);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 60e47b33c801..dac9f8ef3b15 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -105,6 +105,9 @@ struct omap_drm_private {
 
 	struct workqueue_struct *wq;
 
+	/* lock for obj_list below */
+	spinlock_t list_lock;
+
 	/* list of GEM objects: */
 	struct list_head obj_list;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d37ee756a0b1..e9718b99a8a9 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1273,13 +1273,16 @@ unlock:
 void omap_gem_free_object(struct drm_gem_object *obj)
 {
 	struct drm_device *dev = obj->dev;
+	struct omap_drm_private *priv = dev->dev_private;
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
 
 	evict(obj);
 
 	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
 
+	spin_lock(&priv->list_lock);
 	list_del(&omap_obj->mm_list);
+	spin_unlock(&priv->list_lock);
 
 	drm_gem_free_mmap_offset(obj);
 
@@ -1377,7 +1380,9 @@ struct drm_gem_object *omap_gem_new(struct drm_device *dev,
 	if (!omap_obj)
 		goto fail;
 
+	spin_lock(&priv->list_lock);
 	list_add(&omap_obj->mm_list, &priv->obj_list);
+	spin_unlock(&priv->list_lock);
 
 	obj = &omap_obj->base;
 
-- 
2.3.0

