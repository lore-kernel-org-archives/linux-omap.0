From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 4/7] drm/tilcdc: use pm_runtime_irq_safe()
Date: Wed, 27 May 2015 12:22:58 +0300
Message-ID: <8b81cedf6c5a7e93dc3df8284f4bc3cfa139888c.1432718049.git.jsarha@ti.com>
References: <cover.1432718049.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33708 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbbE0JXa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 05:23:30 -0400
In-Reply-To: <cover.1432718049.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

tilcdc calls runtime PM get/put functions everywhere. Some of those
places will be called in irq context, crashing the driver.

As a quick fix, use pm_runtime_irq_safe() for tilcdc.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index fcc0508..0f283a3 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -227,6 +227,7 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 	DBG("Maximum Pixel Clock Value %dKHz", priv->max_pixelclock);
 
 	pm_runtime_enable(dev->dev);
+	pm_runtime_irq_safe(dev->dev);
 
 	/* Determine LCD IP Version */
 	pm_runtime_get_sync(dev->dev);
-- 
1.9.1

