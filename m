From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] fbdev: omap2: remove potential format string leak
Date: Mon, 8 Jun 2015 15:30:53 -0700
Message-ID: <20150608223053.GA28939@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Kees Cook <keescook@chromium.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since kobject_init_and_add takes a format string, make sure that the
passed in name cannot be accidentally parsed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/omap2/dss/display-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/fbdev/omap2/dss/display-sysfs.c
index 12186557a9d4..6ad0991f8259 100644
--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -324,7 +324,7 @@ int display_init_sysfs(struct platform_device *pdev)
 
 	for_each_dss_dev(dssdev) {
 		r = kobject_init_and_add(&dssdev->kobj, &display_ktype,
-			&pdev->dev.kobj, dssdev->alias);
+			&pdev->dev.kobj, "%s", dssdev->alias);
 		if (r) {
 			DSSERR("failed to create sysfs files\n");
 			omap_dss_put_device(dssdev);
-- 
1.9.1


-- 
Kees Cook
Chrome OS Security
