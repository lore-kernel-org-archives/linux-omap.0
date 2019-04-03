From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv6 1/4] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
Date: Wed,  3 Apr 2019 22:13:23 +0200
Message-ID: <20190403201326.3127-2-sebastian.reichel@collabora.com>
References: <20190403195413.djfrgzuj7povdksi@earth.universe>
 <20190403201326.3127-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403201326.3127-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

This macro is only used by omapdrm, which should print
debug messages using the DRIVER category instead of the
default CORE category.

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 3cca45cb25f3..896aa12f09b2 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -37,8 +37,8 @@
 #include "omap_irq.h"
 #include "omap_plane.h"
 
-#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
-#define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
+#define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
+#define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__) /* verbose debug */
 
 #define MODULE_NAME     "omapdrm"
 
-- 
2.20.1
