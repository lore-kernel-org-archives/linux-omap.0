From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 10/21] OMAP: DSS2: Taal: Change DSI bus locking to avoid deadlock in ESD work
Date: Wed,  5 May 2010 17:27:30 +0300
Message-ID: <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34117 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934716Ab0EEO2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:03 -0400
In-Reply-To: <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Move dsi_bus_lock/unlock() out of taal_power_on/off() to avoid deadlock
in taal_esd_work().

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 214d3cf..af159c1 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -672,8 +672,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	/* it seems we have to wait a bit until taal is ready */
 	msleep(5);
 
-	dsi_bus_lock();
-
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
@@ -744,8 +742,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	omapdss_dsi_vc_enable_hs(TCH, true);
 
-	dsi_bus_unlock();
-
 	return 0;
 err:
 	dev_err(&dssdev->dev, "error while enabling panel, issuing HW reset\n");
@@ -754,8 +750,6 @@ err:
 
 	omapdss_dsi_display_disable(dssdev);
 err0:
-	dsi_bus_unlock();
-
 	return r;
 }
 
@@ -764,8 +758,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 
-	dsi_bus_lock();
-
 	cancel_delayed_work(&td->esd_work);
 
 	r = taal_dcs_write_0(DCS_DISPLAY_OFF);
@@ -784,8 +776,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	omapdss_dsi_display_disable(dssdev);
 
 	td->enabled = 0;
-
-	dsi_bus_unlock();
 }
 
 static int taal_enable(struct omap_dss_device *dssdev)
@@ -802,7 +792,12 @@ static int taal_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	dsi_bus_lock();
+
 	r = taal_power_on(dssdev);
+
+	dsi_bus_unlock();
+
 	if (r)
 		goto err;
 
@@ -825,9 +820,13 @@ static void taal_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&td->lock);
 
+	dsi_bus_lock();
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		taal_power_off(dssdev);
 
+	dsi_bus_unlock();
+
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	mutex_unlock(&td->lock);
@@ -847,7 +846,12 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	dsi_bus_lock();
+
 	taal_power_off(dssdev);
+
+	dsi_bus_unlock();
+
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
 	mutex_unlock(&td->lock);
@@ -872,7 +876,12 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
+	dsi_bus_lock();
+
 	r = taal_power_on(dssdev);
+
+	dsi_bus_unlock();
+
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	mutex_unlock(&td->lock);
-- 
1.6.5.2

