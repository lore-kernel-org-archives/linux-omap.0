From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 03/13] OMAP: DSS: Taal: fix error returns in taal_probe()
Date: Mon,  8 Feb 2010 17:56:02 +0200
Message-ID: <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64990 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab0BHPyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:54:00 -0500
In-Reply-To: <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Aaro Koskinen <aaro.koskinen@nokia.com>

The workqueue creation error branch attempted to destroy a NULL wq,
and, in turn, a failed registration does not destroy the newly created
workqueue.

The problem was reported by a static analysis tool.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 1f01dfc..0aaaa8a 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -510,7 +510,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	if (td->esd_wq == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
 		r = -ENOMEM;
-		goto err2;
+		goto err1;
 	}
 	INIT_DELAYED_WORK_DEFERRABLE(&td->esd_work, taal_esd_work);
 
@@ -528,7 +528,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 			&taal_bl_ops);
 	if (IS_ERR(bldev)) {
 		r = PTR_ERR(bldev);
-		goto err1;
+		goto err2;
 	}
 
 	td->bldev = bldev;
-- 
1.6.5

