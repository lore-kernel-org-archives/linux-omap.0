From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/20] OMAPDSS: remove initial display code from omapdss
Date: Wed, 24 Oct 2012 12:28:56 +0300
Message-ID: <1351070951-18616-6-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59700 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338Ab2JXJ3e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:34 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently omapdss driver sets up the initial connections between
overlays, overlay manager and a panel, based on default display
parameter coming from the board file or via module parameters.

This is unnecessary, as it's the higher level component that should
decide what display to use and how. This patch removes the code from
omapdss, and implements similar code to omapfb.

The def_disp module parameter and the default display platform_data
parameter are kept in omapdss, but omapdss doesn't do anything with
them. It will just return the default display name with
dss_get_default_display_name() call, which omapfb uses. This is done to
keep the backward compatibility.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c           |    1 +
 drivers/video/omap2/dss/display.c        |   78 +++---------------------------
 drivers/video/omap2/omapfb/omapfb-main.c |   77 ++++++++++++++++++++++++-----
 include/video/omapdss.h                  |    1 +
 4 files changed, 75 insertions(+), 82 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 685d9a9..4cb669e 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -57,6 +57,7 @@ const char *dss_get_default_display_name(void)
 {
 	return core.default_display_name;
 }
+EXPORT_SYMBOL(dss_get_default_display_name);
 
 enum omapdss_version omapdss_get_version(void)
 {
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 1e58730..6d33112 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -320,86 +320,21 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_timings);
 
