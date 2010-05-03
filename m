From: Jani Nikula <ext-jani.1.nikula@Nokia.com>
Subject: [PATCH v2 12/21] OMAP: DSS2: Taal: Change ESD work management
Date: Mon,  3 May 2010 09:18:32 +0300
Message-ID: <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34459 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab0ECGSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:54 -0400
In-Reply-To: <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@Nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@Nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Move ESD work queuing and cancelling out of taal_power_on/off() to avoid
problems related to taal_esd_work() calling the power on/off functions.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 32e94bf..5b6c945 100644
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

