From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/23] OMAPDSS: output: Add set/unset device ops for omap_dss_output
Date: Tue, 21 Aug 2012 11:28:10 +0530
Message-ID: <1345528711-27801-4-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab2HUGAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 02:00:21 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

An output entity represented by the struct omap_dss_output connects to a
omap_dss_device entity. Add functions to set or unset an output's device. This
is similar to how managers and devices were connected previously. An output can
connect to a device without being connected to a manager. However, the output
needs to eventually connect to a manager so that the connected panel can be
enabled.

Keep the omap_overlay_manager pointer in omap_dss_device for now to prevent
breaking things. This will be removed later when outputs are supported
completely.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/output.c |   67 ++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h          |    5 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 034ebbe..ac57b19 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -24,6 +24,70 @@
 #include "dss.h"
 
 static struct list_head output_list;
+static DEFINE_MUTEX(output_lock);
+
+static int dss_output_set_device(struct omap_dss_output *out,
+		struct omap_dss_device *dssdev)
+{
+	int r;
+
+	mutex_lock(&output_lock);
+
+	if (out->device) {
+		DSSERR("output already has device %s connected to it\n",
+			out->device->name);
+		r = -EINVAL;
+		goto err;
+	}
+
+	if (out->type != dssdev->type) {
+		DSSERR("output type and display type don't match\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	out->device = dssdev;
+	dssdev->output = out;
+
+	mutex_unlock(&output_lock);
+
+	return 0;
+err:
+	mutex_unlock(&output_lock);
+
+	return r;
+}
+
+static int dss_output_unset_device(struct omap_dss_output *out)
+{
+	int r;
+
+	mutex_lock(&output_lock);
+
+	if (!out->device) {
+		DSSERR("output doesn't have a device connected to it\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	if (out->device->state != OMAP_DSS_DISPLAY_DISABLED) {
+		DSSERR("device %s is not disabled, cannot unset device\n",
+				out->device->name);
+		r = -EINVAL;
+		goto err;
+	}
+
+	out->device->output = NULL;
+	out->device = NULL;
+
+	mutex_unlock(&output_lock);
+
+	return 0;
+err:
+	mutex_unlock(&output_lock);
+
+	return r;
+}
 
 struct omap_dss_output *dss_create_output(struct platform_device *pdev)
 {
@@ -35,6 +99,9 @@ struct omap_dss_output *dss_create_output(struct platform_device *pdev)
 
 	out->pdev = pdev;
 
+	out->set_device = &dss_output_set_device;
+	out->unset_device = &dss_output_unset_device;
+
 	list_add_tail(&out->list, &output_list);
 
 	return out;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0ba613f..2e40f27 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -518,6 +518,10 @@ struct omap_dss_output {
 	struct omap_overlay_manager *manager;
 
 	struct omap_dss_device *device;
+
+	int (*set_device) (struct omap_dss_output *out,
+		struct omap_dss_device *dssdev);
+	int (*unset_device) (struct omap_dss_output *out);
 };
 
 struct omap_dss_device {
@@ -619,6 +623,7 @@ struct omap_dss_device {
 	enum omap_display_caps caps;
 
 	struct omap_overlay_manager *manager;
+	struct omap_dss_output *output;
 
 	enum omap_dss_display_state state;
 
-- 
1.7.9.5

