From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP2+: Don't create DMM if DT present
Date: Wed, 20 Mar 2013 15:50:42 -0500
Message-ID: <1363812642-2921-3-git-send-email-andy.gross@ti.com>
References: <1363812642-2921-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3CTUuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 16:50:54 -0400
In-Reply-To: <1363812642-2921-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, devicetree-discuss@lists.ozlabs.org, Andy Gross <andy.gross@ti.com>

Added code to conditionally skip over creating a DMM device from the
hwmod information if there is a DMM node present in the DT.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 arch/arm/mach-omap2/drm.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 59a4af7..01a0c6a 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/omap_drm.h>
+#include <linux/of.h>
 
 #include "soc.h"
 #include "omap_device.h"
@@ -47,13 +48,18 @@ static int __init omap_init_drm(void)
 	struct omap_hwmod *oh = NULL;
 	struct platform_device *pdev;
 
-	/* lookup and populate the DMM information, if present - OMAP4+ */
-	oh = omap_hwmod_lookup("dmm");
+	if (!of_have_populated_dt()  ||
+		!of_find_compatible_node(NULL, NULL, "ti,dmm")) {
 
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

