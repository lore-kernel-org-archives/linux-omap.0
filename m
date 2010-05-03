From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 01/21] OMAP: DSS2: Taal: Add panel hardware reset
Date: Mon,  3 May 2010 09:18:21 +0300
Message-ID: <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30945 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab0ECGSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:50 -0400
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Issue a proper reset pulse on the reset line instead of just doing power
on/off.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   44 ++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index aaf5d30..43fce5f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -488,6 +488,22 @@ static struct attribute_group taal_attr_group = {
 	.attrs = taal_attrs,
 };
 
+static void taal_hw_reset(struct omap_dss_device *dssdev)
+{
+	if (dssdev->reset_gpio == -1)
+		return;
+
+	gpio_set_value(dssdev->reset_gpio, 1);
+	udelay(10);
+	/* reset the panel */
+	gpio_set_value(dssdev->reset_gpio, 0);
+	/* assert reset for at least 10us */
+	udelay(10);
+	gpio_set_value(dssdev->reset_gpio, 1);
+	/* wait 5ms after releasing reset */
+	msleep(5);
+}
+
 static int taal_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_properties props;
@@ -585,6 +601,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		goto err4;
 	}
 
+	taal_hw_reset(dssdev);
+
 	return 0;
 err4:
 	if (td->use_ext_te) {
@@ -626,6 +644,9 @@ static void taal_remove(struct omap_dss_device *dssdev)
 	cancel_delayed_work_sync(&td->esd_work);
 	destroy_workqueue(td->esd_wq);
 
+	/* reset, to be sure that the panel is in a valid state */
+	taal_hw_reset(dssdev);
+
 	kfree(td);
 }
 
@@ -652,6 +673,8 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	taal_hw_reset(dssdev);
+
 	omapdss_dsi_vc_enable_hs(TCH, false);
 
 	r = taal_sleep_out(td);
@@ -702,6 +725,10 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err:
+	dev_err(&dssdev->dev, "error while enabling panel, issuing HW reset\n");
+
+	taal_hw_reset(dssdev);
+
 	omapdss_dsi_display_disable(dssdev);
 err0:
 	dsi_bus_unlock();
@@ -714,16 +741,24 @@ err0:
 static void taal_power_off(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	int r;
 
 	dsi_bus_lock();
 
 	cancel_delayed_work(&td->esd_work);
 
-	taal_dcs_write_0(DCS_DISPLAY_OFF);
-	taal_sleep_in(td);
+	r = taal_dcs_write_0(DCS_DISPLAY_OFF);
+	if (!r) {
+		r = taal_sleep_in(td);
+		/* wait a bit so that the message goes through */
+		msleep(10);
+	}
 
-	/* wait a bit so that the message goes through */
-	msleep(10);
+	if (r) {
+		dev_err(&dssdev->dev,
+				"error disabling panel, issuing HW reset\n");
+		taal_hw_reset(dssdev);
+	}
 
 	omapdss_dsi_display_disable(dssdev);
 
@@ -1184,6 +1219,7 @@ err:
 	dev_err(&dssdev->dev, "performing LCD reset\n");
 
 	taal_power_off(dssdev);
+	taal_hw_reset(dssdev);
 	taal_power_on(dssdev);
 
 	dsi_bus_unlock();
-- 
1.6.5.2

