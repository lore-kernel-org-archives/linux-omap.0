From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 5/6] drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
Date: Fri, 8 May 2015 14:27:18 +0300
Message-ID: <01ee4b1f38348086269830e636bbf96fe1c75796.1431083641.git.jsarha@ti.com>
References: <cover.1431083641.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbbEHL1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2015 07:27:51 -0400
In-Reply-To: <cover.1431083641.git.jsarha@ti.com>
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
index 7d4944e..6081fa6 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
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

