From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 6/7] drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
Date: Fri, 6 Mar 2015 17:36:34 +0200
Message-ID: <59153f75fc48a34c9f36ebfdf7e6efe21bd03866.1425656120.git.jsarha@ti.com>
References: <cover.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbCFPhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 10:37:13 -0500
In-Reply-To: <cover.1425656120.git.jsarha@ti.com>
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
 drivers/gpu/drm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c239b9..ad7f10f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
 obj-$(CONFIG_DRM_TILCDC)	+= tilcdc/
+obj-$(CONFIG_DRM_TILCDC_SLAVE_COMPAT) += tilcdc/
 obj-$(CONFIG_DRM_QXL) += qxl/
 obj-$(CONFIG_DRM_BOCHS) += bochs/
 obj-$(CONFIG_DRM_MSM) += msm/
-- 
1.9.1

