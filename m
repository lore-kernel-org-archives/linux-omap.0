From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: Use PM notifiers for system suspend
Date: Wed, 27 Jun 2012 17:34:56 +0300
Message-ID: <1340807697-24847-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:51310 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850Ab2F0OfL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 10:35:11 -0400
Received: by lboj14 with SMTP id j14so2371737lbo.21
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 07:35:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The current way how omapdss handles system suspend and resume is that
omapdss device (a platform device, which is not part of the device
hierarchy of the DSS HW devices, like DISPC and DSI, or panels.) uses
the suspend and resume callbacks from platform_driver to handle system
suspend. It does this by disabling all enabled panels on suspend, and
resuming the previously disabled panels on resume.

This presents a few problems.

One is that as omapdss device is not related to the panel devices or the
DSS HW devices, there's no ordering in the suspend process. This means
that suspend could be first ran for DSS HW devices and panels, and only
then for omapdss device. Currently this is not a problem, as DSS HW
devices and panels do not handle suspend.

Another, more pressing problem, is that when suspending or resuming, the
runtime PM functions return -EACCES as runtime PM is disabled during
system suspend. This causes the driver to print warnings, and operations
to fail as they think that they failed to bring up the HW.

This patch changes the omapdss suspend handling to use PM notifiers,
which are called before suspend and after resume. This way we have a
normally functioning system when we are suspending and resuming the
panels.

This patch, I believe, creates a problem that somebody could enable or
disable a panel between PM_SUSPEND_PREPARE and the system suspend, and
similarly the other way around in resume. I choose to ignore the problem
for now, as it sounds rather unlikely, and if it happens, it's not
fatal.

In the long run the system suspend handling of omapdss and panels should
be thought out properly. The current approach feels rather hacky.
Perhaps the panel drivers should handle system suspend, or the users of
omapdss (omapfb, omapdrm) should handle system suspend.

Note that after this patch we could probably revert
0eaf9f52e94f756147dbfe1faf1f77a02378dbf9 (OMAPDSS: use sync versions of
pm_runtime_put). But as I said, this patch may be temporary, so let's
leave the sync version still in place.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/core.c |   45 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index d9b0bf3..e4fadf9 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
 
 #include <video/omapdss.h>
 
@@ -207,6 +208,30 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
+static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
+{
+	DSSDBG("pm notif %lu\n", v);
+
+	switch (v)
+	{
+	case PM_SUSPEND_PREPARE:
+		DSSDBG("suspending displays\n");
+		return dss_suspend_all_devices();
+
+	case PM_POST_SUSPEND:
+		DSSDBG("resuming displays\n");
+		return dss_resume_all_devices();
+
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block omap_dss_pm_notif_block =
+{
+	.notifier_call = omap_dss_pm_notif,
+};
+
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
@@ -230,6 +255,8 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	else if (pdata->default_device)
 		core.default_display_name = pdata->default_device->name;
 
+	register_pm_notifier(&omap_dss_pm_notif_block);
+
 	return 0;
 
 err_debugfs:
@@ -239,6 +266,8 @@ err_debugfs:
 
 static int omap_dss_remove(struct platform_device *pdev)
 {
+	unregister_pm_notifier(&omap_dss_pm_notif_block);
+
 	dss_uninitialize_debugfs();
 
 	dss_uninit_overlays(pdev);
@@ -253,25 +282,9 @@ static void omap_dss_shutdown(struct platform_device *pdev)
 	dss_disable_all_devices();
 }
 
-static int omap_dss_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	DSSDBG("suspend %d\n", state.event);
-
-	return dss_suspend_all_devices();
-}
-
-static int omap_dss_resume(struct platform_device *pdev)
-{
-	DSSDBG("resume\n");
-
-	return dss_resume_all_devices();
-}
-
 static struct platform_driver omap_dss_driver = {
 	.remove         = omap_dss_remove,
 	.shutdown	= omap_dss_shutdown,
-	.suspend	= omap_dss_suspend,
-	.resume		= omap_dss_resume,
 	.driver         = {
 		.name   = "omapdss",
 		.owner  = THIS_MODULE,
-- 
1.7.9.5

