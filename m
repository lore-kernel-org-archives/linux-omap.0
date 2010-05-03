From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 14/21] OMAP: DSS2: Taal: Add proper external TE support
Date: Mon,  3 May 2010 09:18:34 +0300
Message-ID: <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
 <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34455 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab0ECGSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:54 -0400
In-Reply-To: <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add gpio irq based external TE support with timeout.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   94 +++++++++++++++++++++++------
 1 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0f62c96..c326e51 100644
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
@@ -604,9 +605,12 @@ static int taal_probe(struct omap_dss_device *dssdev)
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
@@ -615,6 +619,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err_sysfs;
 	}
 
+
 	taal_hw_reset(dssdev);
 
 	return 0;
@@ -909,6 +914,47 @@ static void taal_framedone_cb(int err, void *data)
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
@@ -933,10 +979,21 @@ static int taal_update(struct omap_dss_device *dssdev,
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
@@ -975,7 +1032,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(DCS_TEAR_OFF);
 
-	omapdss_dsi_enable_te(dssdev, enable);
+	if (!td->use_ext_te)
+		omapdss_dsi_enable_te(dssdev, enable);
 
 	/* XXX for some reason, DSI TE breaks if we don't wait here.
 	 * Panel bug? Needs more studying */
-- 
1.6.5.2

