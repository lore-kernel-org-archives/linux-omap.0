From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 14/21] OMAP: DSS2: Taal: Add proper external TE support
Date: Wed,  5 May 2010 17:27:34 +0300
Message-ID: <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34135 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934822Ab0EEO2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:13 -0400
In-Reply-To: <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add gpio irq based external TE support with timeout.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   93 +++++++++++++++++++++++------
 1 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e32424c..0c259ab 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -28,7 +28,6 @@
 #include <linux/fb.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
-#include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -65,6 +64,8 @@
 /* #define TAAL_USE_ESD_CHECK */
 #define TAAL_ESD_CHECK_PERIOD	msecs_to_jiffies(5000)
 
+static irqreturn_t taal_te_isr(int irq, void *data);
+static void taal_te_timeout_work_callback(struct work_struct *work);
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
 struct taal_data {
@@ -85,7 +86,15 @@ struct taal_data {
 
 	bool te_enabled;
 	bool use_ext_te;
-	struct completion te_completion;
+
+	atomic_t do_update;
+	struct {
+		u16 x;
+		u16 y;
+		u16 w;
+		u16 h;
+	} update_region;
+	struct delayed_work te_timeout_work;
 
 	bool use_dsi_bl;
 
@@ -346,16 +355,6 @@ static void taal_get_resolution(struct omap_dss_device *dssdev,
 	}
 }
 
-static irqreturn_t taal_te_isr(int irq, void *data)
-{
-	struct omap_dss_device *dssdev = data;
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-
-	complete_all(&td->te_completion);
-
-	return IRQ_HANDLED;
-}
-
 static ssize_t taal_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -545,6 +544,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	mutex_init(&td->lock);
 
+	atomic_set(&td->do_update, 0);
+
 	td->esd_wq = create_singlethread_workqueue("taal_esd");
 	if (td->esd_wq == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
@@ -606,9 +607,12 @@ static int taal_probe(struct omap_dss_device *dssdev)
 			goto err_irq;
 		}
 
-		init_completion(&td->te_completion);
+		INIT_DELAYED_WORK_DEFERRABLE(&td->te_timeout_work,
+					taal_te_timeout_work_callback);
 
 		td->use_ext_te = true;
+
+		dev_dbg(&dssdev->dev, "Using GPIO TE\n");
 	}
 
 	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
@@ -909,6 +913,47 @@ static void taal_framedone_cb(int err, void *data)
 	dsi_bus_unlock();
 }
 
+static irqreturn_t taal_te_isr(int irq, void *data)
+{
+	struct omap_dss_device *dssdev = data;
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	int old;
+	int r;
+
+	old = atomic_cmpxchg(&td->do_update, 1, 0);
+
+	if (old) {
+		cancel_delayed_work(&td->te_timeout_work);
+
+		r = omap_dsi_update(dssdev, TCH,
+				td->update_region.x,
+				td->update_region.y,
+				td->update_region.w,
+				td->update_region.h,
+				taal_framedone_cb, dssdev);
+		if (r)
+			goto err;
+	}
+
+	return IRQ_HANDLED;
+err:
+	dev_err(&dssdev->dev, "start update failed\n");
+	dsi_bus_unlock();
+	return IRQ_HANDLED;
+}
+
+static void taal_te_timeout_work_callback(struct work_struct *work)
+{
+	struct taal_data *td = container_of(work, struct taal_data,
+					te_timeout_work.work);
+	struct omap_dss_device *dssdev = td->dssdev;
+
+	dev_err(&dssdev->dev, "TE not received for 250ms!\n");
+
+	atomic_set(&td->do_update, 0);
+	dsi_bus_unlock();
+}
+
 static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
@@ -933,10 +978,21 @@ static int taal_update(struct omap_dss_device *dssdev,
 	if (r)
 		goto err;
 
-	r = omap_dsi_update(dssdev, TCH, x, y, w, h,
-			taal_framedone_cb, dssdev);
-	if (r)
-		goto err;
+	if (td->te_enabled && td->use_ext_te) {
+		td->update_region.x = x;
+		td->update_region.y = y;
+		td->update_region.w = w;
+		td->update_region.h = h;
+		barrier();
+		schedule_delayed_work(&td->te_timeout_work,
+				msecs_to_jiffies(250));
+		atomic_set(&td->do_update, 1);
+	} else {
+		r = omap_dsi_update(dssdev, TCH, x, y, w, h,
+				taal_framedone_cb, dssdev);
+		if (r)
+			goto err;
+	}
 
 	/* note: no bus_unlock here. unlock is in framedone_cb */
 	mutex_unlock(&td->lock);
@@ -972,7 +1028,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(DCS_TEAR_OFF);
 
-	omapdss_dsi_enable_te(dssdev, enable);
+	if (!td->use_ext_te)
+		omapdss_dsi_enable_te(dssdev, enable);
 
 	/* XXX for some reason, DSI TE breaks if we don't wait here.
 	 * Panel bug? Needs more studying */
-- 
1.6.5.2

