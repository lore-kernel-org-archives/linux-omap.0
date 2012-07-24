From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] OMAPDSS: DISPC: Use msleep instead of blocking mdelay
Date: Tue, 24 Jul 2012 19:33:55 +0530
Message-ID: <1343138635-2802-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46191 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab2GXOEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 10:04:08 -0400
Received: by pbbrp8 with SMTP id rp8so12732357pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 07:04:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, a0393947@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>

We have no reason to block in the error handler workqueue, so use msleep.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index c56a51a..0e3ad44 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3492,7 +3492,7 @@ static void dispc_error_worker(struct work_struct *work)
 					ovl->name);
 			dispc_ovl_enable(ovl->id, false);
 			dispc_mgr_go(ovl->manager->id);
-			mdelay(50);
+			msleep(50);
 		}
 	}
 
@@ -3524,7 +3524,7 @@ static void dispc_error_worker(struct work_struct *work)
 			}
 
 			dispc_mgr_go(mgr->id);
-			mdelay(50);
+			msleep(50);
 
 			if (enable)
 				dssdev->driver->enable(dssdev);
-- 
1.7.4.1

