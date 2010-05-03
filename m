From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 10/21] OMAP: DSS2: Taal: Change DSI bus locking to avoid deadlock in ESD work
Date: Mon,  3 May 2010 09:18:30 +0300
Message-ID: <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34464 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585Ab0ECGSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:55 -0400
In-Reply-To: <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
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
index 6abb080..8dc8199 100644
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