-/*
- * Connect dssdev to a manager if the manager is free or if force is specified.
- * Connect all overlays to that manager if they are free or if force is
- * specified.
- */
-static int dss_init_connections(struct omap_dss_device *dssdev, bool force)
+int dss_init_device(struct platform_device *pdev,
+		struct omap_dss_device *dssdev)
 {
+	struct device_attribute *attr;
 	struct omap_dss_output *out;
-	struct omap_overlay_manager *mgr;
 	int i, r;
 
 	out = omapdss_get_output_from_dssdev(dssdev);
 
-	WARN_ON(dssdev->output);
-	WARN_ON(out->device);
-
 	r = omapdss_output_set_device(out, dssdev);
 	if (r) {
 		DSSERR("failed to connect output to new device\n");
 		return r;
 	}
 
-	mgr = omap_dss_get_overlay_manager(dssdev->channel);
-
-	if (mgr->output && !force)
-		return 0;
-
-	if (mgr->output)
-		mgr->unset_output(mgr);
-
-	r = mgr->set_output(mgr, out);
-	if (r) {
-		DSSERR("failed to connect manager to output of new device\n");
-
-		/* remove the output-device connection we just made */
-		omapdss_output_unset_device(out);
-		return r;
-	}
-
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-		struct omap_overlay *ovl = omap_dss_get_overlay(i);
-
-		if (!ovl->manager || force) {
-			if (ovl->manager)
-				ovl->unset_manager(ovl);
-
-			r = ovl->set_manager(ovl, mgr);
-			if (r) {
-				DSSERR("failed to set initial overlay\n");
-				return r;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static void dss_uninit_connections(struct omap_dss_device *dssdev)
-{
-	if (dssdev->output) {
-		struct omap_overlay_manager *mgr = dssdev->output->manager;
-
-		if (mgr)
-			mgr->unset_output(mgr);
-
-		omapdss_output_unset_device(dssdev->output);
-	}
-}
-
-int dss_init_device(struct platform_device *pdev,
-		struct omap_dss_device *dssdev)
-{
-	struct device_attribute *attr;
-	int i, r;
-	const char *def_disp_name = dss_get_default_display_name();
-	bool force;
-
-	force = def_disp_name && strcmp(def_disp_name, dssdev->name) == 0;
-	dss_init_connections(dssdev, force);
-
 	/* create device sysfs files */
 	i = 0;
 	while ((attr = display_sysfs_attrs[i++]) != NULL) {
@@ -410,7 +345,7 @@ int dss_init_device(struct platform_device *pdev,
 				device_remove_file(&dssdev->dev, attr);
 			}
 
-			dss_uninit_connections(dssdev);
+			omapdss_output_unset_device(dssdev->output);
 
 			DSSERR("failed to create sysfs file\n");
 			return r;
@@ -424,7 +359,7 @@ int dss_init_device(struct platform_device *pdev,
 		while ((attr = display_sysfs_attrs[i++]) != NULL)
 			device_remove_file(&dssdev->dev, attr);
 
-		dss_uninit_connections(dssdev);
+		omapdss_output_unset_device(dssdev->output);
 
 		DSSERR("failed to create sysfs display link\n");
 		return r;
@@ -444,7 +379,8 @@ void dss_uninit_device(struct platform_device *pdev,
 	while ((attr = display_sysfs_attrs[i++]) != NULL)
 		device_remove_file(&dssdev->dev, attr);
 
-	dss_uninit_connections(dssdev);
+	if (dssdev->output)
+		omapdss_output_unset_device(dssdev->output);
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index ba46308..c0ff8b5ad 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2369,15 +2369,52 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 	return 0;
 }
 
+static int omapfb_init_connections(struct omapfb2_device *fbdev,
+		struct omap_dss_device *dssdev)
+{
+	int i, r;
+	struct omap_overlay_manager *mgr = NULL;
+
+	for (i = 0; i < fbdev->num_managers; i++) {
+		mgr = fbdev->managers[i];
+
+		if (dssdev->channel == mgr->id)
+			break;
+	}
+
+	if (i == fbdev->num_managers)
+		return -ENODEV;
+
+	if (mgr->output)
+		mgr->unset_output(mgr);
+
+	r = mgr->set_output(mgr, dssdev->output);
+	if (r)
+		return r;
+
+	for (i = 0; i < fbdev->num_overlays; i++) {
+		struct omap_overlay *ovl = fbdev->overlays[i];
+
+		if (ovl->manager)
+			ovl->unset_manager(ovl);
+
+		r = ovl->set_manager(ovl, mgr);
+		if (r)
+			dev_warn(fbdev->dev,
+					"failed to connect overlay %s to manager %s\n",
+					ovl->name, mgr->name);
+	}
+
+	return 0;
+}
+
 static int __init omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
 	int r = 0;
 	int i;
-	struct omap_overlay *ovl;
 	struct omap_dss_device *def_display;
 	struct omap_dss_device *dssdev;
-	struct omap_dss_device *ovl_device;
 
 	DBG("omapfb_probe\n");
 
@@ -2445,15 +2482,33 @@ static int __init omapfb_probe(struct platform_device *pdev)
 	for (i = 0; i < fbdev->num_managers; i++)
 		fbdev->managers[i] = omap_dss_get_overlay_manager(i);
 
-	/* gfx overlay should be the default one. find a display
-	 * connected to that, and use it as default display */
-	ovl = omap_dss_get_overlay(0);
-	ovl_device = ovl->get_device(ovl);
-	if (ovl_device) {
-		def_display = ovl_device;
-	} else {
-		dev_warn(&pdev->dev, "cannot find default display\n");
-		def_display = NULL;
+	def_display = NULL;
+
+	for (i = 0; i < fbdev->num_displays; ++i) {
+		struct omap_dss_device *dssdev;
+		const char *def_name;
+
+		def_name = dss_get_default_display_name();
+
+		dssdev = fbdev->displays[i].dssdev;
+
+		if (def_name == NULL ||
+			(dssdev->name && strcmp(def_name, dssdev->name) == 0)) {
+			def_display = dssdev;
+			break;
+		}
+	}
+
+	if (def_display == NULL) {
+		dev_err(fbdev->dev, "failed to find default display\n");
+		r = -EINVAL;
+		goto cleanup;
+	}
+
+	r = omapfb_init_connections(fbdev, def_display);
+	if (r) {
+		dev_err(fbdev->dev, "failed to init overlay connections\n");
+		goto cleanup;
 	}
 
 	if (def_mode && strlen(def_mode) > 0) {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index eac5f25..b2f5b23 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -753,6 +753,7 @@ void omap_dss_put_device(struct omap_dss_device *dssdev);
 struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from);
 struct omap_dss_device *omap_dss_find_device(void *data,
 		int (*match)(struct omap_dss_device *dssdev, void *data));
+const char *dss_get_default_display_name(void);
 
 int omap_dss_start_device(struct omap_dss_device *dssdev);
 void omap_dss_stop_device(struct omap_dss_device *dssdev);
-- 
1.7.9.5

