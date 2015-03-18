From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 5/7] drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
Date: Wed, 18 Mar 2015 11:06:34 +0200
Message-ID: <74b9c5a951e5bd3a115f972bd825d7d89e74a98b.1426668480.git.jsarha@ti.com>
References: <cover.1426668480.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbbCRJH0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 05:07:26 -0400
In-Reply-To: <cover.1426668480.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

If I read Documentation/kbuild/makefiles.txt section 3.6 right, this
patch should not be needed. However, without this patch the objects
needed for DRM_TILCDC_SLAVE_COMPAT are not linked, if DRM_TILCDC is
built as module.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c239b9..c93ca0e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
 obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
-obj-$(CONFIG_DRM_TILCDC)	+= tilcdc/
+obj-y			+= tilcdc/
 obj-$(CONFIG_DRM_QXL) += qxl/
 obj-$(CONFIG_DRM_BOCHS) += bochs/
 obj-$(CONFIG_DRM_MSM) += msm/
-- 
1.9.1

