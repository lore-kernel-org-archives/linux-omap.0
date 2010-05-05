From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 12/21] OMAP: DSS2: Taal: Change ESD work management
Date: Wed,  5 May 2010 17:27:32 +0300
Message-ID: <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34118 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934757Ab0EEO2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:04 -0400
In-Reply-To: <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Move ESD work queuing and cancelling out of taal_power_on/off() to avoid
problems related to taal_esd_work() calling the power on/off functions.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 7b5f845..fa4c67b 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -654,7 +654,7 @@ static void taal_remove(struct omap_dss_device *dssdev)
 	taal_bl_update_status(bldev);
 	backlight_device_unregister(bldev);
 
-	cancel_delayed_work_sync(&td->esd_work);
+	cancel_delayed_work(&td->esd_work);
 	destroy_workqueue(td->esd_wq);
 
 	/* reset, to be sure that the panel is in a valid state */
@@ -725,10 +725,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-#ifdef TAAL_USE_ESD_CHECK
-	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
-#endif
-
 	td->enabled = 1;
 
 	if (!td->intro_printed) {
@@ -758,8 +754,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 
-	cancel_delayed_work(&td->esd_work);
-
 	r = taal_dcs_write_0(DCS_DISPLAY_OFF);
 	if (!r) {
 		r = taal_sleep_in(td);
@@ -801,6 +795,10 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
+#ifdef TAAL_USE_ESD_CHECK
+	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
+#endif
+
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	mutex_unlock(&td->lock);
@@ -820,6 +818,8 @@ static void taal_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&td->lock);
 
+	cancel_delayed_work(&td->esd_work);
+
 	dsi_bus_lock();
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
@@ -846,6 +846,8 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	cancel_delayed_work(&td->esd_work);
+
 	dsi_bus_lock();
 
 	taal_power_off(dssdev);
@@ -882,10 +884,15 @@ static int taal_resume(struct omap_dss_device *dssdev)
 
 	dsi_bus_unlock();
 
-	if (r)
+	if (r) {
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-	else
+	} else {
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+#ifdef TAAL_USE_ESD_CHECK
+		queue_delayed_work(td->esd_wq, &td->esd_work,
+				TAAL_ESD_CHECK_PERIOD);
+#endif
+	}
 
 	mutex_unlock(&td->lock);
 
-- 
1.6.5.2

