From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] omapdrm: use alloc_ordered_workqueue() instead of UNBOUND
 w/ max_active = 1
Date: Wed, 22 Aug 2012 16:49:44 -0700
Message-ID: <20120822234944.GS19212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <rob@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an equivalent conversion and will ease scheduled removal of
WQ_NON_REENTRANT.

Only compile tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/staging/omapdrm/omap_drv.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 4beab94..672cb3a 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -571,8 +571,7 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 
 	dev->dev_private = priv;
 
-	priv->wq = alloc_workqueue("omapdrm",
-			WQ_UNBOUND | WQ_NON_REENTRANT, 1);
+	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
 
 	INIT_LIST_HEAD(&priv->obj_list);
 
