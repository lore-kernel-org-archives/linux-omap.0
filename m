From: Afzal Mohammed <lazfamam@gmail.com>
Subject: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Date: Thu,  1 Jul 2010 19:10:01 +0530
Message-ID: <1277991601-16528-2-git-send-email-lazfamam@gmail.com>
References: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ville.syrjala@nokia.com, tj@kernel.org, lazfamam@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Move sysfs entry creation to omapfb_probe() from omapfb_create_framebuffers().
This will make sure that sysfs entry is not left behind in case of unsuccessful
probe due to failure in enabling fb0 of omapfb_create_framebuffers().

Signed-off-by: Afzal Mohammed <lazfamam@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..710e117 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1928,13 +1928,6 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 		}
 	}
 
-	DBG("create sysfs for fbs\n");
-	r = omapfb_create_sysfs(fbdev);
-	if (r) {
-		dev_err(fbdev->dev, "failed to create sysfs entries\n");
-		return r;
-	}
-
 	/* Enable fb0 */
 	if (fbdev->num_fbs > 0) {
 		struct omapfb_info *ofbi = FB2OFB(fbdev->fbs[0]);
@@ -2220,6 +2213,13 @@ static int omapfb_probe(struct platform_device *pdev)
 		}
 	}
 
+	DBG("create sysfs for fbs\n");
+	r = omapfb_create_sysfs(fbdev);
+	if (r) {
+		dev_err(fbdev->dev, "failed to create sysfs entries\n");
+		goto cleanup;
+	}
+
 	return 0;
 
 cleanup:
-- 
1.7.0.4
