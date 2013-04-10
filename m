From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP2+: Enable DT usage during dmm create
Date: Wed, 10 Apr 2013 15:50:43 -0500
Message-ID: <1365627043-11846-3-git-send-email-andy.gross@ti.com>
References: <1365627043-11846-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37370 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531Ab3DJUvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 16:51:04 -0400
In-Reply-To: <1365627043-11846-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

If DMM device tree information is present, use it for creating the
device.  Otherwise fall back to using the hwmod entry.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 arch/arm/mach-omap2/drm.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 59a4af7..e1e20ec 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/omap_drm.h>
+#include <linux/of.h>
 
 #include "soc.h"
 #include "omap_device.h"
@@ -47,13 +48,17 @@ static int __init omap_init_drm(void)
 	struct omap_hwmod *oh = NULL;
 	struct platform_device *pdev;
 
-	/* lookup and populate the DMM information, if present - OMAP4+ */
-	oh = omap_hwmod_lookup("dmm");
+	if (!of_find_compatible_node(NULL, NULL, "ti,dmm")) {
 
-	if (oh) {
-		pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
-		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
-			oh->name);
+		/* resort to hwmod lookup - LEGACY */
+		/* lookup and populate the DMM information, OMAP4+ only */
+		oh = omap_hwmod_lookup("dmm");
+
+		if (oh) {
+			pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
+			WARN(IS_ERR(pdev), "Could not build device for %s\n",
+				oh->name);
+		}
 	}
 
 	platform_data.omaprev = GET_OMAP_TYPE;
-- 
1.7.5.4

