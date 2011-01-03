From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 10/17] OMAP2,3: DSS2: Move dss_feature_init to dss
Date: Mon,  3 Jan 2011 18:21:02 +0530
Message-ID: <1294059069-26737-11-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841Ab1ACMvo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 07:51:44 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move dss_feature_init call from core to dss as it involves DSS HW related
configuration.  This movement is must since dsshw_probe would be called
first in which the registers are accessed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 --
 drivers/video/omap2/dss/dss.c  |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index a6b3b61..0d5f6dd 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -187,8 +187,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	core.pdev = pdev;
 
-	dss_features_init();
-
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 59a632d..99dd490 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -33,6 +33,7 @@
 #include <plat/display.h>
 #include <plat/clock.h>
 #include "dss.h"
+#include "dss_features.h"
 
 #define DSS_BASE			0x48050000
 
@@ -966,6 +967,8 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 
 	dss.pdev = pdev;
 
+	dss_features_init();
+
 	r = dss_get_clocks();
 	if (r)
 		goto err_clocks;
-- 
1.6.3.3

